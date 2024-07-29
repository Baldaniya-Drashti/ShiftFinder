part of 'forgot_password_bloc.dart';

@freezed
class ForgotPasswordEvent with _$ForgotPasswordEvent {
  /// >>>>>>>>>>>>>>>>>>>> FOR FORGOT PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<

  const factory ForgotPasswordEvent.mobileNumberChanged(String mobileNumber) =
      MobileNumberChanged;
  const factory ForgotPasswordEvent.emailChanged(String email) = EmailChanged;
  const factory ForgotPasswordEvent.selectCountryCode(String counryCode) =
      SelectCountryCode;
  const factory ForgotPasswordEvent.sendOtpPressed() = SendOtpPressed;
  const factory ForgotPasswordEvent.nextPage(int page) = NextPage;

  /// >>>>>>>>>>>>>>>>>>>> FOR OTP SCREEN <<<<<<<<<<<<<<<<<<<<

  const factory ForgotPasswordEvent.changeOTP(String otp) = ChangeOTP;
  const factory ForgotPasswordEvent.startCountdown() = StartCountdown;
  const factory ForgotPasswordEvent.decrementTimer() = DecrementTimer;
  const factory ForgotPasswordEvent.resendOtp() = ResendOtp;
  const factory ForgotPasswordEvent.verifyOtp() = VerifyOtp;

  /// >>>>>>>>>>>>>>>>>>>> FOR NEW PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<

  const factory ForgotPasswordEvent.newPasswordChanged(String newPassword) =
      NewPasswordChanged;
  const factory ForgotPasswordEvent.confirmPasswordChanged(
      String confirmPassword, String newPassword) = ConfirmPasswordChanged;

  const factory ForgotPasswordEvent.obscureText(int field) = ObscureText;
  const factory ForgotPasswordEvent.saveNewPassword() = SaveNewPassword;
}
