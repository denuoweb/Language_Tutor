import '../../data/models/tutor_result.dart';
import '../../shared/jlpt_level.dart';
import '../capture/camera_frame.dart';

abstract interface class TutorGenerationService {
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required JlptLevel level,
  });
}
