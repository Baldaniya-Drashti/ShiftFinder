part of 'register_form_bloc.dart';

@freezed
class RegisterFormState with _$RegisterFormState {
  const factory RegisterFormState({
    required InputEmptyOrNot firstName,
    required InputEmptyOrNot lastName,
    required FocusNode firstNameFocusNode,
    required bool isSubmitting,
    required bool isCheck,
    required bool showErrorMessages,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,

    /// >>>>>>>>>>>>>>>>>>> FOR REGISTER PROFILE PAGE <<<<<<<<<<<<<<<<<<<<

    required String selectImage,
    required InputEmptyOrNot companyName,
    required MobileNumber phoneNumber,
    required EmailAddress email,
    required Password password,
    required ConfirmPassword confirmPassword,
    required String association,
    required String referralCode,
    required String companyDescription,
    required String selectedCountrycode,
    required String selectedCountryFlag,
    required bool isNewPassObscure,
    required bool isConfirmPassObscure,

    /// >>>>>>>>>>>>>>>>>>> FOR OTP VERIFICATION BOTTOM SHEET <<<<<<<<<<<<<<<<<<<<

    required OTPText enteredOTP,
    required int secondsRemaining,
    required bool showOtpErrorMessages,
    required Option<Either<AuthFailure, String>> resendFailureOrSuccessOption,
    required Option<Either<AuthFailure, String>>
        verifyOtpFailureOrSuccessOption,
  }) = _RegisterFormState;

  factory RegisterFormState.initial() => RegisterFormState(
        firstNameFocusNode: FocusNode(),
        firstName: InputEmptyOrNot(""),
        lastName: InputEmptyOrNot(""),
        isSubmitting: false,
        showErrorMessages: false,
        isCheck: false,
        authFailureOrSuccessOption: none(),

        /// >>>>>>>>>>>>>>>>>>> FOR REGISTER PROFILE PAGE <<<<<<<<<<<<<<<<<<<<
        selectImage: "",
        companyName: InputEmptyOrNot(""),
        phoneNumber: MobileNumber(""),
        email: EmailAddress(""),
        password: Password(""),
        confirmPassword: ConfirmPassword("", ""),
        association: "",
        referralCode: "",
        companyDescription: "",
        selectedCountrycode: "",
        selectedCountryFlag: "🇺🇸",
        isNewPassObscure: true,
        isConfirmPassObscure: true,

        /// OTP VIEW
        enteredOTP: OTPText(''),
        secondsRemaining: 0,
        showOtpErrorMessages: false,
        resendFailureOrSuccessOption: none(),
        verifyOtpFailureOrSuccessOption: none(),
      );
}
