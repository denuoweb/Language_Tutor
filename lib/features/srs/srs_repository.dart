import '../../data/database/app_database.dart';
import '../../data/models/tutor_result.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import 'review_grade.dart';

abstract interface class SrsRepository {
  Stream<List<LearningCard>> watchDueCards(DateTime now);

  Future<LearningCard?> insertGeneratedCard({
    required TutorResult lesson,
    required TargetLanguage targetLanguage,
    required ProficiencyLevel targetLevel,
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
