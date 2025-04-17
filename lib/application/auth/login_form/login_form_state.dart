part of 'login_form_bloc.dart';

@freezed
class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    required EmailAddress emailId,
    required InputEmptyOrNot password,
    required bool isObscure,
    required bool showErrorMessages,
    required bool isSubmitting,
    required String selectedCountrycode,
    required OTPText enteredOTP,
    required int secondsRemaining,
    required FocusNode mobileNumberFocusNode,
    required Option<Either<AuthFailure, Account>> authFailureOrSuccessOption,
    required Option<Either<AuthFailure, Account>>
        verificationFailureOrSuccessOption,
    required Option<Either<AuthFailure, String>> resendFailureOrSuccessOption,
  }) = _LoginFormState;

  factory LoginFormState.initial() => LoginFormState(
        emailId: EmailAddress(''),
        password: InputEmptyOrNot(''),
        isObscure: true,
        showErrorMessages: false,
        isSubmitting: false,
        authFailureOrSuccessOption: none(),
        verificationFailureOrSuccessOption: none(),
        selectedCountrycode: '1',
        enteredOTP: OTPText(''),
        secondsRemaining: 0,
        mobileNumberFocusNode: FocusNode(),
        resendFailureOrSuccessOption: none(),
      );
}
