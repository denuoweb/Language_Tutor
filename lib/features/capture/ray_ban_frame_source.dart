import 'dart:async';

import 'package:flutter/foundation.dart';

import 'camera_frame.dart';
import 'frame_source.dart';

class RayBanFrameSource extends ChangeNotifier implements FrameSource {
  RayBanFrameSource();

  static const unavailableMessage =
      'Ray-Ban POV preview will appear here once the native glasses bridge is connected.';
  static const captureUnavailableMessage =
      'Ray-Ban capture is not connected yet. Switch to the phone camera or finish the Ray-Ban bridge.';

  final _frames = StreamController<CameraFrame>.broadcast();

  CameraFrame? _previewFrame;
  bool _isPreparingPreview = false;
  bool _isRunning = false;
  bool _disposed = false;
  int _previewAttachments = 0;
  String? _previewMessage = unavailableMessage;

  CameraFrame? get previewFrame => _previewFrame;

  bool get isPreparingPreview => _isPreparingPreview;

  bool get isRunning => _isRunning;

  String? get previewMessage => _previewMessage;

  bool get canRetryPreview => !_isPreparingPreview;

  @override
  Stream<CameraFrame> get frames => _frames.stream;

  void attachPreview() {
    if (_disposed) {
      return;
    }

    _previewAttachments++;
    if (_previewAttachments == 1) {
      unawaited(preparePreview());
    }
  }

  Future<void> detachPreview() async {
    if (_previewAttachments == 0) {
      return;
    }

    _previewAttachments--;
    if (_previewAttachments == 0 && !_isRunning) {
      _clearPreviewState();
    }
  }

  Future<void> preparePreview() async {
    if (_disposed) {
      return;
    }

    _isPreparingPreview = true;
    _previewMessage = unavailableMessage;
    _notifyStateChanged();

    _isPreparingPreview = false;
    _notifyStateChanged();
  }

  Future<void> retryPreview() => preparePreview();

  @override
  Future<void> start({required Duration interval}) async {
    _isRunning = true;
    await preparePreview();
    _notifyStateChanged();
    throw const CameraAccessException(captureUnavailableMessage);
  }

  @override
  Future<void> stop() async {
    _isRunning = false;
    if (_previewAttachments == 0) {
      _clearPreviewState();
    } else {
      _previewMessage = unavailableMessage;
      _notifyStateChanged();
    }
  }

  @override
  void dispose() {
    if (_disposed) {
      return;
    }

    _disposed = true;
    if (!_frames.isClosed) {
      unawaited(_frames.close());
    }
    super.dispose();
  }

  void _clearPreviewState() {
    _previewFrame = null;
    _previewMessage = unavailableMessage;
    _notifyStateChanged();
  }

  void _notifyStateChanged() {
    if (_disposed) {
      return;
    }
    notifyListeners();
  }
}
