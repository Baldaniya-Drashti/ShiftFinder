import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/presentation/auth/contractor_auth/intro_quiz.dart';
import 'package:video_player/video_player.dart';
part 'intro_video_event.dart';
part 'intro_video_state.dart';
part 'intro_video_bloc.freezed.dart';

@injectable
class IntroVideoBloc extends Bloc<IntroVideoEvent, IntroVideoState> {
  IntroVideoBloc() : super(IntroVideoState.initial()) {
    on<IntroVideoEvent>((event, emit) async {
      await event.map(
        setupVideo: (e) async {
          final controller = VideoPlayerController.networkUrl(
            Uri.parse(
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
          );
          await controller.initialize();
          controller.addListener(() {
            if (controller.value.position == controller.value.duration) {
              add(const IntroVideoEvent.videoCompleted());
            }
          });
          emit(state.copyWith(
            controller: controller,
            isPlaying: false,
          ));
        },
        playVideo: (e) async {
          final controller = state.controller;
          if (controller != null && !controller.value.isPlaying) {
            await controller.play();
            emit(state.copyWith(isPlaying: true));
          }
        },
        pauseVideo: (e) async {
          final controller = state.controller;
          if (controller != null && controller.value.isPlaying) {
            await controller.pause();
            emit(state.copyWith(isPlaying: false));
          }
        },
        videoCompleted: (e) async {
          emit(state.copyWith(
            isPlaying: false,
            isSubmitting: true,
          ));
        },

        /// FOR QUIZ OF VIDEO
        optionSelected: (e) {
          final updatedQuestionList = List<QuizQuestion>.from(state.questions);
          final updatedSelectedOptions = List<QuizMcq>.from(
              updatedQuestionList[e.questionIndex].selectedOptions);

          if (updatedSelectedOptions.contains(e.selectedOption)) {
            updatedSelectedOptions.remove(e.selectedOption);
          } else {
            updatedSelectedOptions.add(e.selectedOption);
          }

          final updatedQuestion = updatedQuestionList[e.questionIndex].copyWith(
            selectedOptions: updatedSelectedOptions,
          );
          updatedQuestionList[e.questionIndex] = updatedQuestion;
          print("Updated question list---> ${updatedQuestionList}");
          emit(state.copyWith(questions: updatedQuestionList));
        },
        submitQuiz: (e) {
          var isAllValidated = state.questions.every((element) {
            print("element.selectedOptions -->  ${element.selectedOptions}");
            return element.selectedOptions.isNotEmpty;
          });
          print("Is All validated -->  ${isAllValidated}");
          if (isAllValidated) {
            emit(state.copyWith(
              questions: state.questions
                  .map((q) => q.copyWith(selectedOptions: []))
                  .toList(),
              isQuizSubmitting: true,
              showQuizErrorMessages: false,
              quizAuthFailureOrSuccessOption: some(right("success")),
            ));
          } else {
            emit(state.copyWith(
              showQuizErrorMessages: true,
              isQuizSubmitting: false,
              quizAuthFailureOrSuccessOption: none(),
            ));
          }
        },
      );
    });
  }

  @override
  Future<void> close() {
    state.controller?.dispose();
    return super.close();
  }
}
