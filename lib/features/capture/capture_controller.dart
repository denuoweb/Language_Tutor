import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../shared/clock.dart';
import '../settings/settings_controller.dart';
import 'camera_frame.dart';
import 'capture_state.dart';
import 'frame_source.dart';

class CaptureController extends Notifier<CaptureState> {
  StreamSubscription<CameraFrame>? _frameSubscription;
  FrameSource? _activeFrameSource;
  bool _generationInFlight = false;
  int _activeSession = 0;

  @override
  CaptureState build() {
    ref.onDispose(() {
      _activeSession++;
      _generationInFlight = false;
      unawaited(_frameSubscription?.cancel());
      _frameSubscription = null;

      final frameSource = _activeFrameSource;
      _activeFrameSource = null;
      if (frameSource != null) {
        unawaited(frameSource.stop());
      }
    });
    return CaptureState.initial();
  }

  Future<void> start() async {
    if (state.isRunning) {
      return;
    }

    final settings = await ref.read(settingsControllerProvider.future);
    if (!ref.mounted) {
      return;
    }

    final frameSource = ref.read(frameSourceProvider);
    final session = ++_activeSession;
    state = state.copyWith(isRunning: true, clearError: true);

    await _frameSubscription?.cancel();
    _frameSubscription = frameSource.frames.listen(
      (frame) {
        unawaited(_processFrame(frame, session));
      },
      onError: (Object error) {
        if (ref.mounted && session == _activeSession) {
          state = state.copyWith(errorMessage: error.toString());
        }
      },
    );
    _activeFrameSource = frameSource;

    try {
      await frameSource.start(interval: settings.captureInterval);
    } catch (error) {
      if (session == _activeSession) {
        await _stopActiveCapture();
        if (ref.mounted) {
          state = state.copyWith(errorMessage: error.toString());
        }
      }
    }
  }

  Future<void> stop() async {
    await _stopActiveCapture();
  }

  Future<void> _stopActiveCapture() async {
    _activeSession++;
    _generationInFlight = false;
    await _frameSubscription?.cancel();
    _frameSubscription = null;

    final frameSource = _activeFrameSource;
    _activeFrameSource = null;
    if (frameSource != null) {
      await frameSource.stop();
    }

    if (ref.mounted) {
      state = state.copyWith(isRunning: false, isGenerating: false);
    }
  }

  Future<void> _processFrame(CameraFrame frame, int session) async {
    if (!ref.mounted ||
        _generationInFlight ||
        session != _activeSession ||
        !state.isRunning) {
      return;
    }

    _generationInFlight = true;
    state = state.copyWith(isGenerating: true, clearError: true);
    try {
      final settings = await ref.read(settingsControllerProvider.future);
      if (!ref.mounted || session != _activeSession || !state.isRunning) {
        return;
      }

      final lesson = await ref
          .read(tutorGenerationServiceProvider)
          .generateFromFrame(frame: frame, level: settings.level);

      if (!ref.mounted || session != _activeSession || !state.isRunning) {
        return;
      }

      if (lesson.confidence < 0.60) {
        state = state.copyWith(
          errorMessage: 'Gemini confidence was below the save threshold.',
        );
        return;
      }

      await ref
          .read(srsRepositoryProvider)
          .insertGeneratedCard(
            lesson: lesson,
            targetLevel: settings.level,
            now: systemNow(),
            source: frame.source,
          );

      if (!ref.mounted || session != _activeSession || !state.isRunning) {
        return;
      }

      state = state.copyWith(currentLesson: lesson, clearError: true);
      if (!settings.ttsMuted) {
        unawaited(
          ref.read(speechServiceProvider).speakJapanese(lesson.japanese),
        );
      }
    } catch (error) {
      if (ref.mounted && session == _activeSession && state.isRunning) {
        state = state.copyWith(errorMessage: error.toString());
      }
    } finally {
      if (ref.mounted && session == _activeSession && state.isRunning) {
        _generationInFlight = false;
        state = state.copyWith(isGenerating: false);
      }
    }
  }
}

final captureControllerProvider =
    NotifierProvider<CaptureController, CaptureState>(CaptureController.new);
