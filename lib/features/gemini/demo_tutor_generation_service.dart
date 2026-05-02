import '../../data/models/tutor_result.dart';
import '../../shared/jlpt_level.dart';
import '../capture/camera_frame.dart';
import 'tutor_generation_service.dart';

class DemoTutorGenerationService implements TutorGenerationService {
  const DemoTutorGenerationService();

  @override
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required JlptLevel level,
  }) async {
    return TutorResult(
      sceneLabel: 'desk object',
      english: 'There is a notebook here.',
      japanese: switch (level) {
        JlptLevel.n5 => 'ここにノートがあります。',
        JlptLevel.n4 => '机の上にノートが置いてあります。',
        JlptLevel.n3 => '机の上にノートが開いたままになっています。',
        JlptLevel.n2 => '机の上には、使いかけのノートが置かれています。',
        JlptLevel.n1 => '机上には、書きかけと思われるノートが広げられています。',
      },
      reading: switch (level) {
        JlptLevel.n5 => 'ここにノートがあります。',
        JlptLevel.n4 => 'つくえのうえにノートがおいてあります。',
        JlptLevel.n3 => 'つくえのうえにノートがひらいたままになっています。',
        JlptLevel.n2 => 'つくえのうえには、つかいかけのノートがおかれています。',
        JlptLevel.n1 => 'きじょうには、かきかけとおもわれるノートがひろげられています。',
      },
      keyVocabulary: const [
        VocabItem(
          japanese: 'ノート',
          reading: 'ノート',
          meaning: 'notebook',
          approxJlpt: 'N5',
        ),
      ],
      grammarNote: 'あります marks the existence of an inanimate object.',
      confidence: 0.95,
    );
  }
}
