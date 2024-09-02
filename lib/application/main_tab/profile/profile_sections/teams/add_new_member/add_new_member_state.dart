part of 'add_new_member_bloc.dart';

@freezed
class AddNewMemberState with _$AddNewMemberState {
  factory AddNewMemberState({
    required InputEmptyOrNot locationTextField,
    required InputEmptyOrNot teamNameTextField,
    required MobileNumber mobileNumber,
    required EmailAddress emailAddress,
    required bool showErrorMessages,
    required String selectedCountryCode,
    required String selectedCountryFlag,
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> failureOrSuccessOption,
  }) = _AddNewMemberState;
  factory AddNewMemberState.initial() => AddNewMemberState(
        locationTextField: InputEmptyOrNot(''),
        teamNameTextField: InputEmptyOrNot(''),
        showErrorMessages: false,
        isSubmitting: false,
        failureOrSuccessOption: none(),
        selectedCountryFlag: "🇨🇦",
        mobileNumber: MobileNumber(''),
        emailAddress: EmailAddress(''),
        selectedCountryCode: '1',
      );
}
