import '../../data/database/app_database.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import 'app_settings.dart';
import 'settings_repository.dart';

class DriftSettingsRepository implements SettingsRepository {
  DriftSettingsRepository(this._database);

  static const _languageKey = 'target_language';
  static const _levelKey = 'target_level';
  static const _intervalSecondsKey = 'capture_interval_seconds';
  static const _ttsMutedKey = 'tts_muted';

  final AppDatabase _database;

  @override
  Future<AppSettings> load() async {
    final rows = await _database.select(_database.settings).get();
    final map = {for (final row in rows) row.key: row.value};
    final seconds =
        int.tryParse(map[_intervalSecondsKey] ?? '') ??
        AppSettings.defaultCaptureInterval.inSeconds;

    return AppSettings(
      language: TargetLanguage.fromCode(
        map[_languageKey] ?? TargetLanguage.japanese.code,
      ),
      level: ProficiencyLevel.fromLabel(
        map[_levelKey] ?? ProficiencyLevel.beginner.label,
      ),
      captureInterval: Duration(seconds: seconds),
      ttsMuted: map[_ttsMutedKey] == 'true',
    );
  }

  @override
  Future<void> save(AppSettings settings) {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    return _database.transaction(() async {
      await _upsert(_languageKey, settings.language.code, now);
      await _upsert(_levelKey, settings.level.label, now);
      await _upsert(
        _intervalSecondsKey,
        settings.captureInterval.inSeconds.toString(),
        now,
      );
      await _upsert(_ttsMutedKey, settings.ttsMuted.toString(), now);
    });
  }

  Future<void> _upsert(String key, String value, int updatedAt) async {
    await _database
        .into(_database.settings)
        .insertOnConflictUpdate(
          SettingsCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
          ),
        );
  }
}
