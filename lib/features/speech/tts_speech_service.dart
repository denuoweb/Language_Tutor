import 'package:flutter_tts/flutter_tts.dart';

import 'speech_service.dart';

class TtsSpeechService implements SpeechService {
  TtsSpeechService({FlutterTts? tts}) : _tts = tts ?? FlutterTts();

  final FlutterTts _tts;
  bool _configured = false;

  @override
  Future<void> speakJapanese(String text) async {
    await _configure();
    await _tts.stop();
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }

  Future<void> _configure() async {
    if (_configured) {
      return;
    }
    await _tts.setLanguage('ja-JP');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1);
    _configured = true;
  }
}
