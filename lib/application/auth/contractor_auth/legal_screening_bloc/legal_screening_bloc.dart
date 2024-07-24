import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart';

part 'legal_screening_event.dart';
part 'legal_screening_state.dart';
part 'legal_screening_bloc.freezed.dart';

@injectable
class LegalScreeningBloc
    extends Bloc<LegalScreeningEvent, LegalScreeningState> {
  static List<QuestionModel> questionList = [
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
  ];

  LegalScreeningBloc() : super(LegalScreeningState.initial()) {
    on<LegalScreeningEvent>((event, emit) {
      event.map(
        getLegalScreeningQuestionList: (e) {
          emit(
            state.copyWith(
              questionList: LegalScreeningBloc.questionList,
              authFailureOrSuccessOption: none(),
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
          final updatedList = List<QuestionModel>.from(state.questionList);
          for (int i = 0; i < updatedList.length; i++) {
            if (i == e.currentIndex) {
              QuestionModel obj = QuestionModel(
                question: updatedList[i].question,
                showNotApplicableButton: updatedList[i].showNotApplicableButton,
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
        continueBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isCheckTerms = state.isCheck;
          final allAnswersFilled = state.questionList.every((question) =>
              (question.answer != null && question.answer!.isNotEmpty));

          if (isCheckTerms && allAnswersFilled) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = right("true");
          }
          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              isAllAnswered: allAnswersFilled,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
