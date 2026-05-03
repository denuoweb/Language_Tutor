import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';
import 'app_settings.dart';

class SettingsController extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() {
    return ref.watch(settingsRepositoryProvider).load();
  }

  Future<void> setLanguage(TargetLanguage language) async {
    await _update((settings) => settings.copyWith(language: language));
  }

  Future<void> setLevel(ProficiencyLevel level) async {
    await _update((settings) => settings.copyWith(level: level));
  }

  Future<void> setCaptureInterval(Duration interval) async {
    await _update((settings) => settings.copyWith(captureInterval: interval));
  }

  Future<void> setTtsMuted(bool muted) async {
    await _update((settings) => settings.copyWith(ttsMuted: muted));
  }

  Future<void> _update(AppSettings Function(AppSettings) update) async {
    final current = state.asData?.value ?? AppSettings.defaults();
    final next = update(current);
    state = AsyncData(next);
    await ref.read(settingsRepositoryProvider).save(next);
  }
}

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, AppSettings>(
      SettingsController.new,
    );
