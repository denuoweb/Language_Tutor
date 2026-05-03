import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_tutor/app/app_providers.dart';
import 'package:language_tutor/data/database/app_database.dart';
import 'package:language_tutor/data/models/tutor_result.dart';
import 'package:language_tutor/features/capture/camera_frame.dart';
import 'package:language_tutor/features/capture/frame_source.dart';
import 'package:language_tutor/features/gemini/tutor_generation_service.dart';
import 'package:language_tutor/features/settings/app_settings.dart';
import 'package:language_tutor/features/settings/settings_repository.dart';
import 'package:language_tutor/features/speech/speech_service.dart';
import 'package:language_tutor/features/srs/review_grade.dart';
import 'package:language_tutor/features/srs/srs_repository.dart';
import 'package:language_tutor/shared/jlpt_level.dart';

TutorResult lessonFixture({double confidence = 0.95}) {
  return TutorResult(
    sceneLabel: 'desk',
    english: 'There is a notebook.',
    japanese: 'ここにノートがあります。',
    reading: 'ここにノートがあります。',
    keyVocabulary: const [
      VocabItem(
        japanese: 'ノート',
        reading: 'ノート',
        meaning: 'notebook',
        approxJlpt: 'N5',
      ),
    ],
    grammarNote: 'あります marks existence.',
    confidence: confidence,
  );
}

CameraFrame frameFixture() {
  return CameraFrame(
    bytes: Uint8List.fromList([1, 2, 3]),
    capturedAt: DateTime.utc(2026, 1, 1),
    mimeType: 'image/jpeg',
    source: 'test',
  );
}

LearningCard learningCardFixture({String id = 'card-1'}) {
  final now = DateTime.utc(2026, 1, 1).millisecondsSinceEpoch;
  return LearningCard(
    id: id,
    sceneLabel: 'desk',
    english: 'There is a notebook.',
    japanese: 'ここにノートがあります。',
    reading: 'ここにノートがあります。',
    grammarNote: 'あります marks existence.',
    targetLevel: 'N5',
    source: 'test',
    createdAt: now,
    dueAt: now,
    intervalDays: 0,
    ease: 2.5,
    repetitions: 0,
    lapses: 0,
    suspended: false,
  );
}

StoredVocabItem storedVocabFixture({String cardId = 'card-1'}) {
  return StoredVocabItem(
    id: 'vocab-1',
    cardId: cardId,
    japanese: 'ノート',
    reading: 'ノート',
    meaning: 'notebook',
    approxJlpt: 'N5',
  );
}

class FakeFrameSource implements FrameSource {
  FakeFrameSource({this.startError});

  final Object? startError;
  final _frames = StreamController<CameraFrame>.broadcast();
  bool started = false;
  int stopCount = 0;

  @override
  Stream<CameraFrame> get frames => _frames.stream;

  void emit(CameraFrame frame) => _frames.add(frame);

  @override
  Future<void> start({required Duration interval}) async {
    if (startError != null) {
      throw startError!;
    }
    started = true;
  }

  @override
  Future<void> stop() async {
    stopCount++;
    started = false;
  }

  @override
  Future<void> dispose() async {
    await _frames.close();
  }
}

class FakeTutorGenerationService implements TutorGenerationService {
  FakeTutorGenerationService(this.result);

  final TutorResult result;
  int callCount = 0;

  @override
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required JlptLevel level,
  }) async {
    callCount++;
    return result;
  }
}

class DelayedTutorGenerationService implements TutorGenerationService {
  final called = Completer<void>();
  final result = Completer<TutorResult>();

  @override
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required JlptLevel level,
  }) {
    if (!called.isCompleted) {
      called.complete();
    }
    return result.future;
  }
}

class FakeSpeechService implements SpeechService {
  final spoken = <String>[];

  @override
  Future<void> speakJapanese(String text) async {
    spoken.add(text);
  }

  @override
  Future<void> stop() async {}
}

class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository([AppSettings? settings])
    : settings = settings ?? AppSettings.defaults();

  AppSettings settings;

  @override
  Future<AppSettings> load() async => settings;

  @override
  Future<void> save(AppSettings settings) async {
    this.settings = settings;
  }
}

class FakeSrsRepository implements SrsRepository {
  final dueCardsController = StreamController<List<LearningCard>>.broadcast();
  final insertedLessons = <TutorResult>[];
  final reviews = <({String cardId, ReviewGrade grade})>[];
  List<StoredVocabItem> vocab = [storedVocabFixture()];

  @override
  Stream<List<LearningCard>> watchDueCards(DateTime now) {
    return dueCardsController.stream;
  }

  @override
  Future<LearningCard?> insertGeneratedCard({
    required TutorResult lesson,
    required JlptLevel targetLevel,
    required DateTime now,
    required String source,
  }) async {
    insertedLessons.add(lesson);
    return learningCardFixture();
  }

  @override
  Future<void> recordReview({
    required String cardId,
    required ReviewGrade grade,
    required DateTime now,
  }) async {
    reviews.add((cardId: cardId, grade: grade));
  }

  @override
  Future<List<StoredVocabItem>> getVocabularyForCard(String cardId) async {
    return vocab.where((item) => item.cardId == cardId).toList();
  }

  Future<void> dispose() => dueCardsController.close();
}

ProviderScope testScope({
  required Widget child,
  FrameSource? frameSource,
  TutorGenerationService? tutorService,
  FakeSpeechService? speechService,
  FakeSrsRepository? srsRepository,
  SettingsRepository? settingsRepository,
}) {
  return ProviderScope(
    overrides: [
      if (frameSource != null)
        frameSourceProvider.overrideWithValue(frameSource),
      if (tutorService != null)
        tutorGenerationServiceProvider.overrideWithValue(tutorService),
      if (speechService != null)
        speechServiceProvider.overrideWithValue(speechService),
      if (srsRepository != null)
        srsRepositoryProvider.overrideWithValue(srsRepository),
      if (settingsRepository != null)
        settingsRepositoryProvider.overrideWithValue(settingsRepository),
    ],
    child: MaterialApp(home: child),
  );
}

Future<void> pumpTestWidget(
  WidgetTester tester, {
  required Widget child,
  FrameSource? frameSource,
  TutorGenerationService? tutorService,
  FakeSpeechService? speechService,
  FakeSrsRepository? srsRepository,
  SettingsRepository? settingsRepository,
}) {
  return tester.pumpWidget(
    testScope(
      child: child,
      frameSource: frameSource,
      tutorService: tutorService,
      speechService: speechService,
      srsRepository: srsRepository,
      settingsRepository: settingsRepository,
    ),
  );
}
