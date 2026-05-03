import 'dart:async';

import 'camera_frame.dart';

abstract interface class FrameSource {
  Stream<CameraFrame> get frames;

  Future<void> start({required Duration interval});

  Future<void> stop();

  FutureOr<void> dispose();
}
