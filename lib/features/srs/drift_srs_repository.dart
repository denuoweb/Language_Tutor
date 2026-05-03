import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../data/database/app_database.dart';
import '../../data/models/tutor_result.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import 'review_grade.dart';
import 'srs_repository.dart';
import 'srs_scheduler.dart';

class DriftSrsRepository implements SrsRepository {
  DriftSrsRepository(this._database, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  static const duplicateCooldown = Duration(minutes: 30);

  final AppDatabase _database;
  final Uuid _uuid;

  @override
  Stream<List<LearningCard>> watchDueCards(DateTime now) {
    final nowMillis = now.millisecondsSinceEpoch;
    final query = _database.select(_database.learningCards)
      ..where((card) => card.suspended.equals(false))
      ..where((card) => card.dueAt.isSmallerOrEqualValue(nowMillis))
      ..orderBy([(card) => OrderingTerm.asc(card.dueAt)]);
    return query.watch();
  }

  @override
  Future<LearningCard?> insertGeneratedCard({
    required TutorResult lesson,
    required TargetLanguage targetLanguage,
    required ProficiencyLevel targetLevel,
    required DateTime now,
    required String source,
  }) {
    return _database.transaction(() async {
      final nowMillis = now.millisecondsSinceEpoch;
      await (_database.delete(
        _database.recentGenerationCache,
      )..where((cache) => cache.expiresAt.isSmallerThanValue(nowMillis))).go();

      final primaryVocab = _primaryVocabFor(lesson);
      final duplicate =
          await (_database.select(_database.recentGenerationCache)
                ..where((cache) => cache.primaryVocab.equals(primaryVocab))
                ..where((cache) => cache.expiresAt.isBiggerThanValue(nowMillis))
                ..limit(1))
              .getSingleOrNull();
      if (duplicate != null) {
        return null;
      }

      final cardId = _uuid.v4();
      final card = LearningCardsCompanion.insert(
        id: cardId,
        sceneLabel: lesson.sceneLabel,
        english: lesson.english,
        targetText: lesson.targetText,
        pronunciation: lesson.pronunciation,
        grammarNote: lesson.grammarNote,
        targetLanguage: targetLanguage.code,
        targetLevel: targetLevel.label,
        source: source,
        createdAt: nowMillis,
        dueAt: nowMillis,
        intervalDays: 0,
        ease: 2.5,
        repetitions: 0,
        lapses: 0,
      );
      await _database.into(_database.learningCards).insert(card);

      for (final vocab in lesson.keyVocabulary) {
        await _database
            .into(_database.vocabItems)
            .insert(
              VocabItemsCompanion.insert(
                id: _uuid.v4(),
                cardId: cardId,
                targetText: vocab.targetText,
                pronunciation: vocab.pronunciation,
                meaning: vocab.meaning,
                approxLevel: ProficiencyLevel.normalizeApproxLevel(
                  vocab.approxLevel,
                ),
              ),
            );
      }

      await _database
          .into(_database.recentGenerationCache)
          .insert(
            RecentGenerationCacheCompanion.insert(
              id: _uuid.v4(),
              sceneLabel: lesson.sceneLabel,
              primaryVocab: primaryVocab,
              createdAt: nowMillis,
              expiresAt: now.add(duplicateCooldown).millisecondsSinceEpoch,
            ),
          );

      return (_database.select(
        _database.learningCards,
      )..where((card) => card.id.equals(cardId))).getSingle();
    });
  }

  @override
  Future<void> recordReview({
    required String cardId,
    required ReviewGrade grade,
    required DateTime now,
  }) {
    return _database.transaction(() async {
      final card = await (_database.select(
        _database.learningCards,
      )..where((candidate) => candidate.id.equals(cardId))).getSingle();

      final result = scheduleReview(
        input: SrsScheduleInput(
          dueAt: DateTime.fromMillisecondsSinceEpoch(card.dueAt, isUtc: true),
          intervalDays: card.intervalDays,
          ease: card.ease,
          repetitions: card.repetitions,
          lapses: card.lapses,
        ),
        grade: grade,
        now: now,
      );

      await (_database.update(
        _database.learningCards,
      )..where((candidate) => candidate.id.equals(cardId))).write(
        LearningCardsCompanion(
          dueAt: Value(result.dueAt.millisecondsSinceEpoch),
          intervalDays: Value(result.intervalDays),
          ease: Value(result.ease),
          repetitions: Value(result.repetitions),
          lapses: Value(result.lapses),
        ),
      );

      await _database
          .into(_database.reviewEvents)
          .insert(
            ReviewEventsCompanion.insert(
              id: _uuid.v4(),
              cardId: cardId,
              reviewedAt: now.millisecondsSinceEpoch,
              grade: grade.label,
              previousDueAt: card.dueAt,
              nextDueAt: result.dueAt.millisecondsSinceEpoch,
              previousIntervalDays: card.intervalDays,
              nextIntervalDays: result.intervalDays,
              previousEase: card.ease,
              nextEase: result.ease,
            ),
          );
    });
  }

  @override
  Future<List<StoredVocabItem>> getVocabularyForCard(String cardId) {
    final query = _database.select(_database.vocabItems)
      ..where((vocab) => vocab.cardId.equals(cardId));
    return query.get();
  }

  String _primaryVocabFor(TutorResult lesson) {
    if (lesson.keyVocabulary.isNotEmpty) {
      return lesson.keyVocabulary.first.targetText.trim();
    }
    return lesson.sceneLabel.trim().toLowerCase();
  }
}
