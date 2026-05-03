import 'package:flutter_tts/flutter_tts.dart';

import '../../shared/target_language.dart';
import 'speech_service.dart';

class TtsSpeechService implements SpeechService {
  TtsSpeechService({FlutterTts? tts}) : _tts = tts ?? FlutterTts();

  final FlutterTts _tts;
  String? _configuredLocale;

  @override
  Future<void> speakText(
    String text, {
    required TargetLanguage language,
  }) async {
    await _configure(language);
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }

  Future<void> _configure(TargetLanguage language) async {
    if (_configuredLocale == language.ttsLocale) {
      return;
    }
    await _tts.setLanguage(language.ttsLocale);
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1);
    _configuredLocale = language.ttsLocale;
  }
}
