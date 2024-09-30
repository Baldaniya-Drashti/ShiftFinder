// ignore_for_file: await_only_futures, avoid_print

import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';
part 'forgot_password_bloc.freezed.dart';

@injectable
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final IAuthFacade _authFacade;
  late Timer timer;
  bool isNewPassObscure = false;
  bool isConfirmPassObscure = false;

  ForgotPasswordBloc(this._authFacade) : super(ForgotPasswordState.initial()) {
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
        emailChanged: (e) {
          emit(
            state.copyWith(
              emailAddress: EmailAddress(e.email),
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
          bool isMobileEmailValid = false;
          if (getCurrentRole() == 1) {
            isMobileEmailValid = state.mobileNumber.isValid();
          } else {
            isMobileEmailValid = state.emailAddress.isValid();
          }
          if (isMobileEmailValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
              ),
            );

            failureOrSuccess = await _authFacade.resendOtp(
              emailAddress:
                  (getCurrentRole() == 1) ? "" : state.emailAddress.getValue(),
              phoneNumber:
                  (getCurrentRole() == 1) ? state.mobileNumber.getValue() : "",
              forgotPassword: true,
            );
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
              add(const ForgotPasswordEvent.decrementTimer());
            } else {
              timer.cancel();
              // add(const LoginFormEvent.resendOtp());
            }
          });
          emit(state.copyWith(
            secondsRemaining: 60,
            verifyOtpFailureOrSuccessOption: none(),
          ));
        },
        decrementTimer: (DecrementTimer value) {
          emit(state.copyWith(
            secondsRemaining: state.secondsRemaining - 1,
            authFailureOrSuccessOption: none(),
            resendFailureOrSuccessOption: none(),
            verifyOtpFailureOrSuccessOption: none(),
          ));
        },
        resendOtp: (ResendOtp value) async {
          timer.cancel();

          Either<AuthFailure, String>? failureOrSuccess;

          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );

          // failureOrSuccess = await _authFacade.resendOtp(
          //   countryCode: '+${state.selectedCountrycode}',
          //   mobileNumber: state.mobileNumber,
          // );
          failureOrSuccess = await _authFacade.resendOtp(
            emailAddress:
                (getCurrentRole() == 1) ? "" : state.emailAddress.getValue(),
            phoneNumber:
                (getCurrentRole() == 1) ? state.mobileNumber.getValue() : "",
            forgotPassword: true,
          );

          emit(
            state.copyWith(
              isSubmitting: false,
              //showErrorMessages: true,
              secondsRemaining: 60,
              resendFailureOrSuccessOption: optionOf(failureOrSuccess),
              verifyOtpFailureOrSuccessOption: none(),
            ),
          );
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

            failureOrSuccess = await _authFacade.verifyOtp(
              emailAddress:
                  (getCurrentRole() == 1) ? "" : state.emailAddress.getValue(),
              phoneNumber:
                  (getCurrentRole() == 1) ? state.mobileNumber.getValue() : "",
              otp: state.enteredOTP,
              isForgotPassword: true,
            );
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
        saveNewPassword: (e) async {
          Either<AuthFailure, String>? failureOrSuccess;
          final isNewPassValid = state.newPassword.isValid();
          final isConfirmPassValid = state.confirmPassword.isValid();
          print("SAVE BTN CLICK  $isNewPassValid");
          if (isNewPassValid && isConfirmPassValid) {
            emit(
              state.copyWith(
                isSubmitting: true,
                authFailureOrSuccessOption: none(),
                saveNewPassFailureOrSuccessOption: none(),
              ),
            );
            failureOrSuccess = await _authFacade.forgotPassword(
                password: state.newPassword.getValue(),
                confirmPassword: state.confirmPassword.getValue());
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
