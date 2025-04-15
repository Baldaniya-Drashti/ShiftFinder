part of 'intro_video_bloc.dart';

@freezed
class IntroVideoState with _$IntroVideoState {
  const factory IntroVideoState({
    required VideoPlayerController? controller,
    required bool isPlaying,
    required bool showErrorMessages,
    required bool isSubmitting,
    required bool isVideoComplete,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,

    /// FOR INTRO QUIZ
    required List<QuizDTO> questions,
    required List<QuizDTO> updatedQuestions,
    required bool showQuizErrorMessages,
    required bool isQuizSubmitting,
    required Option<Either<AccountFailure, QuizAnswerDTO>>
        quizAuthFailureOrSuccessOption,
    required Option<Either<AccountFailure, List<QuizDTO>>>
        quizQuestionFailureOrSuccessOption,
    required Option<Either<AccountFailure, QuizAnswerDTO>>
        quizResultFailureOrSuccessOption,
  }) = _IntroVideoState;
  factory IntroVideoState.initial() => IntroVideoState(
        controller: null,
        isPlaying: false,
        showErrorMessages: false,
        isSubmitting: false,
        isVideoComplete: false,
        authFailureOrSuccessOption: none(),

        /// FOR INTRO QUIZ
        questions: const [],
        updatedQuestions: [],
        showQuizErrorMessages: false,
        isQuizSubmitting: false,

        quizAuthFailureOrSuccessOption: none(),
        quizQuestionFailureOrSuccessOption: none(),
        quizResultFailureOrSuccessOption: none(),
      );
}
