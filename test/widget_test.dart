import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:async';
import 'package:language_tutor/features/capture/capture_screen.dart';
import 'package:language_tutor/features/settings/app_settings.dart';
import 'package:language_tutor/features/settings/settings_repository.dart';
import 'package:language_tutor/features/settings/settings_screen.dart';
import 'package:language_tutor/features/srs/review_grade.dart';
import 'package:language_tutor/features/srs/review_screen.dart';

import 'test_helpers.dart';

void main() {
  testWidgets('capture screen shows loading and error states', (tester) async {
    await pumpTestWidget(
      tester,
      child: const CaptureScreen(),
      frameSource: FakeFrameSource(),
      tutorService: FakeTutorGenerationService(lessonFixture()),
      speechService: FakeSpeechService(),
      srsRepository: FakeSrsRepository(),
      settingsRepository: _PendingSettingsRepository(),
    );

    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    await tester.pumpWidget(
      testScope(
        child: const CaptureScreen(),
        frameSource: FakeFrameSource(),
        tutorService: FakeTutorGenerationService(lessonFixture()),
        speechService: FakeSpeechService(),
        srsRepository: FakeSrsRepository(),
        settingsRepository: _ThrowingSettingsRepository(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('settings unavailable'), findsOneWidget);
  });

  testWidgets('capture screen displays generated demo lesson', (tester) async {
    final frameSource = FakeFrameSource();
    final srs = FakeSrsRepository();
    await pumpTestWidget(
      tester,
      child: const CaptureScreen(),
      frameSource: frameSource,
      tutorService: FakeTutorGenerationService(lessonFixture()),
      speechService: FakeSpeechService(),
      srsRepository: srs,
      settingsRepository: FakeSettingsRepository(),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();
    frameSource.emit(frameFixture());
    await tester.pumpAndSettle();

    expect(find.text('ここにノートがあります。'), findsWidgets);
    expect(find.text('There is a notebook.'), findsOneWidget);
    expect(srs.insertedLessons, hasLength(1));
  });

  testWidgets('review screen reveals and grades due card', (tester) async {
    final srs = FakeSrsRepository();
    await pumpTestWidget(
      tester,
      child: const ReviewScreen(),
      srsRepository: srs,
      settingsRepository: FakeSettingsRepository(),
    );
    srs.dueCardsController.add([learningCardFixture()]);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Reveal'));
    await tester.pumpAndSettle();

    expect(find.text('There is a notebook.'), findsOneWidget);
    expect(find.text('ノート · ノート · notebook'), findsOneWidget);

    await tester.tap(find.text(ReviewGrade.good.label));
    await tester.pumpAndSettle();

    expect(srs.reviews.single.grade, ReviewGrade.good);
  });

  testWidgets('settings screen persists mute setting', (tester) async {
    final settings = FakeSettingsRepository();
    await pumpTestWidget(
      tester,
      child: const SettingsScreen(),
      settingsRepository: settings,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();

    expect(settings.settings.ttsMuted, isTrue);
  });
}

class _PendingSettingsRepository implements SettingsRepository {
  final _settings = Completer<AppSettings>();

  @override
  Future<AppSettings> load() => _settings.future;

  @override
  Future<void> save(AppSettings settings) async {}
}

class _ThrowingSettingsRepository implements SettingsRepository {
  @override
  Future<AppSettings> load() {
    throw StateError('settings unavailable');
  }

  @override
  Future<void> save(AppSettings settings) async {}
}
