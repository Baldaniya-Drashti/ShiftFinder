part of 'intro_video_bloc.dart';

@freezed
class IntroVideoEvent with _$IntroVideoEvent {
  const factory IntroVideoEvent.setupVideo() = _SetupVideo;
  const factory IntroVideoEvent.playVideo() = _PlayVideo;
  const factory IntroVideoEvent.pauseVideo() = _PauseVideo;
  const factory IntroVideoEvent.videoCompleted() = _VideoCompleted;

  /// FOR INTRO QUIZ
  const factory IntroVideoEvent.optionSelected({
    required int questionIndex,
    required QuizMcq selectedOption,
  }) = _OptionSelected;

  const factory IntroVideoEvent.submitQuiz() = _SubmitQuiz;
}
