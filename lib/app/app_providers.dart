import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../features/capture/frame_source.dart';
import '../features/capture/phone_camera_frame_source.dart';
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

final frameSourceProvider = Provider<FrameSource>((ref) {
  final source = PhoneCameraFrameSource();
  ref.onDispose(source.dispose);
  return source;
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
