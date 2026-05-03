import '../../shared/target_language.dart';

abstract interface class SpeechService {
  Future<void> speakText(String text, {required TargetLanguage language});

  Future<void> stop();
}
