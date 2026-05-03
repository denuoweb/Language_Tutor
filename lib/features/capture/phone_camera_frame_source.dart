import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import 'camera_frame.dart';
import 'frame_source.dart';

class PhoneCameraFrameSource extends ChangeNotifier implements FrameSource {
  PhoneCameraFrameSource({
    Future<PermissionStatus> Function()? permissionStatus,
    Future<PermissionStatus> Function()? requestPermission,
    Future<bool> Function()? openSettings,
    Future<List<CameraDescription>> Function()? loadAvailableCameras,
  }) : _permissionStatusReader = permissionStatus ?? _defaultPermissionStatus,
       _permissionRequester = requestPermission ?? _defaultRequestPermission,
       _settingsOpener = openSettings ?? openAppSettings,
       _availableCamerasLoader = loadAvailableCameras ?? availableCameras;

  final Future<PermissionStatus> Function() _permissionStatusReader;
  final Future<PermissionStatus> Function() _permissionRequester;
  final Future<bool> Function() _settingsOpener;
  final Future<List<CameraDescription>> Function() _availableCamerasLoader;

  final _frames = StreamController<CameraFrame>.broadcast();

  CameraController? _controller;
  Future<void>? _initializationFuture;
  Timer? _timer;
  PermissionStatus? _permissionStatus;
  String? _previewMessage;
  Duration? _captureInterval;
  bool _capturing = false;
  bool _disposed = false;
  bool _isPreparingPreview = false;
  bool _shouldBeCapturing = false;
  bool _resumeCaptureOnResume = false;
  int _previewAttachments = 0;
  int _session = 0;

  CameraController? get controller => _controller;

  bool get isInitialized => _controller?.value.isInitialized ?? false;

  bool get isPreparingPreview => _isPreparingPreview;

  String? get previewMessage => _previewMessage;

  bool get canRequestPermission => _permissionStatus?.isDenied ?? false;

  bool get canOpenPermissionSettings =>
      _permissionStatus?.isPermanentlyDenied ?? false;

  bool get isPermissionRestricted => _permissionStatus?.isRestricted ?? false;

  bool get canRetryPreview =>
      !isPreparingPreview &&
      !isInitialized &&
      !isPermissionRestricted &&
      !canOpenPermissionSettings;

  @override
  Stream<CameraFrame> get frames => _frames.stream;

  void attachPreview() {
    if (_disposed) {
      return;
    }

    _previewAttachments++;
    if (_previewAttachments == 1) {
      unawaited(preparePreview(requestPermission: _permissionStatus == null));
    }
  }

  Future<void> detachPreview() async {
    if (_previewAttachments == 0) {
      return;
    }

    _previewAttachments--;
    if (_previewAttachments == 0 && !_shouldBeCapturing) {
      await _releaseController();
    }
  }

  Future<void> preparePreview({bool requestPermission = true}) {
    if (_disposed) {
      return Future.value();
    }
    if (isInitialized) {
      _previewMessage = null;
      _notifyStateChanged();
      return Future.value();
    }

    final pendingInitialization = _initializationFuture;
    if (pendingInitialization != null) {
      return pendingInitialization;
    }

    final initialization = _preparePreviewInternal(
      requestPermission: requestPermission,
    );
    _initializationFuture = initialization;
    initialization.whenComplete(() {
      if (identical(_initializationFuture, initialization)) {
        _initializationFuture = null;
      }
    });
    return initialization;
  }

  Future<void> retryPreview({bool requestPermission = true}) async {
    await _releaseController();
    await preparePreview(requestPermission: requestPermission);
  }

  Future<bool> openPermissionSettings() => _settingsOpener();

  Future<void> handleAppLifecycleState(AppLifecycleState state) async {
    if (_disposed) {
      return;
    }

    switch (state) {
      case AppLifecycleState.resumed:
        if (_shouldBeCapturing) {
          await _resumeCaptureLoopIfNeeded();
        } else if (_previewAttachments > 0) {
          await preparePreview(requestPermission: false);
        }
        return;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _resumeCaptureOnResume = _shouldBeCapturing;
        _session++;
        _timer?.cancel();
        _timer = null;
        await _releaseController();
        return;
      case AppLifecycleState.detached:
        return;
    }
  }

  @override
  Future<void> start({required Duration interval}) async {
    _captureInterval = interval;
    _shouldBeCapturing = true;
    _resumeCaptureOnResume = false;

    await preparePreview();
    if (!isInitialized) {
      _shouldBeCapturing = false;
      _captureInterval = null;
      throw CameraAccessException(
        _previewMessage ?? 'The camera could not be initialized.',
      );
    }

    await _startCaptureLoop(interval);
  }

  @override
  Future<void> stop() async {
    _shouldBeCapturing = false;
    _captureInterval = null;
    _resumeCaptureOnResume = false;
    _session++;
    _timer?.cancel();
    _timer = null;

    if (_previewAttachments == 0) {
      await _releaseController();
    }
  }

  @override
  void dispose() {
    if (_disposed) {
      return;
    }

    _disposed = true;
    _session++;
    _timer?.cancel();
    _timer = null;

    final controller = _controller;
    _controller = null;
    if (controller != null) {
      unawaited(controller.dispose());
    }
    if (!_frames.isClosed) {
      unawaited(_frames.close());
    }

    super.dispose();
  }

