import '../../data/database/app_database.dart';
import '../../data/models/tutor_result.dart';
import '../../shared/jlpt_level.dart';
import 'review_grade.dart';

abstract interface class SrsRepository {
  Stream<List<LearningCard>> watchDueCards(DateTime now);

  Future<LearningCard?> insertGeneratedCard({
    required TutorResult lesson,
    required JlptLevel targetLevel,
    required DateTime now,
    required String source,
  });

  Future<void> recordReview({
    required String cardId,
    required ReviewGrade grade,
    required DateTime now,
  });

  Future<List<StoredVocabItem>> getVocabularyForCard(String cardId);
}
