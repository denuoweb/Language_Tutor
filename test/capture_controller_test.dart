import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_tutor/app/app_providers.dart';
import 'package:language_tutor/features/capture/capture_controller.dart';

import 'test_helpers.dart';

void main() {
  test('low confidence generation is rejected before saving', () async {
    final frameSource = FakeFrameSource();
    final tutor = FakeTutorGenerationService(lessonFixture(confidence: 0.2));
    final srs = FakeSrsRepository();
    final container = ProviderContainer(
      overrides: [
        frameSourceProvider.overrideWithValue(frameSource),
        tutorGenerationServiceProvider.overrideWithValue(tutor),
        srsRepositoryProvider.overrideWithValue(srs),
        settingsRepositoryProvider.overrideWithValue(FakeSettingsRepository()),
        speechServiceProvider.overrideWithValue(FakeSpeechService()),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(srs.dispose);

    await container.read(captureControllerProvider.notifier).start();
    frameSource.emit(frameFixture());
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(captureControllerProvider);
    expect(state.errorMessage, contains('confidence'));
    expect(srs.insertedLessons, isEmpty);
  });

  test('late generation result is dropped after stop', () async {
    final frameSource = FakeFrameSource();
    final tutor = DelayedTutorGenerationService();
    final srs = FakeSrsRepository();
    final speech = FakeSpeechService();
    final container = ProviderContainer(
      overrides: [
        frameSourceProvider.overrideWithValue(frameSource),
        tutorGenerationServiceProvider.overrideWithValue(tutor),
        srsRepositoryProvider.overrideWithValue(srs),
        settingsRepositoryProvider.overrideWithValue(FakeSettingsRepository()),
        speechServiceProvider.overrideWithValue(speech),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(srs.dispose);

    final controller = container.read(captureControllerProvider.notifier);
    await controller.start();
    frameSource.emit(frameFixture());
    await tutor.called.future;

    await controller.stop();
    tutor.result.complete(lessonFixture());
    await Future<void>.delayed(Duration.zero);

    final state = container.read(captureControllerProvider);
    expect(state.isRunning, isFalse);
    expect(state.currentLesson, isNull);
    expect(srs.insertedLessons, isEmpty);
    expect(speech.spoken, isEmpty);
  });
}