  Future<void> _preparePreviewInternal({
    required bool requestPermission,
  }) async {
    _isPreparingPreview = true;
    _previewMessage = null;
    _notifyStateChanged();

    try {
      final permission = await _resolvePermission(
        requestPermission: requestPermission,
      );
      _permissionStatus = permission;
      if (!permission.isGranted) {
        _previewMessage = _messageForPermissionStatus(permission);
        return;
      }

      final cameras = await _availableCamerasLoader();
      if (cameras.isEmpty) {
        _previewMessage = 'No camera is available on this device.';
        return;
      }

      final controller = CameraController(
        _preferredCamera(cameras),
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      try {
        await controller.initialize();
      } on CameraException catch (error) {
        await controller.dispose();
        _previewMessage = _messageForCameraException(error);
        _permissionStatus = _permissionStatusForCameraException(error);
        return;
      } catch (_) {
        await controller.dispose();
        _previewMessage = 'The camera could not be initialized. Try again.';
        return;
      }

      if (_disposed || !_shouldHoldController) {
        await controller.dispose();
        return;
      }

      _permissionStatus = PermissionStatus.granted;
      await _releaseController(notify: false);
      _controller = controller;
      _previewMessage = null;
    } catch (_) {
      _previewMessage = 'The camera could not be initialized. Try again.';
    } finally {
      _isPreparingPreview = false;
      _notifyStateChanged();
    }
  }

  Future<PermissionStatus> _resolvePermission({
    required bool requestPermission,
  }) async {
    final status = await _permissionStatusReader();
    if (status.isGranted ||
        status.isPermanentlyDenied ||
        status.isRestricted ||
        !requestPermission) {
      return status;
    }
    return _permissionRequester();
  }

  Future<void> _startCaptureLoop(Duration interval) async {
    _timer?.cancel();
    _timer = null;

    final session = ++_session;
    await _captureOnce(session);
    if (!_shouldBeCapturing || session != _session) {
      return;
    }

    _timer = Timer.periodic(interval, (_) {
      unawaited(_captureOnce(session));
    });
  }

  Future<void> _resumeCaptureLoopIfNeeded() async {
    if (!_resumeCaptureOnResume || _captureInterval == null) {
      if (_previewAttachments > 0) {
        await preparePreview(requestPermission: false);
      }
      return;
    }

    _resumeCaptureOnResume = false;
    await preparePreview(requestPermission: false);
    if (!isInitialized || _captureInterval == null) {
      return;
    }

    await _startCaptureLoop(_captureInterval!);
  }

  Future<void> _captureOnce(int session) async {
    if (_capturing || session != _session) {
      return;
    }

    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    _capturing = true;
    try {
      final image = await controller.takePicture();
      final bytes = await image.readAsBytes();
      await _deleteTemporaryCapture(image.path);
      if (session != _session || _frames.isClosed) {
        return;
      }
      _frames.add(
        CameraFrame(
          bytes: bytes,
          capturedAt: DateTime.now().toUtc(),
          mimeType: 'image/jpeg',
          source: 'phone_camera',
        ),
      );
    } on CameraException catch (error) {
      if (session == _session && !_frames.isClosed) {
        _frames.addError(
          CameraAccessException(_messageForCaptureException(error)),
        );
      }
    } catch (_) {
      if (session == _session && !_frames.isClosed) {
        _frames.addError(
          const CameraAccessException(
            'The camera could not capture an image. Try again.',
          ),
        );
      }
    } finally {
      _capturing = false;
    }
  }

  Future<void> _releaseController({bool notify = true}) async {
    final controller = _controller;
    if (controller == null) {
      return;
    }

    _controller = null;
    if (notify) {
      _notifyStateChanged();
    }

    try {
      await controller.dispose();
    } catch (_) {
      // Release failures should not crash the app during lifecycle changes.
    }
  }

  CameraDescription _preferredCamera(List<CameraDescription> cameras) {
    return cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );
  }

  PermissionStatus? _permissionStatusForCameraException(CameraException error) {
    switch (error.code) {
      case 'CameraAccessDenied':
        return PermissionStatus.denied;
      case 'CameraAccessDeniedWithoutPrompt':
        return PermissionStatus.permanentlyDenied;
      case 'CameraAccessRestricted':
        return PermissionStatus.restricted;
      default:
        return _permissionStatus;
    }
  }

  String _messageForPermissionStatus(PermissionStatus status) {
    if (status.isPermanentlyDenied) {
      return 'Camera access is turned off for this app. Enable it in system settings.';
    }
    if (status.isRestricted) {
      return 'Camera access is restricted on this device and cannot be granted.';
    }
    return 'Camera access is required to show the preview and capture lessons.';
  }

  String _messageForCameraException(CameraException error) {
    switch (error.code) {
      case 'CameraAccessDenied':
        return 'Camera access is required to show the preview and capture lessons.';
      case 'CameraAccessDeniedWithoutPrompt':
        return 'Camera access is turned off for this app. Enable it in system settings.';
      case 'CameraAccessRestricted':
        return 'Camera access is restricted on this device and cannot be granted.';
      default:
        return 'The camera could not be initialized. Try again.';
    }
  }

  String _messageForCaptureException(CameraException error) {
    switch (error.code) {
      case 'CameraAccessDenied':
      case 'CameraAccessDeniedWithoutPrompt':
      case 'CameraAccessRestricted':
        return _messageForCameraException(error);
      default:
        return 'The camera could not capture an image. Try again.';
    }
  }

  void _notifyStateChanged() {
    if (_disposed) {
      return;
    }
    notifyListeners();
  }

  bool get _shouldHoldController =>
      _shouldBeCapturing || _previewAttachments > 0;

  Future<void> _deleteTemporaryCapture(String path) async {
    if (path.isEmpty) {
      return;
    }
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } on FileSystemException {
      // Capture bytes are already in memory; cleanup failure should not fail UX.
    }
  }

  static Future<PermissionStatus> _defaultPermissionStatus() {
    return Permission.camera.status;
  }

  static Future<PermissionStatus> _defaultRequestPermission() {
    return Permission.camera.request();
  }
}
