import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../features/capture/frame_source.dart';
import '../features/capture/phone_camera_frame_source.dart';
import '../features/capture/ray_ban_native_bridge.dart';
import '../features/capture/ray_ban_frame_source.dart';
import '../features/gemini/demo_tutor_generation_service.dart';
import '../features/gemini/firebase_bootstrap.dart';
import '../features/gemini/firebase_tutor_generation_service.dart';
import '../features/gemini/tutor_generation_service.dart';
import '../features/settings/drift_settings_repository.dart';
import '../features/settings/settings_repository.dart';
import '../features/speech/speech_service.dart';
import '../features/speech/tts_speech_service.dart';
import '../features/srs/drift_srs_repository.dart';
import '../features/srs/srs_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

class SelectedCaptureSourceNotifier extends Notifier<CaptureSource> {
  @override
  CaptureSource build() => CaptureSource.phoneCamera;

  void setSource(CaptureSource source) {
    state = source;
  }
}

final selectedCaptureSourceProvider =
    NotifierProvider<SelectedCaptureSourceNotifier, CaptureSource>(
      SelectedCaptureSourceNotifier.new,
    );

final phoneCameraFrameSourceProvider = Provider<PhoneCameraFrameSource>((ref) {
  final source = PhoneCameraFrameSource();
  ref.onDispose(source.dispose);
  return source;
});

final rayBanFrameSourceProvider = Provider<RayBanFrameSource>((ref) {
  final source = RayBanFrameSource(bridge: ref.watch(rayBanNativeBridgeProvider));
  ref.onDispose(source.dispose);
  return source;
});

final rayBanNativeBridgeProvider = Provider<RayBanNativeBridge>((ref) {
  return RayBanNativeBridge();
});

final frameSourceProvider = Provider<FrameSource>((ref) {
  return switch (ref.watch(selectedCaptureSourceProvider)) {
    CaptureSource.phoneCamera => ref.watch(phoneCameraFrameSourceProvider),
    CaptureSource.rayBan => ref.watch(rayBanFrameSourceProvider),
  };
});

final tutorGenerationServiceProvider = Provider<TutorGenerationService>((ref) {
  if (FirebaseBootstrap.liveGeminiEnabled) {
    return FirebaseTutorGenerationService();
  }
  return const DemoTutorGenerationService();
});

final speechServiceProvider = Provider<SpeechService>((ref) {
  return TtsSpeechService();
});

final srsRepositoryProvider = Provider<SrsRepository>((ref) {
  return DriftSrsRepository(ref.watch(appDatabaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return DriftSettingsRepository(ref.watch(appDatabaseProvider));
});
