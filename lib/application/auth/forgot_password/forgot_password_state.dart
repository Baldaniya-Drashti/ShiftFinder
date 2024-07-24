part of 'forgot_password_bloc.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState({
    required bool isSubmitting,
    required int currentView,

    /// >>>>>>>>>>>>>>>>>>>> FOR FORGOT PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<

    required MobileNumber mobileNumber,
    required String selectedCountrycode,
    required bool showErrorMessages,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,

    /// >>>>>>>>>>>>>>>>>>>> FOR OTP SCREEN <<<<<<<<<<<<<<<<<<<<

    required OTPText enteredOTP,
    required int secondsRemaining,
    required bool showOtpErrorMessages,
    required Option<Either<AuthFailure, String>> resendFailureOrSuccessOption,
    required Option<Either<AuthFailure, String>>
        verifyOtpFailureOrSuccessOption,

    /// >>>>>>>>>>>>>>>>>>>> FOR NEW PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<

    required Password newPassword,
    required ConfirmPassword confirmPassword,
    required bool isNewPassObscure,
    required bool isConfirmPassObscure,
    required bool showNewPassErrorMessages,
    required Option<Either<AuthFailure, String>>
        saveNewPassFailureOrSuccessOption,
  }) = _ForgotPasswordState;

  factory ForgotPasswordState.initial() => ForgotPasswordState(
        currentView: 0,
        isSubmitting: false,

        /// MOBILE NO VIEW
        mobileNumber: MobileNumber(""),
        selectedCountrycode: "🇨🇦",
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),

        /// OTP VIEW
        enteredOTP: OTPText(''),
        secondsRemaining: 0,
        showOtpErrorMessages: false,
        resendFailureOrSuccessOption: none(),
        verifyOtpFailureOrSuccessOption: none(),

        /// NEW PASSWORD VIEW
        newPassword: Password(""),
        confirmPassword: ConfirmPassword("", ""),
        isNewPassObscure: true,
        isConfirmPassObscure: true,
        showNewPassErrorMessages: false,
        saveNewPassFailureOrSuccessOption: none(),
      );
}
