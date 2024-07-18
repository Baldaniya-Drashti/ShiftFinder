// ignore_for_file: avoid_print

import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
part 'register_form_event.dart';
part 'register_form_state.dart';
part 'register_form_bloc.freezed.dart';

@injectable
class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  late Timer timer;
  bool isNewPassObscure = false;
  bool isConfirmPassObscure = false;

  RegisterFormBloc() : super(RegisterFormState.initial()) {
    on<RegisterFormEvent>((event, emit) async {
      await event.map(
        changeProfilePicture: (value) {
          emit(
            state.copyWith(selectImage: value.imagePath),
          );
        },
        firstNameChanged: (e) {
          emit(
            state.copyWith(
              firstName: InputEmptyOrNot(e.firstName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        lastNameChanged: (e) {
          emit(
            state.copyWith(
              lastName: InputEmptyOrNot(e.lastName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        registerPressed: (e) async {
          Either<AuthFailure, String>? failureOrSuccess;
          final isFirstNameValid = state.firstName.isValid();
          final isLastNameValid = state.lastName.isValid();
          final isCheckTerms = state.isCheck;

          if (isFirstNameValid && isLastNameValid && isCheckTerms) {
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
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
        checkTermsCondition: (e) {
          emit(
            state.copyWith(
              isCheck: e.isCheck,
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        /// >>>>>>>>>>>>>>>>>>> FOR REGISTER PROFILE PAGE <<<<<<<<<<<<<<<<<<<<
        companyNameChanged: (e) {
          emit(
            state.copyWith(
              companyName: InputEmptyOrNot(e.companyName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        phoneNumberChanged: (e) {
          emit(
            state.copyWith(
              phoneNumber: MobileNumber(e.phoneNumber),
              enteredPhoneNo: e.phoneNumber,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        selectCountryCode: (e) {
          emit(
            state.copyWith(
              selectedCountrycode: e.phoneCode,
              selectedCountryFlag: e.flag,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        emailChanged: (e) {
          emit(
            state.copyWith(
              email: EmailAddress(e.email),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        passwordChanged: (e) {
          emit(
            state.copyWith(
              password: Password(e.password),
              enteredPassword: e.password,
              authFailureOrSuccessOption: none(),
            ),
          );
          add(RegisterFormEvent.confirmPasswordChanged(
              state.confirmPassword.getValue(), e.password));
        },
        confirmPasswordChanged: (e) {
          emit(
            state.copyWith(
              confirmPassword:
                  ConfirmPassword(e.confirmPassword, state.password.getValue()),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        associationTextChanged: (e) {
          emit(
            state.copyWith(
              association: e.associationText,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationAddressChanged: (e) {
          emit(
            state.copyWith(
              locationAddress: InputEmptyOrNot(e.location),
              authFailureOrSuccessOption: none(),
            ),
          );
        },

        referralCodeChanged: (e) {
          emit(
            state.copyWith(
              referralCode: e.referralCode,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        companyDescChanged: (e) {
          emit(
            state.copyWith(
              companyDescription: e.companyDesc,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        registerProfileBtnPressed: (e) {
          Either<AuthFailure, String>? failureOrSuccess;

          final isCompanyNameValid = state.companyName.isValid();
          final isPhoneNumberValid = state.phoneNumber.isValid();
          final isEmailValid = state.email.isValid();
          final isNewPassValid = state.password.isValid();
          final isConfirmPassValid = state.confirmPassword.isValid();
          final isLocationAddressValid = state.locationAddress.isValid();

          print("PASS NEW-->  ${isNewPassValid}  && ${state.password}");
          print(
              "PASS CONFIRM-->  ${isConfirmPassValid}  && ${state.confirmPassword}");

          if (getCurrentUser() == 0) {
            if (isPhoneNumberValid &&
                isEmailValid &&
                isNewPassValid &&
                isConfirmPassValid &&
                isLocationAddressValid) {
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
          } else {
            if (isCompanyNameValid &&
                isPhoneNumberValid &&
                isEmailValid &&
                isNewPassValid &&
                isConfirmPassValid) {
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
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
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

        /// >>>>>>>>>>>>>>>>>>> FOR OTP VERIFICATION BOTTOM SHEET <<<<<<<<<<<<<<<<<<<<

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
              add(const RegisterFormEvent.decrementTimer());
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
          add(const RegisterFormEvent.startCountdown());
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
            timer.cancel();
          }

          emit(
            state.copyWith(
              isSubmitting: false,
              showOtpErrorMessages: true,
              verifyOtpFailureOrSuccessOption: optionOf(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
}
