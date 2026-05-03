// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LearningCardsTable extends LearningCards
    with TableInfo<$LearningCardsTable, LearningCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sceneLabelMeta = const VerificationMeta(
    'sceneLabel',
  );
  @override
  late final GeneratedColumn<String> sceneLabel = GeneratedColumn<String>(
    'scene_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _englishMeta = const VerificationMeta(
    'english',
  );
  @override
  late final GeneratedColumn<String> english = GeneratedColumn<String>(
    'english',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTextMeta = const VerificationMeta(
    'targetText',
  );
  @override
  late final GeneratedColumn<String> targetText = GeneratedColumn<String>(
    'target_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pronunciationMeta = const VerificationMeta(
    'pronunciation',
  );
  @override
  late final GeneratedColumn<String> pronunciation = GeneratedColumn<String>(
    'pronunciation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grammarNoteMeta = const VerificationMeta(
    'grammarNote',
  );
  @override
  late final GeneratedColumn<String> grammarNote = GeneratedColumn<String>(
    'grammar_note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetLanguageMeta = const VerificationMeta(
    'targetLanguage',
  );
  @override
  late final GeneratedColumn<String> targetLanguage = GeneratedColumn<String>(
    'target_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetLevelMeta = const VerificationMeta(
    'targetLevel',
  );
  @override
  late final GeneratedColumn<String> targetLevel = GeneratedColumn<String>(
    'target_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<int> dueAt = GeneratedColumn<int>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _easeMeta = const VerificationMeta('ease');
  @override
  late final GeneratedColumn<double> ease = GeneratedColumn<double>(
    'ease',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
    'lapses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _suspendedMeta = const VerificationMeta(
    'suspended',
  );
  @override
  late final GeneratedColumn<bool> suspended = GeneratedColumn<bool>(
    'suspended',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("suspended" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sceneLabel,
    english,
    targetText,
    pronunciation,
    grammarNote,
    targetLanguage,
    targetLevel,
    source,
    createdAt,
    dueAt,
    intervalDays,
    ease,
    repetitions,
    lapses,
    suspended,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningCard> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('scene_label')) {
      context.handle(
        _sceneLabelMeta,
        sceneLabel.isAcceptableOrUnknown(data['scene_label']!, _sceneLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_sceneLabelMeta);
    }
    if (data.containsKey('english')) {
      context.handle(
        _englishMeta,
        english.isAcceptableOrUnknown(data['english']!, _englishMeta),
      );
    } else if (isInserting) {
      context.missing(_englishMeta);
    }
    if (data.containsKey('target_text')) {
      context.handle(
        _targetTextMeta,
        targetText.isAcceptableOrUnknown(data['target_text']!, _targetTextMeta),
      );
    } else if (isInserting) {
      context.missing(_targetTextMeta);
    }
    if (data.containsKey('pronunciation')) {
      context.handle(
        _pronunciationMeta,
        pronunciation.isAcceptableOrUnknown(
          data['pronunciation']!,
          _pronunciationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pronunciationMeta);
    }
    if (data.containsKey('grammar_note')) {
      context.handle(
        _grammarNoteMeta,
        grammarNote.isAcceptableOrUnknown(
          data['grammar_note']!,
          _grammarNoteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_grammarNoteMeta);
    }
    if (data.containsKey('target_language')) {
      context.handle(
        _targetLanguageMeta,
        targetLanguage.isAcceptableOrUnknown(
          data['target_language']!,
          _targetLanguageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetLanguageMeta);
    }
    if (data.containsKey('target_level')) {
      context.handle(
        _targetLevelMeta,
        targetLevel.isAcceptableOrUnknown(
          data['target_level']!,
          _targetLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetLevelMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalDaysMeta);
    }
    if (data.containsKey('ease')) {
      context.handle(
        _easeMeta,
        ease.isAcceptableOrUnknown(data['ease']!, _easeMeta),
      );
    } else if (isInserting) {
      context.missing(_easeMeta);
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repetitionsMeta);
    }
    if (data.containsKey('lapses')) {
      context.handle(
        _lapsesMeta,
        lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta),
      );
    } else if (isInserting) {
      context.missing(_lapsesMeta);
    }
    if (data.containsKey('suspended')) {
      context.handle(
        _suspendedMeta,
        suspended.isAcceptableOrUnknown(data['suspended']!, _suspendedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningCard(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sceneLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scene_label'],
      )!,
      english: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}english'],
      )!,
      targetText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_text'],
      )!,
      pronunciation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pronunciation'],
      )!,
      grammarNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_note'],
      )!,
      targetLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_language'],
      )!,
      targetLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_level'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_at'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      ease: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      lapses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lapses'],
      )!,
      suspended: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}suspended'],
      )!,
    );
  }

  @override
  $LearningCardsTable createAlias(String alias) {
    return $LearningCardsTable(attachedDatabase, alias);
  }
}

