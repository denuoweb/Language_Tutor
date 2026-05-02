import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@TableIndex(name: 'learning_cards_due_at_idx', columns: {#dueAt})
class LearningCards extends Table {
  TextColumn get id => text()();
  TextColumn get sceneLabel => text()();
  TextColumn get english => text()();
  TextColumn get japanese => text()();
  TextColumn get reading => text()();
  TextColumn get grammarNote => text()();
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
  TextColumn get japanese => text()();
  TextColumn get reading => text()();
  TextColumn get meaning => text()();
  TextColumn get approxJlpt => text()();

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
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'language_tutor.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
