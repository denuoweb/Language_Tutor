import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:language_tutor/data/database/app_database.dart';
import 'package:language_tutor/features/settings/app_settings.dart';
import 'package:language_tutor/features/settings/drift_settings_repository.dart';
import 'package:language_tutor/shared/proficiency_level.dart';
import 'package:language_tutor/shared/target_language.dart';

void main() {
  late AppDatabase database;
  late DriftSettingsRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftSettingsRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('loads legacy N-level settings as general proficiency levels', () async {
    final now = DateTime.utc(2026, 1, 1).millisecondsSinceEpoch;

    await database
        .into(database.settings)
        .insert(
          SettingsCompanion.insert(
            key: 'target_level',
            value: 'N3',
            updatedAt: now,
          ),
        );
    await database
        .into(database.settings)
        .insert(
          SettingsCompanion.insert(
            key: 'capture_interval_seconds',
            value: '15',
            updatedAt: now,
          ),
        );
    await database
        .into(database.settings)
        .insert(
          SettingsCompanion.insert(
            key: 'tts_muted',
            value: 'true',
            updatedAt: now,
          ),
        );

    final settings = await repository.load();

    expect(settings.language, TargetLanguage.japanese);
    expect(settings.level, ProficiencyLevel.intermediate);
    expect(settings.captureInterval, const Duration(seconds: 15));
    expect(settings.ttsMuted, isTrue);
  });

  test('persists and reloads language-aware settings', () async {
    const settings = AppSettings(
      language: TargetLanguage.arabic,
      level: ProficiencyLevel.upperIntermediate,
      captureInterval: Duration(seconds: 20),
      ttsMuted: false,
    );

    await repository.save(settings);
    final loaded = await repository.load();

    expect(loaded.language, TargetLanguage.arabic);
    expect(loaded.level, ProficiencyLevel.upperIntermediate);
    expect(loaded.captureInterval, const Duration(seconds: 20));
    expect(loaded.ttsMuted, isFalse);
  });
}
