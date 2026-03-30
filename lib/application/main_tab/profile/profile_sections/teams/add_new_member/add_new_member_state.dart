part of 'add_new_member_bloc.dart';

@freezed
class AddNewMemberState with _$AddNewMemberState {
  factory AddNewMemberState({
    required InputEmptyOrNot jobPositionTextField,
    required InputEmptyOrNot teamNameTextField,
    required MobileNumber mobileNumber,
    required EmailAddress emailAddress,
    required bool showErrorMessages,
    required String selectedCountryCode,
    required String selectedCountryFlag,
    required String teamID,
    required bool isSubmitting,
    required bool isEdit,
    required Option<Either<MainFailure, String>> failureOrSuccessOption,
  }) = _AddNewMemberState;
  factory AddNewMemberState.initial() => AddNewMemberState(
        jobPositionTextField: InputEmptyOrNot(''),
        teamNameTextField: InputEmptyOrNot(''),
        showErrorMessages: false,
        isSubmitting: false,
        failureOrSuccessOption: none(),
        selectedCountryFlag: "🇨🇦",
        mobileNumber: MobileNumber(''),
        emailAddress: EmailAddress(''),
        selectedCountryCode: '+1',
        isEdit: false,
        teamID: '',
      );
}