class LearningCard extends DataClass implements Insertable<LearningCard> {
  final String id;
  final String sceneLabel;
  final String english;
  final String targetText;
  final String pronunciation;
  final String grammarNote;
  final String targetLanguage;
  final String targetLevel;
  final String source;
  final int createdAt;
  final int dueAt;
  final int intervalDays;
  final double ease;
  final int repetitions;
  final int lapses;
  final bool suspended;
  const LearningCard({
    required this.id,
    required this.sceneLabel,
    required this.english,
    required this.targetText,
    required this.pronunciation,
    required this.grammarNote,
    required this.targetLanguage,
    required this.targetLevel,
    required this.source,
    required this.createdAt,
    required this.dueAt,
    required this.intervalDays,
    required this.ease,
    required this.repetitions,
    required this.lapses,
    required this.suspended,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['scene_label'] = Variable<String>(sceneLabel);
    map['english'] = Variable<String>(english);
    map['target_text'] = Variable<String>(targetText);
    map['pronunciation'] = Variable<String>(pronunciation);
    map['grammar_note'] = Variable<String>(grammarNote);
    map['target_language'] = Variable<String>(targetLanguage);
    map['target_level'] = Variable<String>(targetLevel);
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<int>(createdAt);
    map['due_at'] = Variable<int>(dueAt);
    map['interval_days'] = Variable<int>(intervalDays);
    map['ease'] = Variable<double>(ease);
    map['repetitions'] = Variable<int>(repetitions);
    map['lapses'] = Variable<int>(lapses);
    map['suspended'] = Variable<bool>(suspended);
    return map;
  }

  LearningCardsCompanion toCompanion(bool nullToAbsent) {
    return LearningCardsCompanion(
      id: Value(id),
      sceneLabel: Value(sceneLabel),
      english: Value(english),
      targetText: Value(targetText),
      pronunciation: Value(pronunciation),
      grammarNote: Value(grammarNote),
      targetLanguage: Value(targetLanguage),
      targetLevel: Value(targetLevel),
      source: Value(source),
      createdAt: Value(createdAt),
      dueAt: Value(dueAt),
      intervalDays: Value(intervalDays),
      ease: Value(ease),
      repetitions: Value(repetitions),
      lapses: Value(lapses),
      suspended: Value(suspended),
    );
  }

  factory LearningCard.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningCard(
      id: serializer.fromJson<String>(json['id']),
      sceneLabel: serializer.fromJson<String>(json['sceneLabel']),
      english: serializer.fromJson<String>(json['english']),
      targetText: serializer.fromJson<String>(json['targetText']),
      pronunciation: serializer.fromJson<String>(json['pronunciation']),
      grammarNote: serializer.fromJson<String>(json['grammarNote']),
      targetLanguage: serializer.fromJson<String>(json['targetLanguage']),
      targetLevel: serializer.fromJson<String>(json['targetLevel']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      dueAt: serializer.fromJson<int>(json['dueAt']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      ease: serializer.fromJson<double>(json['ease']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      lapses: serializer.fromJson<int>(json['lapses']),
      suspended: serializer.fromJson<bool>(json['suspended']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sceneLabel': serializer.toJson<String>(sceneLabel),
      'english': serializer.toJson<String>(english),
      'targetText': serializer.toJson<String>(targetText),
      'pronunciation': serializer.toJson<String>(pronunciation),
      'grammarNote': serializer.toJson<String>(grammarNote),
      'targetLanguage': serializer.toJson<String>(targetLanguage),
      'targetLevel': serializer.toJson<String>(targetLevel),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<int>(createdAt),
      'dueAt': serializer.toJson<int>(dueAt),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'ease': serializer.toJson<double>(ease),
      'repetitions': serializer.toJson<int>(repetitions),
      'lapses': serializer.toJson<int>(lapses),
      'suspended': serializer.toJson<bool>(suspended),
    };
  }

  LearningCard copyWith({
    String? id,
    String? sceneLabel,
    String? english,
    String? targetText,
    String? pronunciation,
    String? grammarNote,
    String? targetLanguage,
    String? targetLevel,
    String? source,
    int? createdAt,
    int? dueAt,
    int? intervalDays,
    double? ease,
    int? repetitions,
    int? lapses,
    bool? suspended,
  }) => LearningCard(
    id: id ?? this.id,
    sceneLabel: sceneLabel ?? this.sceneLabel,
    english: english ?? this.english,
    targetText: targetText ?? this.targetText,
    pronunciation: pronunciation ?? this.pronunciation,
    grammarNote: grammarNote ?? this.grammarNote,
    targetLanguage: targetLanguage ?? this.targetLanguage,
    targetLevel: targetLevel ?? this.targetLevel,
    source: source ?? this.source,
    createdAt: createdAt ?? this.createdAt,
    dueAt: dueAt ?? this.dueAt,
    intervalDays: intervalDays ?? this.intervalDays,
    ease: ease ?? this.ease,
    repetitions: repetitions ?? this.repetitions,
    lapses: lapses ?? this.lapses,
    suspended: suspended ?? this.suspended,
  );
  LearningCard copyWithCompanion(LearningCardsCompanion data) {
    return LearningCard(
      id: data.id.present ? data.id.value : this.id,
      sceneLabel: data.sceneLabel.present
          ? data.sceneLabel.value
          : this.sceneLabel,
      english: data.english.present ? data.english.value : this.english,
      targetText: data.targetText.present
          ? data.targetText.value
          : this.targetText,
      pronunciation: data.pronunciation.present
          ? data.pronunciation.value
          : this.pronunciation,
      grammarNote: data.grammarNote.present
          ? data.grammarNote.value
          : this.grammarNote,
      targetLanguage: data.targetLanguage.present
          ? data.targetLanguage.value
          : this.targetLanguage,
      targetLevel: data.targetLevel.present
          ? data.targetLevel.value
          : this.targetLevel,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      ease: data.ease.present ? data.ease.value : this.ease,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
      suspended: data.suspended.present ? data.suspended.value : this.suspended,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningCard(')
          ..write('id: $id, ')
          ..write('sceneLabel: $sceneLabel, ')
          ..write('english: $english, ')
          ..write('targetText: $targetText, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('grammarNote: $grammarNote, ')
          ..write('targetLanguage: $targetLanguage, ')
          ..write('targetLevel: $targetLevel, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('ease: $ease, ')
          ..write('repetitions: $repetitions, ')
          ..write('lapses: $lapses, ')
          ..write('suspended: $suspended')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sceneLabel,
    english,
    targetText,
    pronunciation,
    grammarNote,
    targetLanguage,
    targetLevel,
    source,
    createdAt,
    dueAt,
    intervalDays,
    ease,
    repetitions,
    lapses,
    suspended,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningCard &&
          other.id == this.id &&
          other.sceneLabel == this.sceneLabel &&
          other.english == this.english &&
          other.targetText == this.targetText &&
          other.pronunciation == this.pronunciation &&
          other.grammarNote == this.grammarNote &&
          other.targetLanguage == this.targetLanguage &&
          other.targetLevel == this.targetLevel &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.dueAt == this.dueAt &&
          other.intervalDays == this.intervalDays &&
          other.ease == this.ease &&
          other.repetitions == this.repetitions &&
          other.lapses == this.lapses &&
          other.suspended == this.suspended);
}

class LearningCardsCompanion extends UpdateCompanion<LearningCard> {
  final Value<String> id;
  final Value<String> sceneLabel;
  final Value<String> english;
  final Value<String> targetText;
  final Value<String> pronunciation;
  final Value<String> grammarNote;
  final Value<String> targetLanguage;
  final Value<String> targetLevel;
  final Value<String> source;
  final Value<int> createdAt;
  final Value<int> dueAt;
  final Value<int> intervalDays;
  final Value<double> ease;
  final Value<int> repetitions;
  final Value<int> lapses;
  final Value<bool> suspended;
  final Value<int> rowid;
  const LearningCardsCompanion({
    this.id = const Value.absent(),
    this.sceneLabel = const Value.absent(),
    this.english = const Value.absent(),
    this.targetText = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.grammarNote = const Value.absent(),
    this.targetLanguage = const Value.absent(),
    this.targetLevel = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.ease = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.lapses = const Value.absent(),
    this.suspended = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningCardsCompanion.insert({
    required String id,
    required String sceneLabel,
    required String english,
    required String targetText,
    required String pronunciation,
    required String grammarNote,
    required String targetLanguage,
    required String targetLevel,
    required String source,
    required int createdAt,
    required int dueAt,
    required int intervalDays,
    required double ease,
    required int repetitions,
    required int lapses,
    this.suspended = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sceneLabel = Value(sceneLabel),
       english = Value(english),
       targetText = Value(targetText),
       pronunciation = Value(pronunciation),
       grammarNote = Value(grammarNote),
       targetLanguage = Value(targetLanguage),
       targetLevel = Value(targetLevel),
       source = Value(source),
       createdAt = Value(createdAt),
       dueAt = Value(dueAt),
       intervalDays = Value(intervalDays),
       ease = Value(ease),
       repetitions = Value(repetitions),
       lapses = Value(lapses);
  static Insertable<LearningCard> custom({
    Expression<String>? id,
    Expression<String>? sceneLabel,
    Expression<String>? english,
    Expression<String>? targetText,
    Expression<String>? pronunciation,
    Expression<String>? grammarNote,
    Expression<String>? targetLanguage,
    Expression<String>? targetLevel,
    Expression<String>? source,
    Expression<int>? createdAt,
    Expression<int>? dueAt,
    Expression<int>? intervalDays,
    Expression<double>? ease,
    Expression<int>? repetitions,
    Expression<int>? lapses,
    Expression<bool>? suspended,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sceneLabel != null) 'scene_label': sceneLabel,
      if (english != null) 'english': english,
      if (targetText != null) 'target_text': targetText,
      if (pronunciation != null) 'pronunciation': pronunciation,
      if (grammarNote != null) 'grammar_note': grammarNote,
      if (targetLanguage != null) 'target_language': targetLanguage,
      if (targetLevel != null) 'target_level': targetLevel,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (dueAt != null) 'due_at': dueAt,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (ease != null) 'ease': ease,
      if (repetitions != null) 'repetitions': repetitions,
      if (lapses != null) 'lapses': lapses,
      if (suspended != null) 'suspended': suspended,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningCardsCompanion copyWith({
    Value<String>? id,
    Value<String>? sceneLabel,
    Value<String>? english,
    Value<String>? targetText,
    Value<String>? pronunciation,
    Value<String>? grammarNote,
    Value<String>? targetLanguage,
    Value<String>? targetLevel,
    Value<String>? source,
    Value<int>? createdAt,
    Value<int>? dueAt,
    Value<int>? intervalDays,
    Value<double>? ease,
    Value<int>? repetitions,
    Value<int>? lapses,
    Value<bool>? suspended,
    Value<int>? rowid,
  }) {
    return LearningCardsCompanion(
      id: id ?? this.id,
      sceneLabel: sceneLabel ?? this.sceneLabel,
      english: english ?? this.english,
      targetText: targetText ?? this.targetText,
      pronunciation: pronunciation ?? this.pronunciation,
      grammarNote: grammarNote ?? this.grammarNote,
      targetLanguage: targetLanguage ?? this.targetLanguage,
      targetLevel: targetLevel ?? this.targetLevel,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      dueAt: dueAt ?? this.dueAt,
      intervalDays: intervalDays ?? this.intervalDays,
      ease: ease ?? this.ease,
      repetitions: repetitions ?? this.repetitions,
      lapses: lapses ?? this.lapses,
      suspended: suspended ?? this.suspended,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sceneLabel.present) {
      map['scene_label'] = Variable<String>(sceneLabel.value);
    }
    if (english.present) {
      map['english'] = Variable<String>(english.value);
    }
    if (targetText.present) {
      map['target_text'] = Variable<String>(targetText.value);
    }
    if (pronunciation.present) {
      map['pronunciation'] = Variable<String>(pronunciation.value);
    }
    if (grammarNote.present) {
      map['grammar_note'] = Variable<String>(grammarNote.value);
    }
    if (targetLanguage.present) {
      map['target_language'] = Variable<String>(targetLanguage.value);
    }
    if (targetLevel.present) {
      map['target_level'] = Variable<String>(targetLevel.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<int>(dueAt.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (ease.present) {
      map['ease'] = Variable<double>(ease.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (suspended.present) {
      map['suspended'] = Variable<bool>(suspended.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningCardsCompanion(')
          ..write('id: $id, ')
          ..write('sceneLabel: $sceneLabel, ')
          ..write('english: $english, ')
          ..write('targetText: $targetText, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('grammarNote: $grammarNote, ')
          ..write('targetLanguage: $targetLanguage, ')
          ..write('targetLevel: $targetLevel, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('ease: $ease, ')
          ..write('repetitions: $repetitions, ')
          ..write('lapses: $lapses, ')
          ..write('suspended: $suspended, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabItemsTable extends VocabItems
    with TableInfo<$VocabItemsTable, StoredVocabItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learning_cards (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _targetTextMeta = const VerificationMeta(
    'targetText',
  );
  @override
  late final GeneratedColumn<String> targetText = GeneratedColumn<String>(
    'target_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pronunciationMeta = const VerificationMeta(
    'pronunciation',
  );
  @override
  late final GeneratedColumn<String> pronunciation = GeneratedColumn<String>(
    'pronunciation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _approxLevelMeta = const VerificationMeta(
    'approxLevel',
  );
  @override
  late final GeneratedColumn<String> approxLevel = GeneratedColumn<String>(
    'approx_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    targetText,
    pronunciation,
    meaning,
    approxLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocab_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoredVocabItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('target_text')) {
      context.handle(
        _targetTextMeta,
        targetText.isAcceptableOrUnknown(data['target_text']!, _targetTextMeta),
      );
    } else if (isInserting) {
      context.missing(_targetTextMeta);
    }
    if (data.containsKey('pronunciation')) {
      context.handle(
        _pronunciationMeta,
        pronunciation.isAcceptableOrUnknown(
          data['pronunciation']!,
          _pronunciationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pronunciationMeta);
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('approx_level')) {
      context.handle(
        _approxLevelMeta,
        approxLevel.isAcceptableOrUnknown(
          data['approx_level']!,
          _approxLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_approxLevelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoredVocabItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoredVocabItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      targetText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_text'],
      )!,
      pronunciation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pronunciation'],
      )!,
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      )!,
      approxLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}approx_level'],
      )!,
    );
  }

  @override
  $VocabItemsTable createAlias(String alias) {
    return $VocabItemsTable(attachedDatabase, alias);
  }
}

class StoredVocabItem extends DataClass implements Insertable<StoredVocabItem> {
  final String id;
  final String cardId;
  final String targetText;
  final String pronunciation;
  final String meaning;
  final String approxLevel;
  const StoredVocabItem({
    required this.id,
    required this.cardId,
    required this.targetText,
    required this.pronunciation,
    required this.meaning,
    required this.approxLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['card_id'] = Variable<String>(cardId);
    map['target_text'] = Variable<String>(targetText);
    map['pronunciation'] = Variable<String>(pronunciation);
    map['meaning'] = Variable<String>(meaning);
    map['approx_level'] = Variable<String>(approxLevel);
    return map;
  }

  VocabItemsCompanion toCompanion(bool nullToAbsent) {
    return VocabItemsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      targetText: Value(targetText),
      pronunciation: Value(pronunciation),
      meaning: Value(meaning),
      approxLevel: Value(approxLevel),
    );
  }

  factory StoredVocabItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoredVocabItem(
      id: serializer.fromJson<String>(json['id']),
      cardId: serializer.fromJson<String>(json['cardId']),
      targetText: serializer.fromJson<String>(json['targetText']),
      pronunciation: serializer.fromJson<String>(json['pronunciation']),
      meaning: serializer.fromJson<String>(json['meaning']),
      approxLevel: serializer.fromJson<String>(json['approxLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cardId': serializer.toJson<String>(cardId),
      'targetText': serializer.toJson<String>(targetText),
      'pronunciation': serializer.toJson<String>(pronunciation),
      'meaning': serializer.toJson<String>(meaning),
      'approxLevel': serializer.toJson<String>(approxLevel),
    };
  }

  StoredVocabItem copyWith({
    String? id,
    String? cardId,
    String? targetText,
    String? pronunciation,
    String? meaning,
    String? approxLevel,
  }) => StoredVocabItem(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    targetText: targetText ?? this.targetText,
    pronunciation: pronunciation ?? this.pronunciation,
    meaning: meaning ?? this.meaning,
    approxLevel: approxLevel ?? this.approxLevel,
  );
  StoredVocabItem copyWithCompanion(VocabItemsCompanion data) {
    return StoredVocabItem(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      targetText: data.targetText.present
          ? data.targetText.value
          : this.targetText,
      pronunciation: data.pronunciation.present
          ? data.pronunciation.value
          : this.pronunciation,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      approxLevel: data.approxLevel.present
          ? data.approxLevel.value
          : this.approxLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoredVocabItem(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('targetText: $targetText, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('meaning: $meaning, ')
          ..write('approxLevel: $approxLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cardId, targetText, pronunciation, meaning, approxLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoredVocabItem &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.targetText == this.targetText &&
          other.pronunciation == this.pronunciation &&
          other.meaning == this.meaning &&
          other.approxLevel == this.approxLevel);
}

class VocabItemsCompanion extends UpdateCompanion<StoredVocabItem> {
  final Value<String> id;
  final Value<String> cardId;
  final Value<String> targetText;
  final Value<String> pronunciation;
  final Value<String> meaning;
  final Value<String> approxLevel;
  final Value<int> rowid;
  const VocabItemsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.targetText = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.meaning = const Value.absent(),
    this.approxLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabItemsCompanion.insert({
    required String id,
    required String cardId,
    required String targetText,
    required String pronunciation,
    required String meaning,
    required String approxLevel,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       targetText = Value(targetText),
       pronunciation = Value(pronunciation),
       meaning = Value(meaning),
       approxLevel = Value(approxLevel);
  static Insertable<StoredVocabItem> custom({
    Expression<String>? id,
    Expression<String>? cardId,
    Expression<String>? targetText,
    Expression<String>? pronunciation,
    Expression<String>? meaning,
    Expression<String>? approxLevel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (targetText != null) 'target_text': targetText,
      if (pronunciation != null) 'pronunciation': pronunciation,
      if (meaning != null) 'meaning': meaning,
      if (approxLevel != null) 'approx_level': approxLevel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? cardId,
    Value<String>? targetText,
    Value<String>? pronunciation,
    Value<String>? meaning,
    Value<String>? approxLevel,
    Value<int>? rowid,
  }) {
    return VocabItemsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      targetText: targetText ?? this.targetText,
      pronunciation: pronunciation ?? this.pronunciation,
      meaning: meaning ?? this.meaning,
      approxLevel: approxLevel ?? this.approxLevel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (targetText.present) {
      map['target_text'] = Variable<String>(targetText.value);
    }
    if (pronunciation.present) {
      map['pronunciation'] = Variable<String>(pronunciation.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (approxLevel.present) {
      map['approx_level'] = Variable<String>(approxLevel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabItemsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('targetText: $targetText, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('meaning: $meaning, ')
          ..write('approxLevel: $approxLevel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewEventsTable extends ReviewEvents
    with TableInfo<$ReviewEventsTable, ReviewEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learning_cards (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<int> reviewedAt = GeneratedColumn<int>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousDueAtMeta = const VerificationMeta(
    'previousDueAt',
  );
  @override
  late final GeneratedColumn<int> previousDueAt = GeneratedColumn<int>(
    'previous_due_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextDueAtMeta = const VerificationMeta(
    'nextDueAt',
  );
  @override
  late final GeneratedColumn<int> nextDueAt = GeneratedColumn<int>(
    'next_due_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousIntervalDaysMeta =
      const VerificationMeta('previousIntervalDays');
  @override
  late final GeneratedColumn<int> previousIntervalDays = GeneratedColumn<int>(
    'previous_interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextIntervalDaysMeta = const VerificationMeta(
    'nextIntervalDays',
  );
  @override
  late final GeneratedColumn<int> nextIntervalDays = GeneratedColumn<int>(
    'next_interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousEaseMeta = const VerificationMeta(
    'previousEase',
  );
  @override
  late final GeneratedColumn<double> previousEase = GeneratedColumn<double>(
    'previous_ease',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextEaseMeta = const VerificationMeta(
    'nextEase',
  );
  @override
  late final GeneratedColumn<double> nextEase = GeneratedColumn<double>(
    'next_ease',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    reviewedAt,
    grade,
    previousDueAt,
    nextDueAt,
    previousIntervalDays,
    nextIntervalDays,
    previousEase,
    nextEase,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('previous_due_at')) {
      context.handle(
        _previousDueAtMeta,
        previousDueAt.isAcceptableOrUnknown(
          data['previous_due_at']!,
          _previousDueAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousDueAtMeta);
    }
    if (data.containsKey('next_due_at')) {
      context.handle(
        _nextDueAtMeta,
        nextDueAt.isAcceptableOrUnknown(data['next_due_at']!, _nextDueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_nextDueAtMeta);
    }
    if (data.containsKey('previous_interval_days')) {
      context.handle(
        _previousIntervalDaysMeta,
        previousIntervalDays.isAcceptableOrUnknown(
          data['previous_interval_days']!,
          _previousIntervalDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousIntervalDaysMeta);
    }
    if (data.containsKey('next_interval_days')) {
      context.handle(
        _nextIntervalDaysMeta,
        nextIntervalDays.isAcceptableOrUnknown(
          data['next_interval_days']!,
          _nextIntervalDaysMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextIntervalDaysMeta);
    }
    if (data.containsKey('previous_ease')) {
      context.handle(
        _previousEaseMeta,
        previousEase.isAcceptableOrUnknown(
          data['previous_ease']!,
          _previousEaseMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousEaseMeta);
    }
    if (data.containsKey('next_ease')) {
      context.handle(
        _nextEaseMeta,
        nextEase.isAcceptableOrUnknown(data['next_ease']!, _nextEaseMeta),
      );
    } else if (isInserting) {
      context.missing(_nextEaseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reviewed_at'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      )!,
      previousDueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_due_at'],
      )!,
      nextDueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_due_at'],
      )!,
      previousIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_interval_days'],
      )!,
      nextIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_interval_days'],
      )!,
      previousEase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_ease'],
      )!,
      nextEase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}next_ease'],
      )!,
    );
  }

  @override
  $ReviewEventsTable createAlias(String alias) {
    return $ReviewEventsTable(attachedDatabase, alias);
  }
}

class ReviewEvent extends DataClass implements Insertable<ReviewEvent> {
  final String id;
  final String cardId;
  final int reviewedAt;
  final String grade;
  final int previousDueAt;
  final int nextDueAt;
  final int previousIntervalDays;
  final int nextIntervalDays;
  final double previousEase;
  final double nextEase;
  const ReviewEvent({
    required this.id,
    required this.cardId,
    required this.reviewedAt,
    required this.grade,
    required this.previousDueAt,
    required this.nextDueAt,
    required this.previousIntervalDays,
    required this.nextIntervalDays,
    required this.previousEase,
    required this.nextEase,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['card_id'] = Variable<String>(cardId);
    map['reviewed_at'] = Variable<int>(reviewedAt);
    map['grade'] = Variable<String>(grade);
    map['previous_due_at'] = Variable<int>(previousDueAt);
    map['next_due_at'] = Variable<int>(nextDueAt);
    map['previous_interval_days'] = Variable<int>(previousIntervalDays);
    map['next_interval_days'] = Variable<int>(nextIntervalDays);
    map['previous_ease'] = Variable<double>(previousEase);
    map['next_ease'] = Variable<double>(nextEase);
    return map;
  }

  ReviewEventsCompanion toCompanion(bool nullToAbsent) {
    return ReviewEventsCompanion(
      id: Value(id),
      cardId: Value(cardId),
      reviewedAt: Value(reviewedAt),
      grade: Value(grade),
      previousDueAt: Value(previousDueAt),
      nextDueAt: Value(nextDueAt),
      previousIntervalDays: Value(previousIntervalDays),
      nextIntervalDays: Value(nextIntervalDays),
      previousEase: Value(previousEase),
      nextEase: Value(nextEase),
    );
  }

  factory ReviewEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewEvent(
      id: serializer.fromJson<String>(json['id']),
      cardId: serializer.fromJson<String>(json['cardId']),
      reviewedAt: serializer.fromJson<int>(json['reviewedAt']),
      grade: serializer.fromJson<String>(json['grade']),
      previousDueAt: serializer.fromJson<int>(json['previousDueAt']),
      nextDueAt: serializer.fromJson<int>(json['nextDueAt']),
      previousIntervalDays: serializer.fromJson<int>(
        json['previousIntervalDays'],
      ),
      nextIntervalDays: serializer.fromJson<int>(json['nextIntervalDays']),
      previousEase: serializer.fromJson<double>(json['previousEase']),
      nextEase: serializer.fromJson<double>(json['nextEase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cardId': serializer.toJson<String>(cardId),
      'reviewedAt': serializer.toJson<int>(reviewedAt),
      'grade': serializer.toJson<String>(grade),
      'previousDueAt': serializer.toJson<int>(previousDueAt),
      'nextDueAt': serializer.toJson<int>(nextDueAt),
      'previousIntervalDays': serializer.toJson<int>(previousIntervalDays),
      'nextIntervalDays': serializer.toJson<int>(nextIntervalDays),
      'previousEase': serializer.toJson<double>(previousEase),
      'nextEase': serializer.toJson<double>(nextEase),
    };
  }

  ReviewEvent copyWith({
    String? id,
    String? cardId,
    int? reviewedAt,
    String? grade,
    int? previousDueAt,
    int? nextDueAt,
    int? previousIntervalDays,
    int? nextIntervalDays,
    double? previousEase,
    double? nextEase,
  }) => ReviewEvent(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    reviewedAt: reviewedAt ?? this.reviewedAt,
    grade: grade ?? this.grade,
    previousDueAt: previousDueAt ?? this.previousDueAt,
    nextDueAt: nextDueAt ?? this.nextDueAt,
    previousIntervalDays: previousIntervalDays ?? this.previousIntervalDays,
    nextIntervalDays: nextIntervalDays ?? this.nextIntervalDays,
    previousEase: previousEase ?? this.previousEase,
    nextEase: nextEase ?? this.nextEase,
  );
  ReviewEvent copyWithCompanion(ReviewEventsCompanion data) {
    return ReviewEvent(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
      grade: data.grade.present ? data.grade.value : this.grade,
      previousDueAt: data.previousDueAt.present
          ? data.previousDueAt.value
          : this.previousDueAt,
      nextDueAt: data.nextDueAt.present ? data.nextDueAt.value : this.nextDueAt,
      previousIntervalDays: data.previousIntervalDays.present
          ? data.previousIntervalDays.value
          : this.previousIntervalDays,
      nextIntervalDays: data.nextIntervalDays.present
          ? data.nextIntervalDays.value
          : this.nextIntervalDays,
      previousEase: data.previousEase.present
          ? data.previousEase.value
          : this.previousEase,
      nextEase: data.nextEase.present ? data.nextEase.value : this.nextEase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewEvent(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('grade: $grade, ')
          ..write('previousDueAt: $previousDueAt, ')
          ..write('nextDueAt: $nextDueAt, ')
          ..write('previousIntervalDays: $previousIntervalDays, ')
          ..write('nextIntervalDays: $nextIntervalDays, ')
          ..write('previousEase: $previousEase, ')
          ..write('nextEase: $nextEase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cardId,
    reviewedAt,
    grade,
    previousDueAt,
    nextDueAt,
    previousIntervalDays,
    nextIntervalDays,
    previousEase,
    nextEase,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewEvent &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.reviewedAt == this.reviewedAt &&
          other.grade == this.grade &&
          other.previousDueAt == this.previousDueAt &&
          other.nextDueAt == this.nextDueAt &&
          other.previousIntervalDays == this.previousIntervalDays &&
          other.nextIntervalDays == this.nextIntervalDays &&
          other.previousEase == this.previousEase &&
          other.nextEase == this.nextEase);
}

class ReviewEventsCompanion extends UpdateCompanion<ReviewEvent> {
  final Value<String> id;
  final Value<String> cardId;
  final Value<int> reviewedAt;
  final Value<String> grade;
  final Value<int> previousDueAt;
  final Value<int> nextDueAt;
  final Value<int> previousIntervalDays;
  final Value<int> nextIntervalDays;
  final Value<double> previousEase;
  final Value<double> nextEase;
  final Value<int> rowid;
  const ReviewEventsCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.grade = const Value.absent(),
    this.previousDueAt = const Value.absent(),
    this.nextDueAt = const Value.absent(),
    this.previousIntervalDays = const Value.absent(),
    this.nextIntervalDays = const Value.absent(),
    this.previousEase = const Value.absent(),
    this.nextEase = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewEventsCompanion.insert({
    required String id,
    required String cardId,
    required int reviewedAt,
    required String grade,
    required int previousDueAt,
    required int nextDueAt,
    required int previousIntervalDays,
    required int nextIntervalDays,
    required double previousEase,
    required double nextEase,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       reviewedAt = Value(reviewedAt),
       grade = Value(grade),
       previousDueAt = Value(previousDueAt),
       nextDueAt = Value(nextDueAt),
       previousIntervalDays = Value(previousIntervalDays),
       nextIntervalDays = Value(nextIntervalDays),
       previousEase = Value(previousEase),
       nextEase = Value(nextEase);
  static Insertable<ReviewEvent> custom({
    Expression<String>? id,
    Expression<String>? cardId,
    Expression<int>? reviewedAt,
    Expression<String>? grade,
    Expression<int>? previousDueAt,
    Expression<int>? nextDueAt,
    Expression<int>? previousIntervalDays,
    Expression<int>? nextIntervalDays,
    Expression<double>? previousEase,
    Expression<double>? nextEase,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (grade != null) 'grade': grade,
      if (previousDueAt != null) 'previous_due_at': previousDueAt,
      if (nextDueAt != null) 'next_due_at': nextDueAt,
      if (previousIntervalDays != null)
        'previous_interval_days': previousIntervalDays,
      if (nextIntervalDays != null) 'next_interval_days': nextIntervalDays,
      if (previousEase != null) 'previous_ease': previousEase,
      if (nextEase != null) 'next_ease': nextEase,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? cardId,
    Value<int>? reviewedAt,
    Value<String>? grade,
    Value<int>? previousDueAt,
    Value<int>? nextDueAt,
    Value<int>? previousIntervalDays,
    Value<int>? nextIntervalDays,
    Value<double>? previousEase,
    Value<double>? nextEase,
    Value<int>? rowid,
  }) {
    return ReviewEventsCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      grade: grade ?? this.grade,
      previousDueAt: previousDueAt ?? this.previousDueAt,
      nextDueAt: nextDueAt ?? this.nextDueAt,
      previousIntervalDays: previousIntervalDays ?? this.previousIntervalDays,
      nextIntervalDays: nextIntervalDays ?? this.nextIntervalDays,
      previousEase: previousEase ?? this.previousEase,
      nextEase: nextEase ?? this.nextEase,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<int>(reviewedAt.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (previousDueAt.present) {
      map['previous_due_at'] = Variable<int>(previousDueAt.value);
    }
    if (nextDueAt.present) {
      map['next_due_at'] = Variable<int>(nextDueAt.value);
    }
    if (previousIntervalDays.present) {
      map['previous_interval_days'] = Variable<int>(previousIntervalDays.value);
    }
    if (nextIntervalDays.present) {
      map['next_interval_days'] = Variable<int>(nextIntervalDays.value);
    }
    if (previousEase.present) {
      map['previous_ease'] = Variable<double>(previousEase.value);
    }
    if (nextEase.present) {
      map['next_ease'] = Variable<double>(nextEase.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewEventsCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('grade: $grade, ')
          ..write('previousDueAt: $previousDueAt, ')
          ..write('nextDueAt: $nextDueAt, ')
          ..write('previousIntervalDays: $previousIntervalDays, ')
          ..write('nextIntervalDays: $nextIntervalDays, ')
          ..write('previousEase: $previousEase, ')
          ..write('nextEase: $nextEase, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  final int updatedAt;
  const Setting({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  Setting copyWith({String? key, String? value, int? updatedAt}) => Setting(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecentGenerationCacheTable extends RecentGenerationCache
    with TableInfo<$RecentGenerationCacheTable, RecentGenerationCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentGenerationCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sceneLabelMeta = const VerificationMeta(
    'sceneLabel',
  );
  @override
  late final GeneratedColumn<String> sceneLabel = GeneratedColumn<String>(
    'scene_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryVocabMeta = const VerificationMeta(
    'primaryVocab',
  );
  @override
  late final GeneratedColumn<String> primaryVocab = GeneratedColumn<String>(
    'primary_vocab',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<int> expiresAt = GeneratedColumn<int>(
    'expires_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sceneLabel,
    primaryVocab,
    createdAt,
    expiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_generation_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecentGenerationCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('scene_label')) {
      context.handle(
        _sceneLabelMeta,
        sceneLabel.isAcceptableOrUnknown(data['scene_label']!, _sceneLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_sceneLabelMeta);
    }
    if (data.containsKey('primary_vocab')) {
      context.handle(
        _primaryVocabMeta,
        primaryVocab.isAcceptableOrUnknown(
          data['primary_vocab']!,
          _primaryVocabMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryVocabMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecentGenerationCacheData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentGenerationCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sceneLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scene_label'],
      )!,
      primaryVocab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_vocab'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expires_at'],
      )!,
    );
  }

  @override
  $RecentGenerationCacheTable createAlias(String alias) {
    return $RecentGenerationCacheTable(attachedDatabase, alias);
  }
}

class RecentGenerationCacheData extends DataClass
    implements Insertable<RecentGenerationCacheData> {
  final String id;
  final String sceneLabel;
  final String primaryVocab;
  final int createdAt;
  final int expiresAt;
  const RecentGenerationCacheData({
    required this.id,
    required this.sceneLabel,
    required this.primaryVocab,
    required this.createdAt,
    required this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['scene_label'] = Variable<String>(sceneLabel);
    map['primary_vocab'] = Variable<String>(primaryVocab);
    map['created_at'] = Variable<int>(createdAt);
    map['expires_at'] = Variable<int>(expiresAt);
    return map;
  }

  RecentGenerationCacheCompanion toCompanion(bool nullToAbsent) {
    return RecentGenerationCacheCompanion(
      id: Value(id),
      sceneLabel: Value(sceneLabel),
      primaryVocab: Value(primaryVocab),
      createdAt: Value(createdAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory RecentGenerationCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentGenerationCacheData(
      id: serializer.fromJson<String>(json['id']),
      sceneLabel: serializer.fromJson<String>(json['sceneLabel']),
      primaryVocab: serializer.fromJson<String>(json['primaryVocab']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      expiresAt: serializer.fromJson<int>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sceneLabel': serializer.toJson<String>(sceneLabel),
      'primaryVocab': serializer.toJson<String>(primaryVocab),
      'createdAt': serializer.toJson<int>(createdAt),
      'expiresAt': serializer.toJson<int>(expiresAt),
    };
  }

  RecentGenerationCacheData copyWith({
    String? id,
    String? sceneLabel,
    String? primaryVocab,
    int? createdAt,
    int? expiresAt,
  }) => RecentGenerationCacheData(
    id: id ?? this.id,
    sceneLabel: sceneLabel ?? this.sceneLabel,
    primaryVocab: primaryVocab ?? this.primaryVocab,
    createdAt: createdAt ?? this.createdAt,
    expiresAt: expiresAt ?? this.expiresAt,
  );
  RecentGenerationCacheData copyWithCompanion(
    RecentGenerationCacheCompanion data,
  ) {
    return RecentGenerationCacheData(
      id: data.id.present ? data.id.value : this.id,
      sceneLabel: data.sceneLabel.present
          ? data.sceneLabel.value
          : this.sceneLabel,
      primaryVocab: data.primaryVocab.present
          ? data.primaryVocab.value
          : this.primaryVocab,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentGenerationCacheData(')
          ..write('id: $id, ')
          ..write('sceneLabel: $sceneLabel, ')
          ..write('primaryVocab: $primaryVocab, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sceneLabel, primaryVocab, createdAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentGenerationCacheData &&
          other.id == this.id &&
          other.sceneLabel == this.sceneLabel &&
          other.primaryVocab == this.primaryVocab &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt);
}

class RecentGenerationCacheCompanion
    extends UpdateCompanion<RecentGenerationCacheData> {
  final Value<String> id;
  final Value<String> sceneLabel;
  final Value<String> primaryVocab;
  final Value<int> createdAt;
  final Value<int> expiresAt;
  final Value<int> rowid;
  const RecentGenerationCacheCompanion({
    this.id = const Value.absent(),
    this.sceneLabel = const Value.absent(),
    this.primaryVocab = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecentGenerationCacheCompanion.insert({
    required String id,
    required String sceneLabel,
    required String primaryVocab,
    required int createdAt,
    required int expiresAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sceneLabel = Value(sceneLabel),
       primaryVocab = Value(primaryVocab),
       createdAt = Value(createdAt),
       expiresAt = Value(expiresAt);
  static Insertable<RecentGenerationCacheData> custom({
    Expression<String>? id,
    Expression<String>? sceneLabel,
    Expression<String>? primaryVocab,
    Expression<int>? createdAt,
    Expression<int>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sceneLabel != null) 'scene_label': sceneLabel,
      if (primaryVocab != null) 'primary_vocab': primaryVocab,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecentGenerationCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? sceneLabel,
    Value<String>? primaryVocab,
    Value<int>? createdAt,
    Value<int>? expiresAt,
    Value<int>? rowid,
  }) {
    return RecentGenerationCacheCompanion(
      id: id ?? this.id,
      sceneLabel: sceneLabel ?? this.sceneLabel,
      primaryVocab: primaryVocab ?? this.primaryVocab,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sceneLabel.present) {
      map['scene_label'] = Variable<String>(sceneLabel.value);
    }
    if (primaryVocab.present) {
      map['primary_vocab'] = Variable<String>(primaryVocab.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<int>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentGenerationCacheCompanion(')
          ..write('id: $id, ')
          ..write('sceneLabel: $sceneLabel, ')
          ..write('primaryVocab: $primaryVocab, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LearningCardsTable learningCards = $LearningCardsTable(this);
  late final $VocabItemsTable vocabItems = $VocabItemsTable(this);
  late final $ReviewEventsTable reviewEvents = $ReviewEventsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $RecentGenerationCacheTable recentGenerationCache =
      $RecentGenerationCacheTable(this);
  late final Index learningCardsDueAtIdx = Index(
    'learning_cards_due_at_idx',
    'CREATE INDEX learning_cards_due_at_idx ON learning_cards (due_at)',
  );
  late final Index vocabItemsCardIdIdx = Index(
    'vocab_items_card_id_idx',
    'CREATE INDEX vocab_items_card_id_idx ON vocab_items (card_id)',
  );
  late final Index reviewEventsCardIdIdx = Index(
    'review_events_card_id_idx',
    'CREATE INDEX review_events_card_id_idx ON review_events (card_id)',
  );
  late final Index recentGenerationCachePrimaryVocabIdx = Index(
    'recent_generation_cache_primary_vocab_idx',
    'CREATE INDEX recent_generation_cache_primary_vocab_idx ON recent_generation_cache (primary_vocab)',
  );
  late final Index recentGenerationCacheExpiresAtIdx = Index(
    'recent_generation_cache_expires_at_idx',
    'CREATE INDEX recent_generation_cache_expires_at_idx ON recent_generation_cache (expires_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    learningCards,
    vocabItems,
    reviewEvents,
    settings,
    recentGenerationCache,
    learningCardsDueAtIdx,
    vocabItemsCardIdIdx,
    reviewEventsCardIdIdx,
    recentGenerationCachePrimaryVocabIdx,
    recentGenerationCacheExpiresAtIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learning_cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vocab_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learning_cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_events', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$LearningCardsTableCreateCompanionBuilder =
    LearningCardsCompanion Function({
      required String id,
      required String sceneLabel,
      required String english,
      required String targetText,
      required String pronunciation,
      required String grammarNote,
      required String targetLanguage,
      required String targetLevel,
      required String source,
      required int createdAt,
      required int dueAt,
      required int intervalDays,
      required double ease,
      required int repetitions,
      required int lapses,
      Value<bool> suspended,
      Value<int> rowid,
    });
typedef $$LearningCardsTableUpdateCompanionBuilder =
    LearningCardsCompanion Function({
      Value<String> id,
      Value<String> sceneLabel,
      Value<String> english,
      Value<String> targetText,
      Value<String> pronunciation,
      Value<String> grammarNote,
      Value<String> targetLanguage,
      Value<String> targetLevel,
      Value<String> source,
      Value<int> createdAt,
      Value<int> dueAt,
      Value<int> intervalDays,
      Value<double> ease,
      Value<int> repetitions,
      Value<int> lapses,
      Value<bool> suspended,
      Value<int> rowid,
    });

final class $$LearningCardsTableReferences
    extends BaseReferences<_$AppDatabase, $LearningCardsTable, LearningCard> {
  $$LearningCardsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$VocabItemsTable, List<StoredVocabItem>>
  _vocabItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabItems,
    aliasName: $_aliasNameGenerator(db.learningCards.id, db.vocabItems.cardId),
  );

  $$VocabItemsTableProcessedTableManager get vocabItemsRefs {
    final manager = $$VocabItemsTableTableManager(
      $_db,
      $_db.vocabItems,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vocabItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewEventsTable, List<ReviewEvent>>
  _reviewEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewEvents,
    aliasName: $_aliasNameGenerator(
      db.learningCards.id,
      db.reviewEvents.cardId,
    ),
  );

  $$ReviewEventsTableProcessedTableManager get reviewEventsRefs {
    final manager = $$ReviewEventsTableTableManager(
      $_db,
      $_db.reviewEvents,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LearningCardsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningCardsTable> {
  $$LearningCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sceneLabel => $composableBuilder(
    column: $table.sceneLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get english => $composableBuilder(
    column: $table.english,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetLanguage => $composableBuilder(
    column: $table.targetLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetLevel => $composableBuilder(
    column: $table.targetLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ease => $composableBuilder(
    column: $table.ease,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get suspended => $composableBuilder(
    column: $table.suspended,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vocabItemsRefs(
    Expression<bool> Function($$VocabItemsTableFilterComposer f) f,
  ) {
    final $$VocabItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabItems,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabItemsTableFilterComposer(
            $db: $db,
            $table: $db.vocabItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewEventsRefs(
    Expression<bool> Function($$ReviewEventsTableFilterComposer f) f,
  ) {
    final $$ReviewEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableFilterComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearningCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningCardsTable> {
  $$LearningCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sceneLabel => $composableBuilder(
    column: $table.sceneLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get english => $composableBuilder(
    column: $table.english,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetLanguage => $composableBuilder(
    column: $table.targetLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetLevel => $composableBuilder(
    column: $table.targetLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ease => $composableBuilder(
    column: $table.ease,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get suspended => $composableBuilder(
    column: $table.suspended,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningCardsTable> {
  $$LearningCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sceneLabel => $composableBuilder(
    column: $table.sceneLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get english =>
      $composableBuilder(column: $table.english, builder: (column) => column);

  GeneratedColumn<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grammarNote => $composableBuilder(
    column: $table.grammarNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetLanguage => $composableBuilder(
    column: $table.targetLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetLevel => $composableBuilder(
    column: $table.targetLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ease =>
      $composableBuilder(column: $table.ease, builder: (column) => column);

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  GeneratedColumn<bool> get suspended =>
      $composableBuilder(column: $table.suspended, builder: (column) => column);

  Expression<T> vocabItemsRefs<T extends Object>(
    Expression<T> Function($$VocabItemsTableAnnotationComposer a) f,
  ) {
    final $$VocabItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabItems,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewEventsRefs<T extends Object>(
    Expression<T> Function($$ReviewEventsTableAnnotationComposer a) f,
  ) {
    final $$ReviewEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewEvents,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearningCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningCardsTable,
          LearningCard,
          $$LearningCardsTableFilterComposer,
          $$LearningCardsTableOrderingComposer,
          $$LearningCardsTableAnnotationComposer,
          $$LearningCardsTableCreateCompanionBuilder,
          $$LearningCardsTableUpdateCompanionBuilder,
          (LearningCard, $$LearningCardsTableReferences),
          LearningCard,
          PrefetchHooks Function({bool vocabItemsRefs, bool reviewEventsRefs})
        > {
  $$LearningCardsTableTableManager(_$AppDatabase db, $LearningCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sceneLabel = const Value.absent(),
                Value<String> english = const Value.absent(),
                Value<String> targetText = const Value.absent(),
                Value<String> pronunciation = const Value.absent(),
                Value<String> grammarNote = const Value.absent(),
                Value<String> targetLanguage = const Value.absent(),
                Value<String> targetLevel = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> dueAt = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<double> ease = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<bool> suspended = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningCardsCompanion(
                id: id,
                sceneLabel: sceneLabel,
                english: english,
                targetText: targetText,
                pronunciation: pronunciation,
                grammarNote: grammarNote,
                targetLanguage: targetLanguage,
                targetLevel: targetLevel,
                source: source,
                createdAt: createdAt,
                dueAt: dueAt,
                intervalDays: intervalDays,
                ease: ease,
                repetitions: repetitions,
                lapses: lapses,
                suspended: suspended,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sceneLabel,
                required String english,
                required String targetText,
                required String pronunciation,
                required String grammarNote,
                required String targetLanguage,
                required String targetLevel,
                required String source,
                required int createdAt,
                required int dueAt,
                required int intervalDays,
                required double ease,
                required int repetitions,
                required int lapses,
                Value<bool> suspended = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningCardsCompanion.insert(
                id: id,
                sceneLabel: sceneLabel,
                english: english,
                targetText: targetText,
                pronunciation: pronunciation,
                grammarNote: grammarNote,
                targetLanguage: targetLanguage,
                targetLevel: targetLevel,
                source: source,
                createdAt: createdAt,
                dueAt: dueAt,
                intervalDays: intervalDays,
                ease: ease,
                repetitions: repetitions,
                lapses: lapses,
                suspended: suspended,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LearningCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vocabItemsRefs = false, reviewEventsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vocabItemsRefs) db.vocabItems,
                    if (reviewEventsRefs) db.reviewEvents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vocabItemsRefs)
                        await $_getPrefetchedData<
                          LearningCard,
                          $LearningCardsTable,
                          StoredVocabItem
                        >(
                          currentTable: table,
                          referencedTable: $$LearningCardsTableReferences
                              ._vocabItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LearningCardsTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reviewEventsRefs)
                        await $_getPrefetchedData<
                          LearningCard,
                          $LearningCardsTable,
                          ReviewEvent
                        >(
                          currentTable: table,
                          referencedTable: $$LearningCardsTableReferences
                              ._reviewEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LearningCardsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LearningCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningCardsTable,
      LearningCard,
      $$LearningCardsTableFilterComposer,
      $$LearningCardsTableOrderingComposer,
      $$LearningCardsTableAnnotationComposer,
      $$LearningCardsTableCreateCompanionBuilder,
      $$LearningCardsTableUpdateCompanionBuilder,
      (LearningCard, $$LearningCardsTableReferences),
      LearningCard,
      PrefetchHooks Function({bool vocabItemsRefs, bool reviewEventsRefs})
    >;
typedef $$VocabItemsTableCreateCompanionBuilder =
    VocabItemsCompanion Function({
      required String id,
      required String cardId,
      required String targetText,
      required String pronunciation,
      required String meaning,
      required String approxLevel,
      Value<int> rowid,
    });
typedef $$VocabItemsTableUpdateCompanionBuilder =
    VocabItemsCompanion Function({
      Value<String> id,
      Value<String> cardId,
      Value<String> targetText,
      Value<String> pronunciation,
      Value<String> meaning,
      Value<String> approxLevel,
      Value<int> rowid,
    });

final class $$VocabItemsTableReferences
    extends BaseReferences<_$AppDatabase, $VocabItemsTable, StoredVocabItem> {
  $$VocabItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LearningCardsTable _cardIdTable(_$AppDatabase db) =>
      db.learningCards.createAlias(
        $_aliasNameGenerator(db.vocabItems.cardId, db.learningCards.id),
      );

  $$LearningCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$LearningCardsTableTableManager(
      $_db,
      $_db.learningCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VocabItemsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabItemsTable> {
  $$VocabItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get approxLevel => $composableBuilder(
    column: $table.approxLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$LearningCardsTableFilterComposer get cardId {
    final $$LearningCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.learningCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningCardsTableFilterComposer(
            $db: $db,
            $table: $db.learningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabItemsTable> {
  $$VocabItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get approxLevel => $composableBuilder(
    column: $table.approxLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$LearningCardsTableOrderingComposer get cardId {
    final $$LearningCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.learningCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningCardsTableOrderingComposer(
            $db: $db,
            $table: $db.learningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabItemsTable> {
  $$VocabItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetText => $composableBuilder(
    column: $table.targetText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get approxLevel => $composableBuilder(
    column: $table.approxLevel,
    builder: (column) => column,
  );

  $$LearningCardsTableAnnotationComposer get cardId {
    final $$LearningCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.learningCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.learningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabItemsTable,
          StoredVocabItem,
          $$VocabItemsTableFilterComposer,
          $$VocabItemsTableOrderingComposer,
          $$VocabItemsTableAnnotationComposer,
          $$VocabItemsTableCreateCompanionBuilder,
          $$VocabItemsTableUpdateCompanionBuilder,
          (StoredVocabItem, $$VocabItemsTableReferences),
          StoredVocabItem,
          PrefetchHooks Function({bool cardId})
        > {
  $$VocabItemsTableTableManager(_$AppDatabase db, $VocabItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> targetText = const Value.absent(),
                Value<String> pronunciation = const Value.absent(),
                Value<String> meaning = const Value.absent(),
                Value<String> approxLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabItemsCompanion(
                id: id,
                cardId: cardId,
                targetText: targetText,
                pronunciation: pronunciation,
                meaning: meaning,
                approxLevel: approxLevel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cardId,
                required String targetText,
                required String pronunciation,
                required String meaning,
                required String approxLevel,
                Value<int> rowid = const Value.absent(),
              }) => VocabItemsCompanion.insert(
                id: id,
                cardId: cardId,
                targetText: targetText,
                pronunciation: pronunciation,
                meaning: meaning,
                approxLevel: approxLevel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VocabItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable: $$VocabItemsTableReferences
                                    ._cardIdTable(db),
                                referencedColumn: $$VocabItemsTableReferences
                                    ._cardIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VocabItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabItemsTable,
      StoredVocabItem,
      $$VocabItemsTableFilterComposer,
      $$VocabItemsTableOrderingComposer,
      $$VocabItemsTableAnnotationComposer,
      $$VocabItemsTableCreateCompanionBuilder,
      $$VocabItemsTableUpdateCompanionBuilder,
      (StoredVocabItem, $$VocabItemsTableReferences),
      StoredVocabItem,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$ReviewEventsTableCreateCompanionBuilder =
    ReviewEventsCompanion Function({
      required String id,
      required String cardId,
      required int reviewedAt,
      required String grade,
      required int previousDueAt,
      required int nextDueAt,
      required int previousIntervalDays,
      required int nextIntervalDays,
      required double previousEase,
      required double nextEase,
      Value<int> rowid,
    });
typedef $$ReviewEventsTableUpdateCompanionBuilder =
    ReviewEventsCompanion Function({
      Value<String> id,
      Value<String> cardId,
      Value<int> reviewedAt,
      Value<String> grade,
      Value<int> previousDueAt,
      Value<int> nextDueAt,
      Value<int> previousIntervalDays,
      Value<int> nextIntervalDays,
      Value<double> previousEase,
      Value<double> nextEase,
      Value<int> rowid,
    });

final class $$ReviewEventsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewEventsTable, ReviewEvent> {
  $$ReviewEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LearningCardsTable _cardIdTable(_$AppDatabase db) =>
      db.learningCards.createAlias(
        $_aliasNameGenerator(db.reviewEvents.cardId, db.learningCards.id),
      );

  $$LearningCardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$LearningCardsTableTableManager(
      $_db,
      $_db.learningCards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousDueAt => $composableBuilder(
    column: $table.previousDueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextDueAt => $composableBuilder(
    column: $table.nextDueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousIntervalDays => $composableBuilder(
    column: $table.previousIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextIntervalDays => $composableBuilder(
    column: $table.nextIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousEase => $composableBuilder(
    column: $table.previousEase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get nextEase => $composableBuilder(
    column: $table.nextEase,
    builder: (column) => ColumnFilters(column),
  );

  $$LearningCardsTableFilterComposer get cardId {
    final $$LearningCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.learningCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningCardsTableFilterComposer(
            $db: $db,
            $table: $db.learningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousDueAt => $composableBuilder(
    column: $table.previousDueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextDueAt => $composableBuilder(
    column: $table.nextDueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousIntervalDays => $composableBuilder(
    column: $table.previousIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextIntervalDays => $composableBuilder(
    column: $table.nextIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousEase => $composableBuilder(
    column: $table.previousEase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get nextEase => $composableBuilder(
    column: $table.nextEase,
    builder: (column) => ColumnOrderings(column),
  );

  $$LearningCardsTableOrderingComposer get cardId {
    final $$LearningCardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.learningCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningCardsTableOrderingComposer(
            $db: $db,
            $table: $db.learningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<int> get previousDueAt => $composableBuilder(
    column: $table.previousDueAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextDueAt =>
      $composableBuilder(column: $table.nextDueAt, builder: (column) => column);

  GeneratedColumn<int> get previousIntervalDays => $composableBuilder(
    column: $table.previousIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextIntervalDays => $composableBuilder(
    column: $table.nextIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get previousEase => $composableBuilder(
    column: $table.previousEase,
    builder: (column) => column,
  );

  GeneratedColumn<double> get nextEase =>
      $composableBuilder(column: $table.nextEase, builder: (column) => column);

  $$LearningCardsTableAnnotationComposer get cardId {
    final $$LearningCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.learningCards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.learningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewEventsTable,
          ReviewEvent,
          $$ReviewEventsTableFilterComposer,
          $$ReviewEventsTableOrderingComposer,
          $$ReviewEventsTableAnnotationComposer,
          $$ReviewEventsTableCreateCompanionBuilder,
          $$ReviewEventsTableUpdateCompanionBuilder,
          (ReviewEvent, $$ReviewEventsTableReferences),
          ReviewEvent,
          PrefetchHooks Function({bool cardId})
        > {
  $$ReviewEventsTableTableManager(_$AppDatabase db, $ReviewEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> reviewedAt = const Value.absent(),
                Value<String> grade = const Value.absent(),
                Value<int> previousDueAt = const Value.absent(),
                Value<int> nextDueAt = const Value.absent(),
                Value<int> previousIntervalDays = const Value.absent(),
                Value<int> nextIntervalDays = const Value.absent(),
                Value<double> previousEase = const Value.absent(),
                Value<double> nextEase = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewEventsCompanion(
                id: id,
                cardId: cardId,
                reviewedAt: reviewedAt,
                grade: grade,
                previousDueAt: previousDueAt,
                nextDueAt: nextDueAt,
                previousIntervalDays: previousIntervalDays,
                nextIntervalDays: nextIntervalDays,
                previousEase: previousEase,
                nextEase: nextEase,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cardId,
                required int reviewedAt,
                required String grade,
                required int previousDueAt,
                required int nextDueAt,
                required int previousIntervalDays,
                required int nextIntervalDays,
                required double previousEase,
                required double nextEase,
                Value<int> rowid = const Value.absent(),
              }) => ReviewEventsCompanion.insert(
                id: id,
                cardId: cardId,
                reviewedAt: reviewedAt,
                grade: grade,
                previousDueAt: previousDueAt,
                nextDueAt: nextDueAt,
                previousIntervalDays: previousIntervalDays,
                nextIntervalDays: nextIntervalDays,
                previousEase: previousEase,
                nextEase: nextEase,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReviewEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable: $$ReviewEventsTableReferences
                                    ._cardIdTable(db),
                                referencedColumn: $$ReviewEventsTableReferences
                                    ._cardIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewEventsTable,
      ReviewEvent,
      $$ReviewEventsTableFilterComposer,
      $$ReviewEventsTableOrderingComposer,
      $$ReviewEventsTableAnnotationComposer,
      $$ReviewEventsTableCreateCompanionBuilder,
      $$ReviewEventsTableUpdateCompanionBuilder,
      (ReviewEvent, $$ReviewEventsTableReferences),
      ReviewEvent,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> updatedAt,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$RecentGenerationCacheTableCreateCompanionBuilder =
    RecentGenerationCacheCompanion Function({
      required String id,
      required String sceneLabel,
      required String primaryVocab,
      required int createdAt,
      required int expiresAt,
      Value<int> rowid,
    });
typedef $$RecentGenerationCacheTableUpdateCompanionBuilder =
    RecentGenerationCacheCompanion Function({
      Value<String> id,
      Value<String> sceneLabel,
      Value<String> primaryVocab,
      Value<int> createdAt,
      Value<int> expiresAt,
      Value<int> rowid,
    });

class $$RecentGenerationCacheTableFilterComposer
    extends Composer<_$AppDatabase, $RecentGenerationCacheTable> {
  $$RecentGenerationCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sceneLabel => $composableBuilder(
    column: $table.sceneLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryVocab => $composableBuilder(
    column: $table.primaryVocab,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecentGenerationCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentGenerationCacheTable> {
  $$RecentGenerationCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sceneLabel => $composableBuilder(
    column: $table.sceneLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryVocab => $composableBuilder(
    column: $table.primaryVocab,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecentGenerationCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentGenerationCacheTable> {
  $$RecentGenerationCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sceneLabel => $composableBuilder(
    column: $table.sceneLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryVocab => $composableBuilder(
    column: $table.primaryVocab,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$RecentGenerationCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecentGenerationCacheTable,
          RecentGenerationCacheData,
          $$RecentGenerationCacheTableFilterComposer,
          $$RecentGenerationCacheTableOrderingComposer,
          $$RecentGenerationCacheTableAnnotationComposer,
          $$RecentGenerationCacheTableCreateCompanionBuilder,
          $$RecentGenerationCacheTableUpdateCompanionBuilder,
          (
            RecentGenerationCacheData,
            BaseReferences<
              _$AppDatabase,
              $RecentGenerationCacheTable,
              RecentGenerationCacheData
            >,
          ),
          RecentGenerationCacheData,
          PrefetchHooks Function()
        > {
  $$RecentGenerationCacheTableTableManager(
    _$AppDatabase db,
    $RecentGenerationCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentGenerationCacheTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RecentGenerationCacheTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecentGenerationCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sceneLabel = const Value.absent(),
                Value<String> primaryVocab = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> expiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecentGenerationCacheCompanion(
                id: id,
                sceneLabel: sceneLabel,
                primaryVocab: primaryVocab,
                createdAt: createdAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sceneLabel,
                required String primaryVocab,
                required int createdAt,
                required int expiresAt,
                Value<int> rowid = const Value.absent(),
              }) => RecentGenerationCacheCompanion.insert(
                id: id,
                sceneLabel: sceneLabel,
                primaryVocab: primaryVocab,
                createdAt: createdAt,
                expiresAt: expiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecentGenerationCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecentGenerationCacheTable,
      RecentGenerationCacheData,
      $$RecentGenerationCacheTableFilterComposer,
      $$RecentGenerationCacheTableOrderingComposer,
      $$RecentGenerationCacheTableAnnotationComposer,
      $$RecentGenerationCacheTableCreateCompanionBuilder,
      $$RecentGenerationCacheTableUpdateCompanionBuilder,
      (
        RecentGenerationCacheData,
        BaseReferences<
          _$AppDatabase,
          $RecentGenerationCacheTable,
          RecentGenerationCacheData
        >,
      ),
      RecentGenerationCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LearningCardsTableTableManager get learningCards =>
      $$LearningCardsTableTableManager(_db, _db.learningCards);
  $$VocabItemsTableTableManager get vocabItems =>
      $$VocabItemsTableTableManager(_db, _db.vocabItems);
  $$ReviewEventsTableTableManager get reviewEvents =>
      $$ReviewEventsTableTableManager(_db, _db.reviewEvents);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$RecentGenerationCacheTableTableManager get recentGenerationCache =>
      $$RecentGenerationCacheTableTableManager(_db, _db.recentGenerationCache);
}
