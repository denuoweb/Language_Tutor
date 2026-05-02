class ReviewState {
  const ReviewState({
    required this.revealedCardIds,
    required this.isRecording,
    required this.errorMessage,
  });

  factory ReviewState.initial() {
    return const ReviewState(
      revealedCardIds: {},
      isRecording: false,
      errorMessage: null,
    );
  }

  final Set<String> revealedCardIds;
  final bool isRecording;
  final String? errorMessage;

  bool isRevealed(String cardId) => revealedCardIds.contains(cardId);

  ReviewState copyWith({
    Set<String>? revealedCardIds,
    bool? isRecording,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ReviewState(
      revealedCardIds: revealedCardIds ?? this.revealedCardIds,
      isRecording: isRecording ?? this.isRecording,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
