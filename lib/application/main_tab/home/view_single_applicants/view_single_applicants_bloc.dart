// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';

part 'view_single_applicants_state.dart';

part 'view_single_applicants_event.dart';

part 'view_single_applicants_bloc.freezed.dart';

@injectable
class ViewSingleApplicantsBloc extends Bloc<ViewSingleApplicantsEvent, ViewSingleApplicantsState> {
  final IMainFacade _mainFacade;

  ViewSingleApplicantsBloc(this._mainFacade) : super(ViewSingleApplicantsState.initial()) {
    on<ViewSingleApplicantsEvent>(
      (event, emit) async {
        await event.map(
          getShiftDetailEvent: (e) async {
            Either<MainFailure, HealthcarePostDTO>? failureOrSuccess;
            emit(
              state.copyWith(isLoading: true),
            );
            failureOrSuccess = await _mainFacade.getPostApi(
              postId: e.postId,
            );

            failureOrSuccess.fold(
              (l) => emit(state.copyWith(
                isLoading: false,
                showErrorMessages: true,
                shiftFailureOrSuccessOption: optionOf(failureOrSuccess),
              )),
              (r) {
                print("post--> $r");
                emit(state.copyWith(
                  isLoading: false,
                  showErrorMessages: false,
                  shift: r,
                  shiftFailureOrSuccessOption: optionOf(failureOrSuccess),
                ));
              },
            );
          },
          cardHolderNameChanged: (value) async {
            emit(
              state.copyWith(cardHoldersName: Username(value.cardHolderName)),
            );
          },
          cardNumberChanged: (value) async {
            emit(
              state.copyWith(cardNumber: CardNumber(value.cardNo)),
            );
          },
          validUpToChanged: (value) async {
            emit(state.copyWith(
              cardDate: CardDate(value.date),
            ));
          },
          cvvChanged: (value) async {
            emit(state.copyWith(
              cvv: CVV(value.cvv),
            ));
          },
          saveButtonPressed: (value) async {
            // Either<MainFailure, String>? failureOrSuccess;
            final isCardHolderNameValid = state.cardHoldersName.isValid();
            final isCardNumberValid = state.cardNumber.isValid();
            final isCardDateValid = state.cardDate.isValid();
            final isCvvValid = state.cvv.isValid();

            if (isCardHolderNameValid && isCardNumberValid && isCardDateValid && isCvvValid) {
              emit(
                state.copyWith(
                  isSubmitting: true,
                  showErrorMessages: false,
                  failureOrSuccessOption: none(),
                ),
              );
            }
            emit(
              state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                failureOrSuccessOption: none(),
              ),
            );
          },
          getViewSingleApplicantsAPI: (value) async {},
        );
      },
    );
  }
}
