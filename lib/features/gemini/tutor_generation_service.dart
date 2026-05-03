import '../../data/models/tutor_result.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import '../capture/camera_frame.dart';

abstract interface class TutorGenerationService {
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required TargetLanguage language,
    required ProficiencyLevel level,
  });
}
