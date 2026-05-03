import '../../shared/proficiency_level.dart';
import '../../shared/target_language.dart';

class AppSettings {
  const AppSettings({
    required this.language,
    required this.level,
    required this.captureInterval,
    required this.ttsMuted,
  });

  static const minCaptureInterval = Duration(seconds: 5);
  static const defaultCaptureInterval = Duration(seconds: 10);

  factory AppSettings.defaults() {
    return const AppSettings(
      language: TargetLanguage.japanese,
      level: ProficiencyLevel.beginner,
      captureInterval: defaultCaptureInterval,
      ttsMuted: false,
    );
  }

  final TargetLanguage language;
  final ProficiencyLevel level;
  final Duration captureInterval;
  final bool ttsMuted;

  AppSettings copyWith({
    TargetLanguage? language,
    ProficiencyLevel? level,
    Duration? captureInterval,
    bool? ttsMuted,
  }) {
    return AppSettings(
      language: language ?? this.language,
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
