part of 'intro_video_bloc.dart';

@freezed
class IntroVideoState with _$IntroVideoState {
  const factory IntroVideoState({
    required VideoPlayerController? controller,
    required bool isPlaying,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,

    /// FOR INTRO QUIZ
    // required List<QuizModel> questionList,
    // required bool showQuizErrorMessages,
    // required bool isQuizSubmitting,
    required List<QuizQuestion> questions,
    required List<QuizQuestion> updatedQuestions,
    required bool showQuizErrorMessages,
    required bool isQuizSubmitting,
    required Option<Either<AuthFailure, String>> quizAuthFailureOrSuccessOption,
  }) = _IntroVideoState;
  factory IntroVideoState.initial() => IntroVideoState(
        controller: null,
        isPlaying: false,
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),

        /// FOR INTRO QUIZ
        // questionList: [],
        // showQuizErrorMessages: false,
        // isQuizSubmitting: false,
        questions: const [
          QuizQuestion(
            question:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna?",
            options: [
              QuizMcq(id: 1, mcq: "Long term care"),
              QuizMcq(id: 2, mcq: "Hospital"),
              QuizMcq(id: 3, mcq: "Community"),
              QuizMcq(id: 4, mcq: "Retail"),
            ],
            selectedOptions: [],
          ),
          QuizQuestion(
            question:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna?",
            options: [
              QuizMcq(id: 1, mcq: "Long term care"),
              QuizMcq(id: 2, mcq: "Hospital"),
              QuizMcq(id: 3, mcq: "Community"),
              QuizMcq(id: 4, mcq: "Retail"),
            ],
            selectedOptions: [],
          ),
          QuizQuestion(
            question:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna?",
            options: [
              QuizMcq(id: 1, mcq: "Long term care"),
              QuizMcq(id: 2, mcq: "Hospital"),
              QuizMcq(id: 3, mcq: "Community"),
              QuizMcq(id: 4, mcq: "Retail"),
            ],
            // ["Long Term Care", "Hospital", "Community", "Retail"],
            selectedOptions: [],
          ),
        ],
        updatedQuestions: [],
        showQuizErrorMessages: false,
        isQuizSubmitting: false,

        quizAuthFailureOrSuccessOption: none(),
      );
}

@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String question,
    required List<QuizMcq> options,
    required List<QuizMcq> selectedOptions,
  }) = _QuizQuestion;
}

@freezed
class QuizMcq with _$QuizMcq {
  const factory QuizMcq({
    required int id,
    required String mcq,
  }) = _QuizMcq;
}
