package com.denuoweb.language_tutor

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class RayBanBridge : MethodChannel.MethodCallHandler {
    private var previewSink: EventChannel.EventSink? = null
    private var captureSink: EventChannel.EventSink? = null

    fun register(flutterEngine: FlutterEngine) {
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
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
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

    private fun availabilityMessage(): String {
        if (!BuildConfig.META_DAT_ENABLED) {
            return "Meta DAT Android build is disabled. Set meta.dat.enabled=true and provide github_token plus meta.dat.application.id in android/local.properties."
        }
        return "Meta DAT Android dependencies are enabled for application ID ${BuildConfig.META_DAT_APPLICATION_ID}, but the native session implementation still needs to be connected to the official SDK APIs."
    }

    private val unavailableMessage: String
        get() = availabilityMessage()
}
