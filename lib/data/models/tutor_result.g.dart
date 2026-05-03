// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorResult _$TutorResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TutorResult', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'sceneLabel',
          'english',
          'targetText',
          'pronunciation',
          'keyVocabulary',
          'grammarNote',
          'confidence',
        ],
      );
      final val = TutorResult(
        sceneLabel: $checkedConvert('sceneLabel', (v) => v as String),
        english: $checkedConvert('english', (v) => v as String),
        targetText: $checkedConvert('targetText', (v) => v as String),
        pronunciation: $checkedConvert('pronunciation', (v) => v as String),
        keyVocabulary: $checkedConvert(
          'keyVocabulary',
          (v) => (v as List<dynamic>)
              .map((e) => VocabItem.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        grammarNote: $checkedConvert('grammarNote', (v) => v as String),
        confidence: $checkedConvert('confidence', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$TutorResultToJson(TutorResult instance) =>
    <String, dynamic>{
      'sceneLabel': instance.sceneLabel,
      'english': instance.english,
      'targetText': instance.targetText,
      'pronunciation': instance.pronunciation,
      'keyVocabulary': instance.keyVocabulary,
      'grammarNote': instance.grammarNote,
      'confidence': instance.confidence,
    };

VocabItem _$VocabItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('VocabItem', json, ($checkedConvert) {
      $checkKeys(
        json,
        allowedKeys: const [
          'targetText',
          'pronunciation',
          'meaning',
          'approxLevel',
        ],
      );
      final val = VocabItem(
        targetText: $checkedConvert('targetText', (v) => v as String),
        pronunciation: $checkedConvert('pronunciation', (v) => v as String),
        meaning: $checkedConvert('meaning', (v) => v as String),
        approxLevel: $checkedConvert('approxLevel', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$VocabItemToJson(VocabItem instance) => <String, dynamic>{
  'targetText': instance.targetText,
  'pronunciation': instance.pronunciation,
  'meaning': instance.meaning,
  'approxLevel': instance.approxLevel,
};
