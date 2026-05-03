import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';

part 'app_database.g.dart';

@TableIndex(name: 'learning_cards_due_at_idx', columns: {#dueAt})
class LearningCards extends Table {
  TextColumn get id => text()();
  TextColumn get sceneLabel => text()();
  TextColumn get english => text()();
  TextColumn get targetText => text()();
  TextColumn get pronunciation => text()();
  TextColumn get grammarNote => text()();
  TextColumn get targetLanguage => text()();
  TextColumn get targetLevel => text()();
  TextColumn get source => text()();
  IntColumn get createdAt => integer()();
  IntColumn get dueAt => integer()();
  IntColumn get intervalDays => integer()();
  RealColumn get ease => real()();
  IntColumn get repetitions => integer()();
  IntColumn get lapses => integer()();
  BoolColumn get suspended => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'vocab_items_card_id_idx', columns: {#cardId})
@DataClassName('StoredVocabItem')
class VocabItems extends Table {
  TextColumn get id => text()();
  TextColumn get cardId =>
      text().references(LearningCards, #id, onDelete: KeyAction.cascade)();
  TextColumn get targetText => text()();
  TextColumn get pronunciation => text()();
  TextColumn get meaning => text()();
  TextColumn get approxLevel => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@TableIndex(name: 'review_events_card_id_idx', columns: {#cardId})
class ReviewEvents extends Table {
  TextColumn get id => text()();
  TextColumn get cardId =>
      text().references(LearningCards, #id, onDelete: KeyAction.cascade)();
  IntColumn get reviewedAt => integer()();
  TextColumn get grade => text()();
  IntColumn get previousDueAt => integer()();
  IntColumn get nextDueAt => integer()();
  IntColumn get previousIntervalDays => integer()();
  IntColumn get nextIntervalDays => integer()();
  RealColumn get previousEase => real()();
  RealColumn get nextEase => real()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@TableIndex(
  name: 'recent_generation_cache_primary_vocab_idx',
  columns: {#primaryVocab},
)
@TableIndex(
  name: 'recent_generation_cache_expires_at_idx',
  columns: {#expiresAt},
)
class RecentGenerationCache extends Table {
  TextColumn get id => text()();
  TextColumn get sceneLabel => text()();
  TextColumn get primaryVocab => text()();
  IntColumn get createdAt => integer()();
  IntColumn get expiresAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    LearningCards,
    VocabItems,
    ReviewEvents,
    Settings,
    RecentGenerationCache,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await customStatement(
          'ALTER TABLE learning_cards RENAME COLUMN japanese TO target_text',
        );
        await customStatement(
          'ALTER TABLE learning_cards RENAME COLUMN reading TO pronunciation',
        );
        await customStatement(
          "ALTER TABLE learning_cards ADD COLUMN target_language TEXT NOT NULL DEFAULT '${TargetLanguage.japanese.code}'",
        );
        await customStatement(
          _legacyLevelMigrationSql(
            table: 'learning_cards',
            column: 'target_level',
          ),
        );

        await customStatement(
          'ALTER TABLE vocab_items RENAME COLUMN japanese TO target_text',
        );
        await customStatement(
          'ALTER TABLE vocab_items RENAME COLUMN reading TO pronunciation',
        );
        await customStatement(
          'ALTER TABLE vocab_items RENAME COLUMN approx_jlpt TO approx_level',
        );
        await customStatement(
          _legacyLevelMigrationSql(
            table: 'vocab_items',
            column: 'approx_level',
          ),
        );
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'language_tutor.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

String _legacyLevelMigrationSql({
  required String table,
  required String column,
}) {
  return '''
UPDATE $table
SET $column = CASE $column
  WHEN 'N5' THEN '${ProficiencyLevel.beginner.label}'
  WHEN 'N4' THEN '${ProficiencyLevel.elementary.label}'
  WHEN 'N3' THEN '${ProficiencyLevel.intermediate.label}'
  WHEN 'N2' THEN '${ProficiencyLevel.upperIntermediate.label}'
  WHEN 'N1' THEN '${ProficiencyLevel.advanced.label}'
  ELSE $column
END
''';
}
