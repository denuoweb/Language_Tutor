import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'camera_frame.dart';
import 'frame_source.dart';
import 'ray_ban_native_bridge.dart';

class RayBanFrameSource extends ChangeNotifier implements FrameSource {
  RayBanFrameSource({required RayBanNativeBridge bridge}) : _bridge = bridge;

  static const unavailableMessage =
      'Ray-Ban POV preview will appear here once the native glasses bridge is connected.';
  static const captureUnavailableMessage =
      'Ray-Ban capture is not connected yet. Switch to the phone camera or finish the Ray-Ban bridge.';

  final RayBanNativeBridge _bridge;
  final _frames = StreamController<CameraFrame>.broadcast();

  StreamSubscription<CameraFrame>? _previewSubscription;
  StreamSubscription<CameraFrame>? _captureSubscription;
  CameraFrame? _previewFrame;
  bool _isPreparingPreview = false;
  bool _isRunning = false;
  bool _previewStarted = false;
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
      await _stopPreview();
      _clearPreviewState();
    }
  }

  Future<void> preparePreview() async {
    if (_disposed) {
      return;
    }

    _isPreparingPreview = true;
    _previewMessage = 'Connecting to Ray-Ban preview...';
    _notifyStateChanged();

    try {
      await _ensurePreviewSubscription();
      final availability = await _bridge.getAvailability();
      _previewMessage = availability.message;

      if (!availability.isSupported) {
        return;
      }

      await _bridge.startPreview();
      _previewStarted = true;
      if (_previewFrame == null && availability.isConnected) {
        _previewMessage = 'Waiting for Ray-Ban preview frames...';
      }
    } on PlatformException catch (error) {
      _previewMessage = error.message ?? unavailableMessage;
    } catch (_) {
      _previewMessage = unavailableMessage;
    } finally {
      _isPreparingPreview = false;
      _notifyStateChanged();
    }
  }

  Future<void> retryPreview() => preparePreview();

  @override
  Future<void> start({required Duration interval}) async {
    await preparePreview();
    try {
      await _ensureCaptureSubscription();
      await _bridge.startCapture(interval: interval);
      _isRunning = true;
      _previewMessage ??= 'Capturing from Ray-Ban...';
      _notifyStateChanged();
    } on PlatformException catch (error) {
      _isRunning = false;
      _previewMessage = error.message ?? captureUnavailableMessage;
      _notifyStateChanged();
      throw CameraAccessException(_previewMessage!);
    } catch (_) {
      _isRunning = false;
      _previewMessage = captureUnavailableMessage;
      _notifyStateChanged();
      throw const CameraAccessException(captureUnavailableMessage);
    }
  }

  @override
  Future<void> stop() async {
    _isRunning = false;
    try {
      await _bridge.stopCapture();
    } on PlatformException {
      // Best effort only.
    }

    if (_previewAttachments == 0) {
      await _stopPreview();
      _clearPreviewState();
    } else {
      _previewMessage = _previewFrame == null
          ? unavailableMessage
          : 'Ray-Ban preview active.';
      _notifyStateChanged();
    }
  }

  @override
  Future<void> dispose() async {
    if (_disposed) {
      return;
    }

    _disposed = true;
    await _captureSubscription?.cancel();
    await _previewSubscription?.cancel();
    await _stopPreview();
    if (!_frames.isClosed) {
      await _frames.close();
    }
    super.dispose();
  }

  void _clearPreviewState() {
    _previewFrame = null;
    _previewMessage = unavailableMessage;
    _notifyStateChanged();
  }

  Future<void> _ensurePreviewSubscription() async {
    if (_previewSubscription != null) {
      return;
    }

    _previewSubscription = _bridge.previewFrames.listen(
      (frame) {
        _previewFrame = frame;
        _previewMessage = 'Ray-Ban preview active.';
        _notifyStateChanged();
      },
      onError: (_) {
        _previewMessage = unavailableMessage;
        _notifyStateChanged();
      },
    );
  }

  Future<void> _ensureCaptureSubscription() async {
    if (_captureSubscription != null) {
      return;
    }

    _captureSubscription = _bridge.captureFrames.listen(
      (frame) {
        if (_frames.isClosed) {
          return;
        }
        _frames.add(frame);
      },
      onError: (Object error) {
        if (_frames.isClosed) {
          return;
        }
        _frames.addError(
          error is CameraAccessException
              ? error
              : const CameraAccessException(captureUnavailableMessage),
        );
      },
    );
  }

  Future<void> _stopPreview() async {
    if (!_previewStarted) {
      return;
    }
    _previewStarted = false;
    try {
      await _bridge.stopPreview();
    } on PlatformException {
      // Best effort only.
    }
  }

  void _notifyStateChanged() {
    if (_disposed) {
      return;
    }
    notifyListeners();
  }
}
