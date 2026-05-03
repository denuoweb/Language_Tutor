import 'dart:async';

import 'package:flutter/services.dart';

import 'camera_frame.dart';

class RayBanAvailability {
  const RayBanAvailability({
    required this.isSupported,
    required this.isConnected,
    required this.message,
  });

  factory RayBanAvailability.fromMap(Map<Object?, Object?> map) {
    return RayBanAvailability(
      isSupported: map['isSupported'] as bool? ?? false,
      isConnected: map['isConnected'] as bool? ?? false,
      message:
          map['message'] as String? ??
          'Ray-Ban bridge status is unavailable.',
    );
  }

  final bool isSupported;
  final bool isConnected;
  final String message;
}

class RayBanNativeBridge {
  RayBanNativeBridge({
    MethodChannel? methodChannel,
    EventChannel? previewEventChannel,
    EventChannel? captureEventChannel,
  }) : _methodChannel =
           methodChannel ??
           const MethodChannel('language_tutor/ray_ban/methods'),
       _previewEventChannel =
           previewEventChannel ??
           const EventChannel('language_tutor/ray_ban/preview_frames'),
       _captureEventChannel =
           captureEventChannel ??
           const EventChannel('language_tutor/ray_ban/capture_frames');

  final MethodChannel _methodChannel;
  final EventChannel _previewEventChannel;
  final EventChannel _captureEventChannel;

  Stream<CameraFrame>? _previewFrames;
  Stream<CameraFrame>? _captureFrames;

  Future<RayBanAvailability> getAvailability() async {
    final result = await _methodChannel.invokeMapMethod<Object?, Object?>(
      'getAvailability',
    );
    return RayBanAvailability.fromMap(result ?? const {});
  }

  Future<void> startPreview() async {
    await _methodChannel.invokeMethod<void>('startPreview');
  }

  Future<void> stopPreview() async {
    await _methodChannel.invokeMethod<void>('stopPreview');
  }

  Future<void> startCapture({required Duration interval}) async {
    await _methodChannel.invokeMethod<void>('startCapture', {
      'intervalMillis': interval.inMilliseconds,
    });
  }

  Future<void> stopCapture() async {
    await _methodChannel.invokeMethod<void>('stopCapture');
  }

  Stream<CameraFrame> get previewFrames {
    return _previewFrames ??= _previewEventChannel
        .receiveBroadcastStream()
        .map(_decodeFrame)
        .asBroadcastStream();
  }

  Stream<CameraFrame> get captureFrames {
    return _captureFrames ??= _captureEventChannel
        .receiveBroadcastStream()
        .map(_decodeFrame)
        .asBroadcastStream();
  }

  CameraFrame _decodeFrame(dynamic event) {
    if (event is! Map<Object?, Object?>) {
      throw const FormatException('Ray-Ban frame event was not a map.');
    }

    final bytes = event['bytes'];
    if (bytes is! Uint8List) {
      throw const FormatException('Ray-Ban frame bytes were missing.');
    }

    final capturedAtMillis = event['capturedAtMillis'];
    if (capturedAtMillis is! int) {
      throw const FormatException('Ray-Ban frame timestamp was missing.');
    }

    return CameraFrame(
      bytes: bytes,
      capturedAt: DateTime.fromMillisecondsSinceEpoch(
        capturedAtMillis,
        isUtc: true,
      ),
      mimeType: event['mimeType'] as String? ?? 'image/jpeg',
      source: event['source'] as String? ?? 'ray_ban',
    );
  }
}
