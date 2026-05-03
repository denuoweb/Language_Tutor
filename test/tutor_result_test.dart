import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:language_tutor/data/models/tutor_result.dart';
import 'package:language_tutor/data/models/tutor_result_schema.dart';

void main() {
  test('parses valid Gemini lesson JSON', () {
    final result = TutorResult.fromJson({
      'sceneLabel': 'desk',
      'english': 'There is a notebook.',
      'targetText': 'ここにノートがあります。',
      'pronunciation': 'ここにノートがあります。',
      'keyVocabulary': [
        {
          'targetText': 'ノート',
          'pronunciation': 'ノート',
          'meaning': 'notebook',
          'approxLevel': 'Beginner',
        },
      ],
      'grammarNote': 'あります marks existence.',
      'confidence': 0.9,
    });

    expect(result.sceneLabel, 'desk');
    expect(result.keyVocabulary.single.meaning, 'notebook');
    expect(result.confidence, 0.9);
  });

  test('rejects malformed Gemini JSON with missing required fields', () {
    expect(
      () => TutorResult.fromJson({
        'sceneLabel': 'desk',
        'english': 'There is a notebook.',
      }),
      throwsA(isA<CheckedFromJsonException>()),
    );
  });

  test('response schema keys match required parser keys', () {
    expect(tutorResponseSchemaKeys, TutorResult.requiredJsonKeys);
    expect(tutorResponseSchema.propertyOrdering, TutorResult.requiredJsonKeys);
  });
}
