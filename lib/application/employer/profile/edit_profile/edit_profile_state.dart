part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  factory EditProfileState({
    required String selectedImage,
    required Username firstName,
    required Lastname lastName,
    required InputEmptyOrNot companyName,
    required String selectedCountryFlag,
    required String selectedCountrycode,
    required String companyDescription,
    required MobileNumber phoneNumber,
    required bool showErrorMessages,
    required String association,
  }) = _EditProfileState;

  factory EditProfileState.initial() => EditProfileState(
        selectedImage: '',
        firstName: Username(""),
        lastName: Lastname(""),
        association: "",
        companyName: InputEmptyOrNot(""),
        phoneNumber: MobileNumber(""),
        selectedCountryFlag: '',
        selectedCountrycode: '',
        companyDescription: '',
        showErrorMessages: false,
      );
}
