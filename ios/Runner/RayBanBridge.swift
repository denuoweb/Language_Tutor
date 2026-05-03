import Flutter
import Foundation

final class RayBanBridge: NSObject {
  private static let methodsChannel = "language_tutor/ray_ban/methods"
  private static let previewFramesChannel = "language_tutor/ray_ban/preview_frames"
  private static let captureFramesChannel = "language_tutor/ray_ban/capture_frames"

  private let unavailableMessage =
    "Ray-Ban iOS capture is not connected yet. Add the Meta DAT SDK and bridge implementation to enable live POV and photo capture."

  private static var retainedBridges: [RayBanBridge] = []

  private var previewSink: FlutterEventSink?
  private var captureSink: FlutterEventSink?

  static func register(with messenger: FlutterBinaryMessenger) {
    let bridge = RayBanBridge()

    let methodChannel = FlutterMethodChannel(
      name: methodsChannel,
      binaryMessenger: messenger
    )
    methodChannel.setMethodCallHandler(bridge.handle)

    let previewChannel = FlutterEventChannel(
      name: previewFramesChannel,
      binaryMessenger: messenger
    )
    previewChannel.setStreamHandler(PreviewStreamHandler(bridge: bridge))

    let captureChannel = FlutterEventChannel(
      name: captureFramesChannel,
      binaryMessenger: messenger
    )
    captureChannel.setStreamHandler(CaptureStreamHandler(bridge: bridge))
    retainedBridges.append(bridge)
  }

  private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getAvailability":
      result([
        "isSupported": false,
        "isConnected": false,
        "message":
          "Ray-Ban iOS bridge is registered, but the Meta DAT SDK is not wired into this build yet.",
      ])
    case "startPreview", "startCapture":
      result(
        FlutterError(
          code: "unavailable",
          message: unavailableMessage,
          details: nil
        ))
    case "stopPreview", "stopCapture":
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  fileprivate func attachPreviewSink(_ sink: FlutterEventSink?) {
    previewSink = sink
  }

  fileprivate func attachCaptureSink(_ sink: FlutterEventSink?) {
    captureSink = sink
  }
}

private final class PreviewStreamHandler: NSObject, FlutterStreamHandler {
  init(bridge: RayBanBridge) {
    self.bridge = bridge
  }

  private let bridge: RayBanBridge

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink)
    -> FlutterError?
  {
    bridge.attachPreviewSink(events)
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    bridge.attachPreviewSink(nil)
    return nil
  }
}

private final class CaptureStreamHandler: NSObject, FlutterStreamHandler {
  init(bridge: RayBanBridge) {
    self.bridge = bridge
  }

  private let bridge: RayBanBridge

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink)
    -> FlutterError?
  {
    bridge.attachCaptureSink(events)
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    bridge.attachCaptureSink(nil)
    return nil
  }
}
