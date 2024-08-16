import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/main_failure.dart';

part 'view_single_applicants_state.dart';
part 'view_single_applicants_event.dart';
part 'view_single_applicants_bloc.freezed.dart';

class ViewSingleApplicantsBloc
    extends Bloc<ViewSingleApplicantsEvent, ViewSingleApplicantsState> {
  ViewSingleApplicantsBloc() : super(ViewSingleApplicantsState.initial()) {
    on<ViewSingleApplicantsEvent>(
      (event, emit) async {
        await event.map(
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

            if (isCardHolderNameValid &&
                isCardNumberValid &&
                isCardDateValid &&
                isCvvValid) {
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
