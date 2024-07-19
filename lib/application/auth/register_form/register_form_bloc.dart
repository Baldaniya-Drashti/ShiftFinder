// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:http/http.dart' as http;

part 'register_form_event.dart';
part 'register_form_state.dart';
part 'register_form_bloc.freezed.dart';

@injectable
class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final IAuthFacade _authFacade;

  late Timer timer;
  bool isNewPassObscure = false;
  bool isConfirmPassObscure = false;

  /// TO GET GOOGLE PLACES
  Future<String?> fetchUrl(String query, {Map<String, String>? headers}) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": "AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
      },
    );
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("LOCATION CATCH ERROR: $e");
    }
    return null;
  }

  RegisterFormBloc(this._authFacade) : super(RegisterFormState.initial()) {
    on<RegisterFormEvent>((event, emit) async {
      await event.map(
        changeProfilePic: (e) {
          emit(
            state.copyWith(selectImage: e.imagePath),
          );
        },
        firstNameChanged: (e) {
          emit(
            state.copyWith(
              firstName: Username(e.firstName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        lastNameChanged: (e) {
          emit(
            state.copyWith(
              lastName: Username(e.lastName),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        registerPressed: (e) {
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
            failureOrSuccess = right("success");
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
        locationAddressChanged: (e) async {
          /// To get google place with serched result
          List<dynamic> placeList = [];
          String? response = await fetchUrl(e.location);
          if (response != null) {
            print("API RESPONSE----> $response");
            placeList = json.decode(response)['predictions'];
          }
          emit(
            state.copyWith(
              locationAddress: InputEmptyOrNot(e.location),
              searchLocationList: placeList,
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        locationSelectedFromSearchList: (e) {
          emit(
            state.copyWith(
              locationAddress: InputEmptyOrNot(e.selectedLocation),
              searchLocationList: [],
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
        registerProfileBtnPressed: (e) async {
          Either<AuthFailure, String>? failureOrSuccess;

          final isCompanyNameValid = state.companyName.isValid();
          final isPhoneNumberValid = state.phoneNumber.isValid();
          final isEmailValid = state.email.isValid();
          final isNewPassValid = state.password.isValid();
          final isConfirmPassValid = state.confirmPassword.isValid();
          final isLocationAddressValid = state.locationAddress.isValid();

          print(
              "Phone number NEW-->  ${state.selectedCountrycode}  && ${state.phoneNumber}");

          if (getCurrentRole() == 1) {
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
              // failureOrSuccess = await _authFacade.register(
              //   firstName: Username(e.firstName),
              //   lastName: Username(e.lastName),
              //   check_terms_privacy: e.isCheckTerms,
              //   countryCode: '+${state.selectedCountrycode}',
              //   profileImage: state.selectImage,
              //   companyName: state.companyName,
              //   phoneNumber: state.phoneNumber,
              //   email: state.email,
              //   password: state.password,
              //   association: state.association,
              //   companyDescription: state.companyDescription,
              //   referralCode: state.referralCode,
              //   locationAddress: state.locationAddress,
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
              failureOrSuccess = await _authFacade.register(
                firstName: Username(e.firstName),
                lastName: Username(e.lastName),
                check_terms_privacy: e.isCheckTerms,
                countryCode: '+${state.selectedCountrycode}',
                profileImage: state.selectImage,
                companyName: state.companyName,
                phoneNumber: state.phoneNumber,
                email: state.email,
                password: state.password,
                confirmPassword: state.confirmPassword,
                association: state.association,
                companyDescription: state.companyDescription,
                referralCode: null,
                locationAddress: null,
              );
              print("Failure Or successs---> ${failureOrSuccess}");
              // failureOrSuccess = right("sucess");
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
