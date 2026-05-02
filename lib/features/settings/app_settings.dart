import '../../shared/jlpt_level.dart';

class AppSettings {
  const AppSettings({
    required this.level,
    required this.captureInterval,
    required this.ttsMuted,
  });

  static const minCaptureInterval = Duration(seconds: 5);
  static const defaultCaptureInterval = Duration(seconds: 10);

  factory AppSettings.defaults() {
    return const AppSettings(
      level: JlptLevel.n5,
      captureInterval: defaultCaptureInterval,
      ttsMuted: false,
    );
  }

  final JlptLevel level;
  final Duration captureInterval;
  final bool ttsMuted;

  AppSettings copyWith({
    JlptLevel? level,
    Duration? captureInterval,
    bool? ttsMuted,
  }) {
    return AppSettings(
      level: level ?? this.level,
      captureInterval: _clampInterval(captureInterval ?? this.captureInterval),
      ttsMuted: ttsMuted ?? this.ttsMuted,
    );
  }

  static Duration _clampInterval(Duration value) {
    if (value < minCaptureInterval) {
      return minCaptureInterval;
    }
    return value;
  }
}
