import 'review_grade.dart';

class SrsScheduleInput {
  const SrsScheduleInput({
    required this.dueAt,
    required this.intervalDays,
    required this.ease,
    required this.repetitions,
    required this.lapses,
  });

  final DateTime dueAt;
  final int intervalDays;
  final double ease;
  final int repetitions;
  final int lapses;
}

class SrsScheduleResult {
  const SrsScheduleResult({
    required this.dueAt,
    required this.intervalDays,
    required this.ease,
    required this.repetitions,
    required this.lapses,
  });

  final DateTime dueAt;
  final int intervalDays;
  final double ease;
  final int repetitions;
  final int lapses;
}

SrsScheduleResult scheduleReview({
  required SrsScheduleInput input,
  required ReviewGrade grade,
  required DateTime now,
}) {
  final currentInterval = input.intervalDays <= 0 ? 1 : input.intervalDays;

  return switch (grade) {
    ReviewGrade.again => SrsScheduleResult(
      dueAt: now.add(const Duration(minutes: 10)),
      intervalDays: 0,
      ease: _clampEase(input.ease - 0.20),
      repetitions: 0,
      lapses: input.lapses + 1,
    ),
    ReviewGrade.hard => SrsScheduleResult(
      dueAt: now.add(
        Duration(days: _minOneDay((currentInterval * 1.2).ceil())),
      ),
      intervalDays: _minOneDay((currentInterval * 1.2).ceil()),
      ease: _clampEase(input.ease - 0.15),
      repetitions: input.repetitions + 1,
      lapses: input.lapses,
    ),
    ReviewGrade.good => _goodSchedule(input, currentInterval, now),
    ReviewGrade.easy => _easySchedule(input, currentInterval, now),
  };
}

SrsScheduleResult _goodSchedule(
  SrsScheduleInput input,
  int currentInterval,
  DateTime now,
) {
  final nextInterval = switch (input.repetitions) {
    0 => 1,
    1 => 3,
    _ => _minOneDay((currentInterval * input.ease).round()),
  };

  return SrsScheduleResult(
    dueAt: now.add(Duration(days: nextInterval)),
    intervalDays: nextInterval,
    ease: _clampEase(input.ease),
    repetitions: input.repetitions + 1,
    lapses: input.lapses,
  );
}

SrsScheduleResult _easySchedule(
  SrsScheduleInput input,
  int currentInterval,
  DateTime now,
) {
  final nextEase = _clampEase(input.ease + 0.15);
  final nextInterval = input.repetitions == 0
      ? 3
      : _minOneDay((currentInterval * nextEase * 1.3).round());

  return SrsScheduleResult(
    dueAt: now.add(Duration(days: nextInterval)),
    intervalDays: nextInterval,
    ease: nextEase,
    repetitions: input.repetitions + 1,
    lapses: input.lapses,
  );
}

double _clampEase(double ease) => ease.clamp(1.30, 3.00).toDouble();

int _minOneDay(int days) => days < 1 ? 1 : days;
