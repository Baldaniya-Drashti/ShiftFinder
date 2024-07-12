import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/infrastructure/core/network/hive_box_names.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';
part 'onboarding_bloc.freezed.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.initial()) {
    on<OnboardingEvent>((event, emit) async {
      await event.map(
        submitOnboarding1: (e) async {
          Either<AuthFailure, String>? failureOrSuccess;
          emit(
            state.copyWith(
              authFailureOrSuccessOption: none(),
            ),
          );
          // failureOrSuccess = await _authFacade.login(
          //   mobileNumber: state.emailId,
          //   countryCode: '+${state.selectedCountrycode}',
          // );
          await Hive.box(BoxNames.settingsBox)
              .put(BoxKeys.currentUser, e.selectedUser);

          failureOrSuccess = right("success");

          emit(
            state.copyWith(
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
