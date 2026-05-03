import 'dart:async';

import 'camera_frame.dart';

enum CaptureSource {
  phoneCamera,
  rayBan,
  ;

  String get label {
    switch (this) {
      case CaptureSource.phoneCamera:
        return 'Phone camera';
      case CaptureSource.rayBan:
        return 'Ray-Ban';
    }
  }
}

class CameraAccessException implements Exception {
  const CameraAccessException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract interface class FrameSource {
  Stream<CameraFrame> get frames;

  Future<void> start({required Duration interval});

  Future<void> stop();

  FutureOr<void> dispose();
}
