import Flutter
import Foundation
import UIKit

#if canImport(MWDATCamera) && canImport(MWDATCore)
import MWDATCamera
import MWDATCore
#endif

final class RayBanBridge: NSObject {
  private static let methodsChannel = "language_tutor/ray_ban/methods"
  private static let previewFramesChannel = "language_tutor/ray_ban/preview_frames"
  private static let captureFramesChannel = "language_tutor/ray_ban/capture_frames"

  private static let callbackScheme = "language-tutor://"
  private static let runtime = RayBanDatRuntime()
  private static var retainedBridges: [RayBanBridge] = []

  static func configureWearablesIfAvailable() {
    runtime.configureIfAvailable()
  }

  static func handleIncomingURL(_ url: URL) {
    runtime.handleIncomingURL(url)
  }

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
      result(Self.runtime.getAvailability())
    case "startPreview":
      Self.runtime.startPreview(result: result)
    case "stopPreview":
      Self.runtime.stopPreview(result: result)
    case "startCapture":
      let intervalMillis = (call.arguments as? [String: Any])?["intervalMillis"] as? Int ?? 0
      Self.runtime.startCapture(intervalMillis: intervalMillis, result: result)
    case "stopCapture":
      Self.runtime.stopCapture(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  fileprivate func attachPreviewSink(_ sink: FlutterEventSink?) {
    Self.runtime.attachPreviewSink(sink)
  }

  fileprivate func attachCaptureSink(_ sink: FlutterEventSink?) {
    Self.runtime.attachCaptureSink(sink)
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

private final class RayBanDatRuntime {
  private var previewSink: FlutterEventSink?
  private var captureSink: FlutterEventSink?

  #if canImport(MWDATCamera) && canImport(MWDATCore)
  private var wearables: WearablesInterface?
  private var deviceSelector: AutoDeviceSelector?
  private var registrationTask: Task<Void, Never>?
  private var devicesTask: Task<Void, Never>?
  private var deviceSession: DeviceSession?
  private var streamSession: StreamSession?
  private var stateListenerToken: AnyListenerToken?
  private var videoFrameListenerToken: AnyListenerToken?
  private var errorListenerToken: AnyListenerToken?
  private var photoDataListenerToken: AnyListenerToken?
  private var captureLoopTask: Task<Void, Never>?
  private var isCaptureInFlight = false
  private var registrationState: RegistrationState?
  private var devices: [DeviceIdentifier] = []
  private var configured = false
  private var previewStarted = false

  init() {}
  #else
  init() {}
  #endif

  func attachPreviewSink(_ sink: FlutterEventSink?) {
    previewSink = sink
  }

  func attachCaptureSink(_ sink: FlutterEventSink?) {
    captureSink = sink
  }

  func configureIfAvailable() {
    #if canImport(MWDATCamera) && canImport(MWDATCore)
    guard !configured else { return }
    do {
      try Wearables.configure()
      let wearables = Wearables.shared
      self.wearables = wearables
      configured = true
      deviceSelector = AutoDeviceSelector(wearables: wearables)
      registrationState = wearables.registrationState
      devices = wearables.devices
      beginMonitoring()
    } catch {
      configured = false
    }
    #endif
  }

  func handleIncomingURL(_ url: URL) {
    #if canImport(MWDATCamera) && canImport(MWDATCore)
    guard configured, let wearables else { return }
    Task { @MainActor in
      _ = try? await wearables.handleUrl(url)
    }
    #endif
  }

  func getAvailability() -> [String: Any] {
    #if canImport(MWDATCamera) && canImport(MWDATCore)
    configureIfAvailable()
    return [
      "isSupported": configured,
      "isConnected": registrationState == .registered && !devices.isEmpty,
      "message": availabilityMessage(),
    ]
    #else
    return [
      "isSupported": false,
      "isConnected": false,
      "message":
        "Meta DAT iOS package is not available in this build. Resolve Swift packages and rebuild.",
    ]
    #endif
  }

  func startPreview(result: @escaping FlutterResult) {
    #if canImport(MWDATCamera) && canImport(MWDATCore)
    Task { @MainActor in
      do {
        configureIfAvailable()
        try await ensureRegistered()
        try await ensureCameraPermission()
        try await startStreamIfNeeded()
        previewStarted = true
        result(nil)
      } catch let error as RayBanBridgeError {
        result(
          FlutterError(
            code: error.code,
            message: error.message,
            details: nil
          )
        )
      } catch {
        result(
          FlutterError(
            code: "start_preview_failed",
            message: error.localizedDescription,
            details: nil
          )
        )
      }
    }
    #else
    result(
      FlutterError(
        code: "unavailable",
        message: "Meta DAT iOS package is not available in this build.",
        details: nil
      )
    )
    #endif
  }

  func stopPreview(result: @escaping FlutterResult) {
    #if canImport(MWDATCamera) && canImport(MWDATCore)
    Task { @MainActor in
      previewStarted = false
      stopCaptureLoop()
      await stopStream()
      result(nil)
    }
    #else
    result(nil)
    #endif
  }

  func startCapture(intervalMillis: Int, result: @escaping FlutterResult) {
    #if canImport(MWDATCamera) && canImport(MWDATCore)
    Task { @MainActor in
      do {
        configureIfAvailable()
        try await ensureRegistered()
        try await ensureCameraPermission()
        try await startStreamIfNeeded()
        previewStarted = true
        startCaptureLoop(intervalMillis: max(intervalMillis, 750))
        result(nil)
      } catch let error as RayBanBridgeError {
        result(
          FlutterError(
            code: error.code,
            message: error.message,
            details: nil
          )
        )
      } catch {
        result(
          FlutterError(
            code: "start_capture_failed",
            message: error.localizedDescription,
            details: nil
          )
        )
      }
    }
    #else
    result(
      FlutterError(
        code: "unavailable",
        message: "Meta DAT iOS package is not available in this build.",
        details: nil
      )
    )
    #endif
  }

  func stopCapture(result: @escaping FlutterResult) {
    #if canImport(MWDATCamera) && canImport(MWDATCore)
    stopCaptureLoop()
    result(nil)
    #else
    result(nil)
    #endif
  }

  #if canImport(MWDATCamera) && canImport(MWDATCore)
  private func beginMonitoring() {
    guard let wearables else { return }
    guard registrationTask == nil, devicesTask == nil else { return }

    registrationTask = Task { [weak self] in
      guard let self else { return }
      for await state in wearables.registrationStateStream() {
        self.registrationState = state
      }
    }

    devicesTask = Task { [weak self] in
      guard let self else { return }
      for await deviceList in wearables.devicesStream() {
        self.devices = deviceList
      }
    }
  }

  private func ensureRegistered() async throws {
    guard let wearables else {
      throw RayBanBridgeError(
        code: "sdk_not_configured",
        message: "Meta DAT is not configured for this iOS build."
      )
    }
    if registrationState == .registered {
      return
    }

    try await wearables.startRegistration()
    throw RayBanBridgeError(
      code: "registration_required",
      message:
        "Complete the Meta AI registration flow, then return to Language Tutor and tap Refresh."
    )
  }

  private func ensureCameraPermission() async throws {
    guard let wearables else {
      throw RayBanBridgeError(
        code: "sdk_not_configured",
        message: "Meta DAT is not configured for this iOS build."
      )
    }
    let permission: Permission = .camera
    let currentStatus = try await wearables.checkPermissionStatus(permission)
    if currentStatus == .granted {
      return
    }

    let requestedStatus = try await wearables.requestPermission(permission)
    guard requestedStatus == .granted else {
      throw RayBanBridgeError(
        code: "wearables_permission_required",
        message: "Camera permission for Ray-Ban Meta glasses was not granted in Meta AI."
      )
    }
  }

  private func startStreamIfNeeded() async throws {
    if let streamSession, streamSession.state == .streaming || streamSession.state == .starting
      || streamSession.state == .waitingForDevice || streamSession.state == .paused
    {
      return
    }

    guard let deviceSelector else {
      throw RayBanBridgeError(
        code: "sdk_not_configured",
        message: "Meta DAT is not configured for this iOS build."
      )
    }

    if devices.isEmpty {
      throw RayBanBridgeError(
        code: "device_not_connected",
        message:
          "No connected Ray-Ban device is available. Open the glasses and confirm they are linked in Meta AI."
      )
    }

    let session = try await ensureDeviceSession(deviceSelector: deviceSelector)
    let config = StreamSessionConfig(
      videoCodec: .raw,
      resolution: .low,
      frameRate: 24
    )

    guard let stream = try session.addStream(config: config) else {
      throw RayBanBridgeError(
        code: "stream_creation_failed",
        message: "Meta DAT did not create a stream session for the connected glasses."
      )
    }
    streamSession = stream
    installListeners(for: stream)
    await stream.start()
  }

  private func ensureDeviceSession(deviceSelector: AutoDeviceSelector) async throws -> DeviceSession {
    guard let wearables else {
      throw RayBanBridgeError(
        code: "sdk_not_configured",
        message: "Meta DAT is not configured for this iOS build."
      )
    }
    if let deviceSession, deviceSession.state == .started {
      return deviceSession
    }

    let session = try wearables.createSession(deviceSelector: deviceSelector)
    deviceSession = session
    let stateStream = session.stateStream()
    try session.start()

    for await state in stateStream {
      switch state {
      case .started:
        return session
      case .stopped:
        throw RayBanBridgeError(
          code: "session_stopped",
          message: "The Ray-Ban device session stopped before streaming could start."
        )
      default:
        continue
      }
    }

    throw RayBanBridgeError(
      code: "session_start_failed",
      message: "The Ray-Ban device session did not become ready."
    )
  }

  private func installListeners(for stream: StreamSession) {
    stateListenerToken = stream.statePublisher.listen { [weak self] state in
      Task { @MainActor [weak self] in
        guard let self else { return }
        if state == .stopped {
          self.previewStarted = false
          self.stopCaptureLoop()
          self.clearListeners()
          self.streamSession = nil
        }
      }
    }

    videoFrameListenerToken = stream.videoFramePublisher.listen { [weak self] frame in
      Task { @MainActor [weak self] in
        self?.handleVideoFrame(frame)
      }
    }

    errorListenerToken = stream.errorPublisher.listen { [weak self] error in
      Task { @MainActor [weak self] in
        self?.handleStreamError(error)
      }
    }

    photoDataListenerToken = stream.photoDataPublisher.listen { [weak self] data in
      Task { @MainActor [weak self] in
        self?.handlePhotoData(data)
      }
    }
  }

  private func handleVideoFrame(_ frame: VideoFrame) {
    guard previewStarted, let previewSink else { return }
    guard let image = frame.makeUIImage(),
      let data = image.jpegData(compressionQuality: 0.72)
    else {
      return
    }
    previewSink(frameEvent(bytes: data, mimeType: "image/jpeg"))
  }

  private func handlePhotoData(_ data: PhotoData) {
    isCaptureInFlight = false
    captureSink?(frameEvent(bytes: data.data, mimeType: "image/jpeg"))
  }

  private func handleStreamError(_ error: StreamSessionError) {
    if case .hingesClosed = error {
      previewStarted = false
      stopCaptureLoop()
    }
  }

  private func startCaptureLoop(intervalMillis: Int) {
    stopCaptureLoop()
    captureLoopTask = Task { [weak self] in
      guard let self else { return }
      while !Task.isCancelled {
        if self.previewStarted {
          self.captureStillPhotoIfPossible()
        }
        try? await Task.sleep(for: .milliseconds(intervalMillis))
      }
    }
  }

  private func captureStillPhotoIfPossible() {
    guard !isCaptureInFlight, let streamSession else { return }
    guard streamSession.state == .streaming else { return }
    isCaptureInFlight = streamSession.capturePhoto(format: .jpeg)
  }

  private func stopCaptureLoop() {
    captureLoopTask?.cancel()
    captureLoopTask = nil
    isCaptureInFlight = false
  }

  private func stopStream() async {
    if let streamSession {
      await streamSession.stop()
      self.streamSession = nil
    }
    if let deviceSession {
      deviceSession.stop()
      self.deviceSession = nil
    }
    clearListeners()
  }

  private func clearListeners() {
    stateListenerToken = nil
    videoFrameListenerToken = nil
    errorListenerToken = nil
    photoDataListenerToken = nil
  }

  private func availabilityMessage() -> String {
    guard configured else {
      return "Meta DAT iOS package is installed, but the SDK has not finished configuring yet."
    }
    if registrationState != .registered {
      return "Tap Start on Ray-Ban to complete registration in the Meta AI app."
    }
    if devices.isEmpty {
      return "Ray-Ban registration is complete, but no connected glasses are currently available."
    }
    return "Ray-Ban ready. Start preview to see the live POV stream."
  }
  #endif

  private func frameEvent(bytes: Data, mimeType: String) -> [String: Any] {
    [
      "bytes": FlutterStandardTypedData(bytes: bytes),
      "capturedAtMillis": Int(Date().timeIntervalSince1970 * 1000),
      "mimeType": mimeType,
      "source": "ray_ban",
    ]
  }
}

private struct RayBanBridgeError: Error {
  let code: String
  let message: String
}
