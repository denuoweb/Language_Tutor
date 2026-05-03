package com.denuoweb.language_tutor

import androidx.activity.ComponentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class RayBanBridge : MethodChannel.MethodCallHandler, RayBanEventDelegate {
    private var previewSink: EventChannel.EventSink? = null
    private var captureSink: EventChannel.EventSink? = null
    private val runtime = createRuntime()

    fun register(activity: ComponentActivity, flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            METHODS_CHANNEL,
        ).setMethodCallHandler(this)

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            PREVIEW_FRAMES_CHANNEL,
        ).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    previewSink = events
                }

                override fun onCancel(arguments: Any?) {
                    previewSink = null
                }
            },
        )

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CAPTURE_FRAMES_CHANNEL,
        ).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    captureSink = events
                }

                override fun onCancel(arguments: Any?) {
                    captureSink = null
                }
            },
        )

        runtime?.attach(activity = activity, delegate = this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val runtime = runtime
        if (runtime != null) {
            when (call.method) {
                "getAvailability" -> result.success(runtime.getAvailability())
                "startPreview" -> runtime.startPreview(result)
                "stopPreview" -> runtime.stopPreview(result)
                "startCapture" -> {
                    val args = call.arguments as? Map<*, *>
                    val intervalMillis = (args?.get("intervalMillis") as? Number)?.toLong() ?: 0L
                    runtime.startCapture(intervalMillis = intervalMillis, result = result)
                }
                "stopCapture" -> runtime.stopCapture(result)
                else -> result.notImplemented()
            }
            return
        }

        when (call.method) {
            "getAvailability" ->
                result.success(
                    mapOf(
                        "isSupported" to BuildConfig.META_DAT_ENABLED,
                        "isConnected" to false,
                        "message" to availabilityMessage(),
                    ),
                )

            "startPreview",
            "startCapture",
            -> result.error("unavailable", unavailableMessage, null)

            "stopPreview",
            "stopCapture",
            -> result.success(null)

            else -> result.notImplemented()
        }
    }

    companion object {
        private const val METHODS_CHANNEL = "language_tutor/ray_ban/methods"
        private const val PREVIEW_FRAMES_CHANNEL = "language_tutor/ray_ban/preview_frames"
        private const val CAPTURE_FRAMES_CHANNEL = "language_tutor/ray_ban/capture_frames"
    }

    override fun emitPreviewFrame(event: Map<String, Any>) {
        previewSink?.success(event)
    }

    override fun emitCaptureFrame(event: Map<String, Any>) {
        captureSink?.success(event)
    }

    private fun createRuntime(): RayBanBridgeRuntime? {
        return try {
            val runtimeClass = Class.forName("com.denuoweb.language_tutor.RayBanDatRuntime")
            runtimeClass.getDeclaredConstructor().newInstance() as RayBanBridgeRuntime
        } catch (_: ClassNotFoundException) {
            null
        } catch (_: NoClassDefFoundError) {
            null
        } catch (_: Throwable) {
            null
        }
    }

    private fun availabilityMessage(): String {
        if (!BuildConfig.META_DAT_ENABLED) {
            return "Meta DAT Android build is disabled. Set meta.dat.enabled=true and provide github_token plus meta.dat.application.id in android/local.properties."
        }
        return "Meta DAT Android dependencies are enabled for application ID ${BuildConfig.META_DAT_APPLICATION_ID}, but the native runtime was not loaded. Rebuild with Meta DAT enabled."
    }

    private val unavailableMessage: String
        get() = availabilityMessage()
}

interface RayBanEventDelegate {
    fun emitPreviewFrame(event: Map<String, Any>)

    fun emitCaptureFrame(event: Map<String, Any>)
}

interface RayBanBridgeRuntime {
    fun attach(activity: ComponentActivity, delegate: RayBanEventDelegate)

    fun getAvailability(): Map<String, Any>

    fun startPreview(result: MethodChannel.Result)

    fun stopPreview(result: MethodChannel.Result)

    fun startCapture(intervalMillis: Long, result: MethodChannel.Result)

    fun stopCapture(result: MethodChannel.Result)
}
