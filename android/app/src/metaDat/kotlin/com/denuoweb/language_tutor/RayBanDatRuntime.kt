package com.denuoweb.language_tutor

import android.Manifest
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.os.Build
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts.RequestMultiplePermissions
import androidx.core.content.ContextCompat
import com.meta.wearable.dat.camera.Stream
import com.meta.wearable.dat.camera.addStream
import com.meta.wearable.dat.camera.types.StreamConfiguration
import com.meta.wearable.dat.camera.types.StreamError
import com.meta.wearable.dat.camera.types.VideoFrame
import com.meta.wearable.dat.camera.types.VideoQuality
import com.meta.wearable.dat.core.Wearables
import com.meta.wearable.dat.core.selectors.AutoDeviceSelector
import com.meta.wearable.dat.core.types.DeviceIdentifier
import com.meta.wearable.dat.core.types.Permission
import com.meta.wearable.dat.core.types.PermissionStatus
import com.meta.wearable.dat.core.types.RegistrationState
import com.meta.wearable.dat.core.session.DeviceSessionState
import com.meta.wearable.dat.core.session.Session
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
import kotlin.coroutines.resume
import kotlinx.coroutines.CancellableContinuation
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import kotlinx.coroutines.suspendCancellableCoroutine

class RayBanDatRuntime : RayBanBridgeRuntime {
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main.immediate)

    private lateinit var activity: ComponentActivity
    private lateinit var delegate: RayBanEventDelegate
    private val deviceSelector = AutoDeviceSelector()

    private var androidPermissionLauncher: ActivityResultLauncher<Array<String>>? = null
    private var wearablesPermissionLauncher: ActivityResultLauncher<Permission>? = null
    private var androidPermissionContinuation: CancellableContinuation<Boolean>? = null
    private var wearablesPermissionContinuation: CancellableContinuation<PermissionStatus>? = null

    private var initialized = false
    private var monitoringStarted = false
    private var registrationState: RegistrationState? = null
    private var devices: Set<DeviceIdentifier> = emptySet()

    private var previewActive = false
    private var captureActive = false
    private var captureIntervalMillis = 0L
    private var lastCaptureAtMillis = 0L

    private var session: Session? = null
    private var stream: Stream? = null
    private var registrationJob: Job? = null
    private var devicesJob: Job? = null
    private var sessionStateJob: Job? = null
    private var streamStateJob: Job? = null
    private var streamErrorJob: Job? = null
    private var videoJob: Job? = null

    override fun attach(activity: ComponentActivity, delegate: RayBanEventDelegate) {
        this.activity = activity
        this.delegate = delegate
        androidPermissionLauncher =
            activity.registerForActivityResult(RequestMultiplePermissions()) { result ->
                androidPermissionContinuation?.resume(result.values.all { it })
                androidPermissionContinuation = null
            }
        wearablesPermissionLauncher =
            activity.registerForActivityResult(Wearables.RequestPermissionContract()) { result ->
                wearablesPermissionContinuation?.resume(
                    result.getOrDefault(PermissionStatus.Denied),
                )
                wearablesPermissionContinuation = null
            }
    }

    override fun getAvailability(): Map<String, Any> {
        return mapOf(
            "isSupported" to true,
            "isConnected" to isConnected(),
            "message" to availabilityMessage(),
        )
    }

    override fun startPreview(result: MethodChannel.Result) {
        scope.launch {
            val failure = ensurePreviewReady()
            if (failure != null) {
                result.error(failure.code, failure.message, null)
                return@launch
            }

            previewActive = true
            ensureSessionStateCollector()
            session?.start()
            result.success(null)
        }
    }

    override fun stopPreview(result: MethodChannel.Result) {
        previewActive = false
        captureActive = false
        captureIntervalMillis = 0L
        lastCaptureAtMillis = 0L
        stopStreaming()
        result.success(null)
    }

    override fun startCapture(intervalMillis: Long, result: MethodChannel.Result) {
        scope.launch {
            val failure = ensurePreviewReady()
            if (failure != null) {
                result.error(failure.code, failure.message, null)
                return@launch
            }

            previewActive = true
            captureActive = true
            captureIntervalMillis = intervalMillis.coerceAtLeast(500L)
            lastCaptureAtMillis = 0L
            ensureSessionStateCollector()
            session?.start()
            result.success(null)
        }
    }

    override fun stopCapture(result: MethodChannel.Result) {
        captureActive = false
        captureIntervalMillis = 0L
        lastCaptureAtMillis = 0L
        result.success(null)
    }

    private suspend fun ensurePreviewReady(): BridgeFailure? {
        if (!hasAndroidPermissions()) {
            val granted = requestAndroidPermissions()
            if (!granted) {
                return BridgeFailure(
                    code = "android_permissions_required",
                    message =
                        "Allow Bluetooth and camera access for Ray-Ban preview, then try again.",
                )
            }
        }

        try {
            ensureInitialized()
        } catch (error: Throwable) {
            return BridgeFailure(
                code = "initialize_failed",
                message = error.message ?: "Meta DAT failed to initialize on Android.",
            )
        }

        val state = registrationState
        if (state !is RegistrationState.Registered) {
            Wearables.startRegistration(activity)
            return BridgeFailure(
                code = "registration_required",
                message =
                    "Complete the Meta AI registration flow, then return to the app and tap Refresh.",
            )
        }

        val permission = ensureWearablesCameraPermission()
        if (permission != PermissionStatus.Granted) {
            return BridgeFailure(
                code = "wearables_permission_required",
                message =
                    "Camera access for the Ray-Ban session was not granted in Meta AI.",
            )
        }

        if (devices.isEmpty()) {
            return BridgeFailure(
                code = "device_not_connected",
                message =
                    "No compatible Ray-Ban device is connected. Open the glasses and confirm they are linked in Meta AI.",
            )
        }

        ensureSession()
        return null
    }

    private fun ensureSession() {
        if (session != null) {
            return
        }

        Wearables.createSession(deviceSelector)
            .onSuccess { createdSession ->
                session = createdSession
            }
            .onFailure { error, _ ->
                throw IllegalStateException(
                    "Failed to create Meta DAT session: ${error.description}",
                )
            }
    }

    private fun ensureSessionStateCollector() {
        if (sessionStateJob != null) {
            return
        }

        val activeSession = session ?: return
        sessionStateJob =
            scope.launch {
                activeSession.state.collect { state ->
                    if (state == DeviceSessionState.STARTED) {
                        ensureStreamStarted(activeSession)
                    } else if (!previewActive && !captureActive) {
                        stopStreaming()
                    }
                }
            }
    }

    private fun ensureStreamStarted(activeSession: Session) {
        if (stream != null) {
            return
        }

        activeSession
            .addStream(StreamConfiguration(videoQuality = VideoQuality.MEDIUM, 24))
            .onSuccess { addedStream ->
                stream = addedStream
                bindStream(addedStream)
                addedStream.start()
            }
            .onFailure { error, _ ->
                throw IllegalStateException(
                    "Failed to start Meta DAT camera stream: ${error.description}",
                )
            }
    }

    private fun bindStream(activeStream: Stream) {
        videoJob?.cancel()
        streamStateJob?.cancel()
        streamErrorJob?.cancel()

        videoJob =
            scope.launch {
                activeStream.videoStream.collect { frame ->
                    handleVideoFrame(frame)
                }
            }

        streamStateJob =
            scope.launch {
                activeStream.state.collect { _ ->
                    // Preview state is driven by frame delivery and stop/start calls.
                }
            }

        streamErrorJob =
            scope.launch {
                activeStream.errorStream.collect { error ->
                    if (error == StreamError.HINGE_CLOSED) {
                        previewActive = false
                        captureActive = false
                        stopStreaming()
                    }
                }
            }
    }

    private fun handleVideoFrame(frame: VideoFrame) {
        val bitmap =
            YuvToBitmapConverter.convert(
                yuvData = frame.buffer,
                width = frame.width,
                height = frame.height,
            ) ?: return

        val bytes = bitmap.toJpegBytes() ?: return
        val now = System.currentTimeMillis()
        val event = frameEvent(bytes = bytes, capturedAtMillis = now)
        if (previewActive) {
            delegate.emitPreviewFrame(event)
        }

        if (captureActive && now - lastCaptureAtMillis >= captureIntervalMillis) {
            lastCaptureAtMillis = now
            delegate.emitCaptureFrame(event)
        }
    }

    private suspend fun ensureInitialized() {
        if (initialized) {
            return
        }

        Wearables.initialize(activity)
        initialized = true
        startMonitoring()
    }

    private fun startMonitoring() {
        if (monitoringStarted) {
            return
        }
        monitoringStarted = true

        registrationJob =
            scope.launch {
                Wearables.registrationState.collect { state ->
                    registrationState = state
                }
            }

        devicesJob =
            scope.launch {
                Wearables.devices.collect { currentDevices ->
                    devices = currentDevices.toSet()
                }
            }
    }

    private suspend fun ensureWearablesCameraPermission(): PermissionStatus {
        val statusResult = Wearables.checkPermissionStatus(Permission.CAMERA)
        val currentStatus = statusResult.getOrNull()
        if (currentStatus == PermissionStatus.Granted) {
            return PermissionStatus.Granted
        }

        val launcher = wearablesPermissionLauncher
            ?: return PermissionStatus.Denied

        return suspendCancellableCoroutine { continuation ->
            wearablesPermissionContinuation = continuation
            continuation.invokeOnCancellation {
                if (wearablesPermissionContinuation === continuation) {
                    wearablesPermissionContinuation = null
                }
            }
            launcher.launch(Permission.CAMERA)
        }
    }

    private suspend fun requestAndroidPermissions(): Boolean {
        val launcher = androidPermissionLauncher ?: return false
        return suspendCancellableCoroutine { continuation ->
            androidPermissionContinuation = continuation
            continuation.invokeOnCancellation {
                if (androidPermissionContinuation === continuation) {
                    androidPermissionContinuation = null
                }
            }
            launcher.launch(requiredAndroidPermissions())
        }
    }

    private fun hasAndroidPermissions(): Boolean {
        return requiredAndroidPermissions().all { permission ->
            ContextCompat.checkSelfPermission(activity, permission) == PackageManager.PERMISSION_GRANTED
        }
    }

    private fun requiredAndroidPermissions(): Array<String> {
        val permissions = mutableListOf(Manifest.permission.CAMERA)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            permissions += Manifest.permission.BLUETOOTH_CONNECT
        }
        return permissions.toTypedArray()
    }

    private fun stopStreaming() {
        videoJob?.cancel()
        videoJob = null
        streamStateJob?.cancel()
        streamStateJob = null
        streamErrorJob?.cancel()
        streamErrorJob = null
        sessionStateJob?.cancel()
        sessionStateJob = null
        stream?.stop()
        stream = null
        session?.stop()
        session = null
    }

    private fun isConnected(): Boolean {
        return registrationState is RegistrationState.Registered && devices.isNotEmpty()
    }

    private fun availabilityMessage(): String {
        if (!BuildConfig.META_DAT_ENABLED) {
            return "Meta DAT Android build is disabled."
        }
        if (!hasAndroidPermissions()) {
            return "Bluetooth and camera access are required before the Ray-Ban session can start."
        }
        if (!initialized) {
            return "Meta DAT is configured. Start the Ray-Ban preview to initialize the glasses session."
        }
        if (registrationState !is RegistrationState.Registered) {
            return "Ray-Ban registration is required. Start the preview to open the Meta AI registration flow."
        }
        if (devices.isEmpty()) {
            return "Ray-Ban registration is complete, but no connected glasses are currently available."
        }
        return "Ray-Ban ready. Start preview to see the live POV stream."
    }

    private fun frameEvent(bytes: ByteArray, capturedAtMillis: Long): Map<String, Any> {
        return mapOf(
            "bytes" to bytes,
            "capturedAtMillis" to capturedAtMillis,
            "mimeType" to "image/jpeg",
            "source" to "ray_ban",
        )
    }

    private fun Bitmap.toJpegBytes(): ByteArray? {
        val output = ByteArrayOutputStream()
        return try {
            if (compress(Bitmap.CompressFormat.JPEG, 82, output)) {
                output.toByteArray()
            } else {
                null
            }
        } finally {
            output.close()
        }
    }
}

private data class BridgeFailure(
    val code: String,
    val message: String,
)
