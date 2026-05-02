import '../../data/models/tutor_result.dart';

class CaptureState {
  const CaptureState({
    required this.isRunning,
    required this.isGenerating,
    required this.currentLesson,
    required this.errorMessage,
  });

  factory CaptureState.initial() {
    return const CaptureState(
      isRunning: false,
      isGenerating: false,
      currentLesson: null,
      errorMessage: null,
    );
  }

  final bool isRunning;
  final bool isGenerating;
  final TutorResult? currentLesson;
  final String? errorMessage;

  CaptureState copyWith({
    bool? isRunning,
    bool? isGenerating,
    TutorResult? currentLesson,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CaptureState(
      isRunning: isRunning ?? this.isRunning,
      isGenerating: isGenerating ?? this.isGenerating,
      currentLesson: currentLesson ?? this.currentLesson,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
