import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../shared/clock.dart';
import '../settings/settings_controller.dart';
import 'camera_frame.dart';
import 'capture_state.dart';

class CaptureController extends Notifier<CaptureState> {
  StreamSubscription<CameraFrame>? _frameSubscription;
  bool _generationInFlight = false;
  int _activeSession = 0;

  @override
  CaptureState build() {
    final frameSource = ref.read(frameSourceProvider);
    ref.onDispose(() {
      _activeSession++;
      unawaited(_frameSubscription?.cancel());
      unawaited(frameSource.stop());
    });
    return CaptureState.initial();
  }

  Future<void> start() async {
    if (state.isRunning) {
      return;
    }

    final settings = await ref.read(settingsControllerProvider.future);
    final session = ++_activeSession;
    state = state.copyWith(isRunning: true, clearError: true);

    await _frameSubscription?.cancel();
    _frameSubscription = ref
        .read(frameSourceProvider)
        .frames
        .listen(
          (frame) {
            unawaited(_processFrame(frame, session));
          },
          onError: (Object error) {
            if (session == _activeSession) {
              state = state.copyWith(errorMessage: error.toString());
            }
          },
        );

    try {
      await ref
          .read(frameSourceProvider)
          .start(interval: settings.captureInterval);
    } catch (error) {
      if (session == _activeSession) {
        await stop();
        state = state.copyWith(errorMessage: error.toString());
      }
    }
  }

  Future<void> stop() async {
    _activeSession++;
    _generationInFlight = false;
    await _frameSubscription?.cancel();
    _frameSubscription = null;
    await ref.read(frameSourceProvider).stop();
    state = state.copyWith(isRunning: false, isGenerating: false);
  }

  Future<void> _processFrame(CameraFrame frame, int session) async {
    if (_generationInFlight || session != _activeSession || !state.isRunning) {
      return;
    }

    _generationInFlight = true;
    state = state.copyWith(isGenerating: true, clearError: true);
    try {
      final settings = await ref.read(settingsControllerProvider.future);
      final lesson = await ref
          .read(tutorGenerationServiceProvider)
          .generateFromFrame(frame: frame, level: settings.level);

      if (session != _activeSession || !state.isRunning) {
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

      if (session != _activeSession || !state.isRunning) {
        return;
      }

      state = state.copyWith(currentLesson: lesson, clearError: true);
      if (!settings.ttsMuted) {
        unawaited(
          ref.read(speechServiceProvider).speakJapanese(lesson.japanese),
        );
      }
    } catch (error) {
      if (session == _activeSession && state.isRunning) {
        state = state.copyWith(errorMessage: error.toString());
      }
    } finally {
      if (session == _activeSession && state.isRunning) {
        _generationInFlight = false;
        state = state.copyWith(isGenerating: false);
      }
    }
  }
}

final captureControllerProvider =
    NotifierProvider<CaptureController, CaptureState>(CaptureController.new);
