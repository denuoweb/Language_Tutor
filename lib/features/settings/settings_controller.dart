import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../shared/jlpt_level.dart';
import 'app_settings.dart';

class SettingsController extends AsyncNotifier<AppSettings> {
  @override
  Future<AppSettings> build() {
    return ref.watch(settingsRepositoryProvider).load();
  }

  Future<void> setLevel(JlptLevel level) async {
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
