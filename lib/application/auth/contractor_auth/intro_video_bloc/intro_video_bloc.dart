// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/infrastructure/core/quiz_dto/quiz_dto.dart';
import 'package:video_player/video_player.dart';
part 'intro_video_event.dart';
part 'intro_video_state.dart';
part 'intro_video_bloc.freezed.dart';

@injectable
class IntroVideoBloc extends Bloc<IntroVideoEvent, IntroVideoState> {
  final IAccountRepository _repository;

  IntroVideoBloc(this._repository) : super(IntroVideoState.initial()) {
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
            isVideoComplete: false,
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
            isVideoComplete: true,
          ));
        },

        /// FOR QUIZ OF VIDEO
        getQuizResultlist: (e) async {
          Either<AccountFailure, QuizAnswerDTO>? failureOrSuccess;
          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getQuizResultApi();
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isSubmitting: false,
              ),
            ),
            (r) {
              if (r.list != null && r.list!.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isSubmitting: false,
                    questions: r.list!,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isSubmitting: false,
                  ),
                );
              }
            },
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              quizResultFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        getQuizQuestionlist: (e) async {
          Either<AccountFailure, List<QuizDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getQuizListApi();
          failureOrSuccess.fold(
            (l) => emit(
              state.copyWith(
                isSubmitting: false,
              ),
            ),
            (r) {
              if (r.isNotEmpty) {
                return emit(
                  state.copyWith(
                    isSubmitting: false,
                    questions: r,
                  ),
                );
              } else {
                return emit(
                  state.copyWith(
                    isSubmitting: false,
                  ),
                );
              }
            },
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              quizQuestionFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        optionSelected: (e) {
          final updatedQuestionList = List<QuizDTO>.from(state.questions);
          final updatedSelectedOptions = List<QuizMcqDTO>.from(
              updatedQuestionList[e.questionIndex].selectedAnswers ?? []);

          if (updatedSelectedOptions.contains(e.selectedOption)) {
            updatedSelectedOptions.remove(e.selectedOption);
          } else {
            updatedSelectedOptions.add(e.selectedOption);
          }

          final updatedQuestion = updatedQuestionList[e.questionIndex].copyWith(
            selectedAnswers: updatedSelectedOptions,
          );
          updatedQuestionList[e.questionIndex] = updatedQuestion;
          print("Updated question list---> $updatedQuestionList");
          emit(state.copyWith(
            questions: updatedQuestionList,
            quizAuthFailureOrSuccessOption: none(),
          ));
        },
        submitQuiz: (e) async {
          Either<AccountFailure, QuizAnswerDTO>? failureOrSuccess;

          var isAllValidated = state.questions.every((element) {
            return (element.selectedAnswers != null &&
                element.selectedAnswers!.isNotEmpty);
          });
          print("Is All validated -->  $isAllValidated");
          if (isAllValidated) {
            List<Map<String, dynamic>> formattedData =
                state.questions.map((question) {
              return {
                'question_id': question.id,
                'answer': question.selectedAnswers!
                    .map((answer) => answer.id.toString())
                    .join(','),
              };
            }).toList();
            print("selected answers -->  ${jsonEncode(formattedData)}");

            // emit(state.copyWith(
            //   questions: state.questions
            //       .map((q) => q.copyWith(selectedAnswers: []))
            //       .toList(),
            //   isQuizSubmitting: true,
            //   showQuizErrorMessages: false,
            //   // quizAuthFailureOrSuccessOption: some(right("success")),
            // ));
            emit(
              state.copyWith(
                isSubmitting: true,
                quizAuthFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addQuizAnswerApi(
              quizDetails: jsonEncode(formattedData),
            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isSubmitting: false,
                  quizAuthFailureOrSuccessOption: none(),
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    isSubmitting: false,
                    showErrorMessages: false,
                    quizAuthFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
          } else {
            emit(state.copyWith(
              showQuizErrorMessages: true,
              isSubmitting: false,
              quizAuthFailureOrSuccessOption: none(),
            ));
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              quizAuthFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
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
