import '../../data/models/tutor_result.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import '../capture/camera_frame.dart';
import 'tutor_generation_service.dart';

class DemoTutorGenerationService implements TutorGenerationService {
  const DemoTutorGenerationService();

  @override
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required TargetLanguage language,
    required ProficiencyLevel level,
  }) async {
    return TutorResult(
      sceneLabel: 'desk object',
      english: 'There is a notebook here.',
      targetText: language.demoSentence,
      pronunciation: language.demoPronunciation,
      keyVocabulary: [
        VocabItem(
          targetText: language.demoVocabulary,
          pronunciation: language.demoVocabularyPronunciation,
          meaning: language.demoMeaning,
          approxLevel: level.label,
        ),
      ],
      grammarNote: _grammarNoteFor(level),
      confidence: 0.95,
    );
  }

  String _grammarNoteFor(ProficiencyLevel level) {
    return switch (level) {
      ProficiencyLevel.beginner =>
        'Simple location sentence with everyday vocabulary.',
      ProficiencyLevel.elementary =>
        'Adds a small amount of structure beyond a basic label.',
      ProficiencyLevel.intermediate =>
        'Uses natural phrasing suitable for everyday conversation.',
      ProficiencyLevel.upperIntermediate =>
        'Uses fuller phrasing while staying tied to the visible object.',
      ProficiencyLevel.advanced =>
        'Uses more polished phrasing without leaving the image context.',
    };
  }
}
