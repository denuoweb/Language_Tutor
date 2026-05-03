import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';

import '../../data/models/tutor_result.dart';
import '../../data/models/tutor_result_schema.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import '../capture/camera_frame.dart';
import 'tutor_generation_service.dart';

class FirebaseTutorGenerationService implements TutorGenerationService {
  FirebaseTutorGenerationService({GenerativeModel? model})
    : _model =
          model ??
          FirebaseAI.googleAI().generativeModel(
            model: 'gemini-2.5-flash',
            generationConfig: GenerationConfig(
              responseMimeType: 'application/json',
              responseSchema: tutorResponseSchema,
              temperature: 0.4,
            ),
            systemInstruction: Content.system(_systemInstruction),
          );

  static const _systemInstruction = '''
You are an ambient language tutor.
Analyze the camera image. Select exactly one useful visible object, action, or scene.
Return one target-language learning item only.
Prefer ordinary daily-life phrases and practical vocabulary.
Keep the grammar note under 20 words.
Avoid rare vocabulary unless the image clearly requires it.
Do not invent objects or actions not visible in the image.
''';

  final GenerativeModel _model;

  @override
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required TargetLanguage language,
    required ProficiencyLevel level,
  }) async {
    final response = await _model.generateContent([
      Content.multi([
        TextPart(_prompt(language, level)),
        InlineDataPart(frame.mimeType, frame.bytes),
      ]),
    ]);

    final text = response.text;
    if (text == null || text.trim().isEmpty) {
      throw const FormatException('Gemini returned an empty response.');
    }

    final decoded = jsonDecode(text);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Gemini response was not a JSON object.');
    }
    final result = TutorResult.fromJson(decoded);
    _validateResult(result);
    return result;
  }

  String _prompt(TargetLanguage language, ProficiencyLevel level) {
    return '''
Target language: ${language.label}.
Target-language writing guidance: ${language.lessonInstructions}
Pronunciation guidance: ${language.pronunciationInstructions}
Target level: ${level.label}.
Level guidance: ${level.promptGuidance}

Rules:
- Return one useful learning item only.
- Use the image as the source of truth.
- Include one natural sentence in the target language, a pronunciation guide, English meaning, vocabulary, a short grammar note in English, and confidence.
- Use `unknown` if a vocabulary item's approximate level is unclear.
- Return JSON matching the provided response schema.
''';
  }

  void _validateResult(TutorResult result) {
    if (result.sceneLabel.trim().isEmpty ||
        result.english.trim().isEmpty ||
        result.targetText.trim().isEmpty ||
        result.pronunciation.trim().isEmpty ||
        result.grammarNote.trim().isEmpty) {
      throw const FormatException(
        'Gemini response was missing required lesson content.',
      );
    }

    if (result.keyVocabulary.isEmpty) {
      throw const FormatException(
        'Gemini response must include at least one vocabulary item.',
      );
    }

    if (_wordCount(result.grammarNote) > 20) {
      throw const FormatException(
        'Gemini grammar note exceeded the 20-word limit.',
      );
    }
  }

  int _wordCount(String value) {
    return value
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .length;
  }
}
