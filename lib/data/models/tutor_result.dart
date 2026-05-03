import 'package:json_annotation/json_annotation.dart';

part 'tutor_result.g.dart';

@JsonSerializable(checked: true, disallowUnrecognizedKeys: true)
class TutorResult {
  const TutorResult({
    required this.sceneLabel,
    required this.english,
    required this.targetText,
    required this.pronunciation,
    required this.keyVocabulary,
    required this.grammarNote,
    required this.confidence,
  });

  factory TutorResult.fromJson(Map<String, dynamic> json) =>
      _$TutorResultFromJson(json);

  static const requiredJsonKeys = <String>[
    'sceneLabel',
    'english',
    'targetText',
    'pronunciation',
    'keyVocabulary',
    'grammarNote',
    'confidence',
  ];

  final String sceneLabel;
  final String english;
  final String targetText;
  final String pronunciation;
  final List<VocabItem> keyVocabulary;
  final String grammarNote;
  final double confidence;

  Map<String, dynamic> toJson() => _$TutorResultToJson(this);
}

@JsonSerializable(checked: true, disallowUnrecognizedKeys: true)
class VocabItem {
  const VocabItem({
    required this.targetText,
    required this.pronunciation,
    required this.meaning,
    required this.approxLevel,
  });

  factory VocabItem.fromJson(Map<String, dynamic> json) =>
      _$VocabItemFromJson(json);

  final String targetText;
  final String pronunciation;
  final String meaning;
  final String approxLevel;

  Map<String, dynamic> toJson() => _$VocabItemToJson(this);
}
