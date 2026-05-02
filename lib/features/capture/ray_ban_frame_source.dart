import 'camera_frame.dart';
import 'frame_source.dart';

class RayBanFrameSource implements FrameSource {
  const RayBanFrameSource();

  @override
  Stream<CameraFrame> get frames => const Stream.empty();

  @override
  Future<void> start({required Duration interval}) {
    throw UnsupportedError('Ray-Ban camera source is a post-MVP stub.');
  }

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {}
}
