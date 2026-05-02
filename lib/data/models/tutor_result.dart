import 'package:json_annotation/json_annotation.dart';

part 'tutor_result.g.dart';

@JsonSerializable(checked: true, disallowUnrecognizedKeys: true)
class TutorResult {
  const TutorResult({
    required this.sceneLabel,
    required this.english,
    required this.japanese,
    required this.reading,
    required this.keyVocabulary,
    required this.grammarNote,
    required this.confidence,
  });

  factory TutorResult.fromJson(Map<String, dynamic> json) =>
      _$TutorResultFromJson(json);

  static const requiredJsonKeys = <String>[
    'sceneLabel',
    'english',
    'japanese',
    'reading',
    'keyVocabulary',
    'grammarNote',
    'confidence',
  ];

  final String sceneLabel;
  final String english;
  final String japanese;
  final String reading;
  final List<VocabItem> keyVocabulary;
  final String grammarNote;
  final double confidence;

  Map<String, dynamic> toJson() => _$TutorResultToJson(this);
}

@JsonSerializable(checked: true, disallowUnrecognizedKeys: true)
class VocabItem {
  const VocabItem({
    required this.japanese,
    required this.reading,
    required this.meaning,
    required this.approxJlpt,
  });

  factory VocabItem.fromJson(Map<String, dynamic> json) =>
      _$VocabItemFromJson(json);

  final String japanese;
  final String reading;
  final String meaning;
  final String approxJlpt;

  Map<String, dynamic> toJson() => _$VocabItemToJson(this);
}
