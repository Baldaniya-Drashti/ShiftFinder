// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.initial()) {
    on<OnboardingEvent>((event, emit) async {
      event.map(
        submitOnboarding1: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          emit(
            state.copyWith(
              authFailureOrSuccessOption: none(),
            ),
          );
          print("setCurrentUser ---> ${e.selectedUser}");
          // failureOrSuccess = await _authFacade.login(
          //   mobileNumber: state.emailId,
          //   countryCode: '+${state.selectedCountrycode}',
          // );
          setCurrentRole(e.selectedUser);
          failureOrSuccess = right("success");
          emit(
            state.copyWith(
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        submitOnboarding2: (e) {
          Either<AuthFailure, String>? failureOrSuccess;

          /* if (e.selectedIndustry == 1) { */
          emit(
            state.copyWith(
              authFailureOrSuccessOption: none(),
            ),
          );
          // failureOrSuccess = await _authFacade.login(
          //   mobileNumber: state.emailId,
          //   countryCode: '+${state.selectedCountrycode}',
          // );
          print("setCurrentIndustry ---> ${e.selectedIndustry}");

          setCurrentIndustry(e.selectedIndustry);
          failureOrSuccess = right("success");

          emit(
            state.copyWith(
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
          /*  } else {
            emit(
              state.copyWith(
                authFailureOrSuccessOption: none(),
              ),
            );
            showUnderDevelopment(e.context);
          } */
        },
        submitOnboarding3: (e) {
          setUserShowIntro(false);
          emit(
            state.copyWith(
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(right("success")),
            ),
          );
        },
      );
    });
  }
}
