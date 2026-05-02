import 'package:firebase_ai/firebase_ai.dart';

import 'tutor_result.dart';

const tutorResponseSchemaKeys = TutorResult.requiredJsonKeys;

final tutorResponseSchema = Schema.object(
  properties: {
    'sceneLabel': Schema.string(description: 'Short visible scene label.'),
    'english': Schema.string(description: 'English meaning of the lesson.'),
    'japanese': Schema.string(description: 'Natural Japanese sentence.'),
    'reading': Schema.string(description: 'Kana reading of the Japanese.'),
    'keyVocabulary': Schema.array(
      maxItems: 4,
      items: Schema.object(
        properties: {
          'japanese': Schema.string(),
          'reading': Schema.string(),
          'meaning': Schema.string(),
          'approxJlpt': Schema.enumString(
            enumValues: ['N5', 'N4', 'N3', 'N2', 'N1', 'unknown'],
          ),
        },
        propertyOrdering: ['japanese', 'reading', 'meaning', 'approxJlpt'],
      ),
    ),
    'grammarNote': Schema.string(description: 'One short grammar note.'),
    'confidence': Schema.number(
      format: 'double',
      minimum: 0,
      maximum: 1,
      description: 'Confidence that the lesson matches the image.',
    ),
  },
  propertyOrdering: tutorResponseSchemaKeys,
);
