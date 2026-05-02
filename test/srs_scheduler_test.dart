import 'package:language_tutor/features/srs/review_grade.dart';
import 'package:language_tutor/features/srs/srs_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 1, 1, 12);

  SrsScheduleInput input({
    int intervalDays = 0,
    double ease = 2.5,
    int repetitions = 0,
    int lapses = 0,
  }) {
    return SrsScheduleInput(
      dueAt: now,
      intervalDays: intervalDays,
      ease: ease,
      repetitions: repetitions,
      lapses: lapses,
    );
  }

  test('again schedules card soon and records lapse', () {
    final result = scheduleReview(
      input: input(),
      grade: ReviewGrade.again,
      now: now,
    );

    expect(result.dueAt, now.add(const Duration(minutes: 10)));
    expect(result.intervalDays, 0);
    expect(result.repetitions, 0);
    expect(result.lapses, 1);
    expect(result.ease, 2.3);
  });

  test('good follows deterministic first and second intervals', () {
    final first = scheduleReview(
      input: input(),
      grade: ReviewGrade.good,
      now: now,
    );
    final second = scheduleReview(
      input: input(intervalDays: 1, repetitions: 1),
      grade: ReviewGrade.good,
      now: now,
    );

    expect(first.intervalDays, 1);
    expect(second.intervalDays, 3);
  });

  test('ease is clamped between lower and upper bounds', () {
    final low = scheduleReview(
      input: input(ease: 1.31),
      grade: ReviewGrade.again,
      now: now,
    );
    final high = scheduleReview(
      input: input(ease: 2.95),
      grade: ReviewGrade.easy,
      now: now,
    );

    expect(low.ease, 1.30);
    expect(high.ease, 3.00);
  });
}
