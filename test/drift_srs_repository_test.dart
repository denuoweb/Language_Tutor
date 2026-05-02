import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_tutor/data/database/app_database.dart';
import 'package:language_tutor/features/srs/drift_srs_repository.dart';
import 'package:language_tutor/features/srs/review_grade.dart';
import 'package:language_tutor/shared/jlpt_level.dart';

import 'test_helpers.dart';

void main() {
  late AppDatabase database;
  late DriftSrsRepository repository;
  final now = DateTime.utc(2026, 1, 1, 12);

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftSrsRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test(
    'inserts generated card, vocabulary, and due card query finds it',
    () async {
      final card = await repository.insertGeneratedCard(
        lesson: lessonFixture(),
        targetLevel: JlptLevel.n5,
        now: now,
        source: 'test',
      );

      expect(card, isNotNull);
      final dueCards = await repository.watchDueCards(now).first;
      final vocab = await repository.getVocabularyForCard(card!.id);

      expect(dueCards.single.id, card.id);
      expect(vocab.single.japanese, 'ノート');
    },
  );

  test(
    'duplicate cache blocks repeated primary vocabulary in cooldown window',
    () async {
      final first = await repository.insertGeneratedCard(
        lesson: lessonFixture(),
        targetLevel: JlptLevel.n5,
        now: now,
        source: 'test',
      );
      final duplicate = await repository.insertGeneratedCard(
        lesson: lessonFixture(),
        targetLevel: JlptLevel.n5,
        now: now.add(const Duration(minutes: 5)),
        source: 'test',
      );

      expect(first, isNotNull);
      expect(duplicate, isNull);
    },
  );

  test('review transaction updates card schedule and logs event', () async {
    final card = await repository.insertGeneratedCard(
      lesson: lessonFixture(),
      targetLevel: JlptLevel.n5,
      now: now,
      source: 'test',
    );

    await repository.recordReview(
      cardId: card!.id,
      grade: ReviewGrade.good,
      now: now,
    );

    final updated = await (database.select(
      database.learningCards,
    )..where((candidate) => candidate.id.equals(card.id))).getSingle();
    final events = await database.select(database.reviewEvents).get();

    expect(updated.intervalDays, 1);
    expect(updated.repetitions, 1);
    expect(events.single.cardId, card.id);
    expect(events.single.grade, ReviewGrade.good.label);
  });
}
