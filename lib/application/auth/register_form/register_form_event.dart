part of 'register_form_bloc.dart';

@freezed
class RegisterFormEvent with _$RegisterFormEvent {
  const factory RegisterFormEvent.firstNameChanged(String firstName) =
      FirstNameChanged;
  const factory RegisterFormEvent.lastNameChanged(String lastName) =
      LastNameChanged;
  const factory RegisterFormEvent.checkTermsCondition(bool isCheck) =
      CheckTermsCondition;
  const factory RegisterFormEvent.registerPressed() = RegisterPressed;

  /// >>>>>>>>>>>>>>>>>>> FOR REGISTER PROFILE PAGE <<<<<<<<<<<<<<<<<<<<

  const factory RegisterFormEvent.changeProfilePic(String imagePath) =
      ChangeProfilePic;
  const factory RegisterFormEvent.companyNameChanged(String companyName) =
      CompanyNameChanged;
  const factory RegisterFormEvent.phoneNumberChanged(String phoneNumber) =
      phoneNumberChanged;
  const factory RegisterFormEvent.emailChanged(String email) = EmailChanged;
  const factory RegisterFormEvent.locationAddressChanged(String location) =
      LocationAddressChanged;
  const factory RegisterFormEvent.locationSelectedFromSearchList(
      Predictions selectedLocation) = _LocationSelectedFromSearchList;
  const factory RegisterFormEvent.passwordChanged(String password) =
      PasswordChanged;
  const factory RegisterFormEvent.confirmPasswordChanged(
      String confirmPassword, String password) = ConfirmPasswordChanged;
  const factory RegisterFormEvent.associationTextChanged(
      String associationText) = AssociationTextChanged;
  const factory RegisterFormEvent.referralCodeChanged(String referralCode) =
      ReferralCodeChanged;
  const factory RegisterFormEvent.companyDescChanged(String companyDesc) =
      CompanyDescChanged;
  const factory RegisterFormEvent.selectCountryCode(
      String phoneCode, String flag) = SelectCountryCode;
  const factory RegisterFormEvent.registerProfileBtnPressed(
    BuildContext context, {
    required String firstName,
    required String lastName,
    required int isCheckTerms,
  }) = RegisterProfileBtnPressed;

  const factory RegisterFormEvent.obscureText(int field) = ObscureText;
  const factory RegisterFormEvent.dobChanged(String dob) = DobChanged;

  /// >>>>>>>>>>>>>>>>>>> FOR OTP VERIFICATION BOTTOM SHEET <<<<<<<<<<<<<<<<<<<<

  const factory RegisterFormEvent.changeOTP(String otp) = ChangeOTP;
  const factory RegisterFormEvent.startCountdown() = StartCountdown;
  const factory RegisterFormEvent.decrementTimer() = DecrementTimer;
  const factory RegisterFormEvent.resendOtp() = ResendOtp;
  const factory RegisterFormEvent.verifyOtp(String password) = VerifyOtp;
  const factory RegisterFormEvent.editedEmailEvent(String value) =
      EditedEmailEvent;
  const factory RegisterFormEvent.editedPhoneEvent(String value,
      {String? countryCode, String? countryFlag}) = EditedPhoneEvent;
  const factory RegisterFormEvent.editEmailOrPhone(BuildContext context,
      {String? email, String? phone, String? countryCode}) = EditEmailOrPhone;
  const factory RegisterFormEvent.selectEditedCountryCode(
      String phoneCode, String flag) = SelectEditedCountryCode;
  const factory RegisterFormEvent.clearLocationCtrlEvent() =
      ClearLocationCtrlEvent;
}
