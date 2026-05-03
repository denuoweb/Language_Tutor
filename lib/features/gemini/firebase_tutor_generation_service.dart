import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';

import '../../data/models/tutor_result.dart';
import '../../data/models/tutor_result_schema.dart';
import '../../shared/jlpt_level.dart';
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
You are an ambient Japanese language tutor.
Analyze the camera image. Select exactly one useful visible object, action, or scene.
Return one level-appropriate Japanese learning item only.
Prefer ordinary daily-life phrases.
Use natural Japanese, include kana reading, and keep grammar notes short.
Keep the grammar note under 20 words.
Avoid rare vocabulary unless the image clearly requires it.
Do not invent objects or actions not visible in the image.
''';

  final GenerativeModel _model;

  @override
  Future<TutorResult> generateFromFrame({
    required CameraFrame frame,
    required JlptLevel level,
  }) async {
    final response = await _model.generateContent([
      Content.multi([
        TextPart(_prompt(level)),
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

  String _prompt(JlptLevel level) {
    return '''
Target language: Japanese.
Target level: ${level.label}.

Rules:
- Return one useful learning item only.
- Use the image as the source of truth.
- Include one natural Japanese sentence, kana reading, English meaning, vocabulary, a short grammar note, and confidence.
- Return JSON matching the provided response schema.
''';
  }

  void _validateResult(TutorResult result) {
    if (result.sceneLabel.trim().isEmpty ||
        result.english.trim().isEmpty ||
        result.japanese.trim().isEmpty ||
        result.reading.trim().isEmpty ||
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
