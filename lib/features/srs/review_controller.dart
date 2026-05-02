import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/app_providers.dart';
import '../../shared/clock.dart';
import 'review_grade.dart';
import 'review_state.dart';

class ReviewController extends Notifier<ReviewState> {
  @override
  ReviewState build() => ReviewState.initial();

  void reveal(String cardId) {
    state = state.copyWith(
      revealedCardIds: {...state.revealedCardIds, cardId},
      clearError: true,
    );
  }

  Future<void> grade(String cardId, ReviewGrade grade) async {
    state = state.copyWith(isRecording: true, clearError: true);
    try {
      await ref
          .read(srsRepositoryProvider)
          .recordReview(cardId: cardId, grade: grade, now: systemNow());
      final nextRevealed = {...state.revealedCardIds}..remove(cardId);
      state = state.copyWith(
        revealedCardIds: nextRevealed,
        isRecording: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isRecording: false,
        errorMessage: error.toString(),
      );
    }
  }
}

final reviewControllerProvider =
    NotifierProvider<ReviewController, ReviewState>(ReviewController.new);
