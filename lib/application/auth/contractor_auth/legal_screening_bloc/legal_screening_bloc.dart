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
import 'package:shift/infrastructure/core/legal_screening_dto/legal_screening_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart';

part 'legal_screening_event.dart';
part 'legal_screening_state.dart';
part 'legal_screening_bloc.freezed.dart';

@injectable
class LegalScreeningBloc
    extends Bloc<LegalScreeningEvent, LegalScreeningState> {
  /*static List<QuestionModel> questionList = [
    QuestionModel(
      question: "Are you legally eligible to work in Canada?",
      showNotApplicableButton: false,
    ),
    QuestionModel(
      question:
          "Have you ever been convicted of a felony or been charged with a criminal offence for which  a pardon has not been granted?",
      showNotApplicableButton: false,
    ),
    QuestionModel(
      question:
          "Do you have a valid liability insurance as required by the provincial licensing authority?",
      showNotApplicableButton: true,
    ),
    QuestionModel(
      question:
          "Is your license currently registered as active with your provincial licensing authority and in  good standing?",
      showNotApplicableButton: true,
    ),
    QuestionModel(
      question:
          "Have you ever had your provincial license restricted, suspended, or revoked by your  provincial licensing authority?",
      showNotApplicableButton: true,
    ),
    QuestionModel(
      question:
          "Have you ever been found guilty of professional malpractice, misconduct or incapacitated  by your provincial licensing authority?",
      showNotApplicableButton: true,
    ),
  ];*/

  final IAccountRepository _repository;

  LegalScreeningBloc(this._repository) : super(LegalScreeningState.initial()) {
    on<LegalScreeningEvent>((event, emit) async {
      await event.map(
        getLegalScreeningQuestionList: (e) async {
          // emit(
          //   state.copyWith(
          //     questionList: LegalScreeningBloc.questionList,
          //     authFailureOrSuccessOption: none(),
          //   ),
          // );

          Either<AccountFailure, List<LegalScreeningDTO>>? failureOrSuccess;
          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );
          failureOrSuccess = await _repository.getLegalScreeningListApi();
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
                    questionList: r,
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
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        checkTermsConfirmation: (e) {
          emit(
            state.copyWith(
              isCheck: e.isCheck,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        storeAnswerEvent: (e) {
          final updatedList = List<LegalScreeningDTO>.from(state.questionList);
          for (int i = 0; i < updatedList.length; i++) {
            if (i == e.currentIndex) {
              LegalScreeningDTO obj = LegalScreeningDTO(
                id: updatedList[i].id,
                name: updatedList[i].name,
                isNa: updatedList[i].isNa,
                answer: e.answer,
              );
              updatedList.removeAt(i);
              updatedList.insert(i, obj);
            }
          }
          emit(
            state.copyWith(
              questionList: List.from(updatedList),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        continueBtnPressed: (e) async {
          Either<AccountFailure, Account>? failureOrSuccess;
          final isCheckTerms = state.isCheck;
          final allAnswersFilled =
              state.questionList.every((question) => (question.answer != null));

          if (isCheckTerms && allAnswersFilled) {
            var list = mapLegalScreeningDTOToApiFormat(state.questionList);

            print("All questions with answer--> $list");

            emit(
              state.copyWith(
                isSubmitting: true,
                submitFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _repository.addLergalScreeningAnswerApi(
              affirmIsCheck: (isCheckTerms) ? 1 : 0,
              questionAnswerDetail: jsonEncode(list),

            );

            failureOrSuccess.fold(
              (l) => emit(
                state.copyWith(
                  isSubmitting: false,
                ),
              ),
              (r) {
                emit(
                  state.copyWith(
                    isSubmitting: false,
                    showErrorMessages: false,
                    submitFailureOrSuccessOption: none(),
                  ),
                );
              },
            );
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              isAllAnswered: allAnswersFilled,
              submitFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }

  List<Map<String, dynamic>> mapLegalScreeningDTOToApiFormat(
      List<LegalScreeningDTO> specialities) {
    return specialities.map((speciality) {
      return {
        'question_id': speciality.id,
        'answer': speciality.answer,
      };
    }).toList();
  }
}
