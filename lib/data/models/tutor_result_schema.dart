import 'package:firebase_ai/firebase_ai.dart';

import '../../shared/proficiency_level.dart';
import 'tutor_result.dart';

const tutorResponseSchemaKeys = TutorResult.requiredJsonKeys;

final tutorResponseSchema = Schema.object(
  properties: {
    'sceneLabel': Schema.string(description: 'Short visible scene label.'),
    'english': Schema.string(description: 'English meaning of the lesson.'),
    'targetText': Schema.string(
      description: 'Natural sentence in the requested target language.',
    ),
    'pronunciation': Schema.string(
      description: 'Pronunciation guide for the target language sentence.',
    ),
    'keyVocabulary': Schema.array(
      maxItems: 4,
      items: Schema.object(
        properties: {
          'targetText': Schema.string(),
          'pronunciation': Schema.string(),
          'meaning': Schema.string(),
          'approxLevel': Schema.enumString(
            enumValues: ProficiencyLevel.schemaValues,
          ),
        },
        propertyOrdering: [
          'targetText',
          'pronunciation',
          'meaning',
          'approxLevel',
        ],
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
