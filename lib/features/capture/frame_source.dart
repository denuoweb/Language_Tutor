import 'camera_frame.dart';

abstract interface class FrameSource {
  Stream<CameraFrame> get frames;

  Future<void> start({required Duration interval});

  Future<void> stop();

  Future<void> dispose();
}
