abstract interface class SpeechService {
  Future<void> speakJapanese(String text);

  Future<void> stop();
}
