import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import 'camera_frame.dart';
import 'frame_source.dart';

class PhoneCameraFrameSource implements FrameSource {
  PhoneCameraFrameSource();

  final _frames = StreamController<CameraFrame>.broadcast();

  CameraController? _controller;
  Timer? _timer;
  bool _capturing = false;
  int _session = 0;

  CameraController? get controller => _controller;

  bool get isInitialized => _controller?.value.isInitialized ?? false;

  @override
  Stream<CameraFrame> get frames => _frames.stream;

  Future<void> initialize() async {
    if (isInitialized) {
      return;
    }

    final permission = await Permission.camera.request();
    if (!permission.isGranted) {
      throw CameraException('CameraAccessDenied', 'Camera permission denied.');
    }

    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      throw CameraException('NoCameraFound', 'No camera is available.');
    }

    final controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller.initialize();
    _controller = controller;
  }

  @override
  Future<void> start({required Duration interval}) async {
    await initialize();
    await stop();
    final session = ++_session;
    await _captureOnce(session);
    _timer = Timer.periodic(interval, (_) {
      unawaited(_captureOnce(session));
    });
  }

  @override
  Future<void> stop() async {
    _session++;
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> dispose() async {
    await stop();
    await _controller?.dispose();
    await _frames.close();
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
    } finally {
      _capturing = false;
    }
  }

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
}
