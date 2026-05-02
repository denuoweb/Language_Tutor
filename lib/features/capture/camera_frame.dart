import 'dart:typed_data';

class CameraFrame {
  const CameraFrame({
    required this.bytes,
    required this.capturedAt,
    required this.mimeType,
    required this.source,
  });

  final Uint8List bytes;
  final DateTime capturedAt;
  final String mimeType;
  final String source;
}
