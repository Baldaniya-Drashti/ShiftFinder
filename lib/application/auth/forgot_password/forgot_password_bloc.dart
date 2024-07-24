// ignore_for_file: await_only_futures, avoid_print

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  late Timer timer;
  bool isNewPassObscure = false;
  bool isConfirmPassObscure = false;

  ForgotPasswordBloc() : super(ForgotPasswordState.initial()) {
    on<ForgotPasswordEvent>((event, emit) async {
      await event.map(
        /// >>>>>>>>>>>>>>>>>>>> FOR FORGOT PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<

        mobileNumberChanged: (e) {
          emit(
            state.copyWith(
              mobileNumber: MobileNumber(e.mobileNumber),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        selectCountryCode: (e) {
          emit(
            state.copyWith(
              selectedCountrycode: e.counryCode,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        sendOtpPressed: (e) async {
          Either<AuthFailure, String>? failureOrSuccess;

          final isMobileNumberValid = state.mobileNumber.isValid();
          if (isMobileNumberValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: EmailAddress(""),
            //   countryCode: '+${state.selectedCountrycode}',
            // );

            failureOrSuccess = right("sucess");
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        nextPage: (NextPage value) {
          emit(
            state.copyWith(
              currentView: value.page,
              authFailureOrSuccessOption: none(),
            ),
          );
          if (value.page == 1) {
            add(const ForgotPasswordEvent.startCountdown());
          } else {
            timer.cancel();
          }
        },

        /// >>>>>>>>>>>>>>>>>>>> FOR OTP SCREEN <<<<<<<<<<<<<<<<<<<<

        changeOTP: (ChangeOTP value) {
          emit(
            state.copyWith(
              enteredOTP: OTPText(value.otp),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        startCountdown: (StartCountdown value) {
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (state.secondsRemaining > 0 && !isClosed) {
              print("CURRENT SECOND: 0 ------->  ${state.secondsRemaining}");
              add(const ForgotPasswordEvent.decrementTimer());
              print("CURRENT SECOND: 1 ------->  ${state.secondsRemaining}");
            } else {
              timer.cancel();
              // add(const LoginFormEvent.resendOtp());
            }
          });
          emit(state.copyWith(secondsRemaining: 30));
        },
        decrementTimer: (DecrementTimer value) {
          print("CURRENT SECOND: 2 ------->  ${state.secondsRemaining}");
          emit(state.copyWith(
            secondsRemaining: state.secondsRemaining - 1,
            authFailureOrSuccessOption: none(),
            resendFailureOrSuccessOption: none(),
          ));
        },
        resendOtp: (ResendOtp value) async {
          //timer.cancel();

          // Either<AuthFailure, String>? failureOrSuccess;

          // emit(
          //   state.copyWith(
          //     isSubmitting: true,
          //     authFailureOrSuccessOption: none(),
          //   ),
          // );

          // failureOrSuccess = await _authFacade.resendOtp(
          //   countryCode: '+${state.selectedCountrycode}',
          //   mobileNumber: state.mobileNumber,
          // );

          // emit(
          //   state.copyWith(
          //     isSubmitting: false,
          //     //showErrorMessages: true,
          //     secondsRemaining: 30,
          //     resendFailureOrSuccessOption: optionOf(failureOrSuccess),
          //   ),
          // );
          add(const ForgotPasswordEvent.startCountdown());
        },
        verifyOtp: (VerifyOtp value) async {
          Either<AuthFailure, String>? failureOrSuccess;

          final isOTPValid = state.enteredOTP.isValid();

          if (isOTPValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.verifyOtp(
            //   countryCode: '+${state.selectedCountrycode}',
            //   mobileNumber: state.mobileNumber,
            //   otp: state.enteredOTP,
            // );
            failureOrSuccess = right("success");
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showOtpErrorMessages: true,
              verifyOtpFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },

        /// >>>>>>>>>>>>>>>>>>>> FOR NEW PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<
        newPasswordChanged: (e) {
          emit(
            state.copyWith(
              newPassword: Password(e.newPassword),
              authFailureOrSuccessOption: none(),
            ),
          );
          add(ForgotPasswordEvent.confirmPasswordChanged(
              state.confirmPassword.getValue(), e.newPassword));
        },
        confirmPasswordChanged: (e) {
          emit(
            state.copyWith(
              confirmPassword: ConfirmPassword(
                  e.confirmPassword, state.newPassword.getValue()),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        obscureText: (value) {
          if (value.field == 1) {
            isNewPassObscure = !isNewPassObscure;
            emit(
              state.copyWith(
                isNewPassObscure: isNewPassObscure,
                authFailureOrSuccessOption: none(),
              ),
            );
          } else {
            isConfirmPassObscure = !isConfirmPassObscure;
            emit(
              state.copyWith(
                isConfirmPassObscure: isConfirmPassObscure,
                authFailureOrSuccessOption: none(),
              ),
            );
          }
        },
        saveNewPassword: (e) {
          Either<AuthFailure, String>? failureOrSuccess;
          final isNewPassValid = state.newPassword.isValid();
          final isConfirmPassValid = state.confirmPassword.isValid();
          print("SAVE BTN CLICK  $isNewPassValid");
          if (isNewPassValid && isConfirmPassValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );
            // failureOrSuccess = await _authFacade.login(
            //   mobileNumber: EmailAddress(""),
            //   countryCode: '+${state.selectedCountrycode}',
            // );
            failureOrSuccess = right("sucess");
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showNewPassErrorMessages: true,
              saveNewPassFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
