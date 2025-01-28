part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    required Account? currentUser,
    required bool isSubmitting,
    required bool isLoading,
    required bool showErrorMessages,
    // required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,

    required String selectImage,
    required Username firstName,
    required Lastname lastName,
    required InputEmptyOrNot companyName,
    required MobileNumber phoneNumber,
    required String enteredPhoneNo,
    required EmailAddress email,
    required String association,
    required String companyDescription,
    required String selectedCountrycode,
    required String selectedCountryFlag,
  }) = _EditProfileState;

  factory EditProfileState.initial() => EditProfileState(
        selectedCountrycode: "1",
        selectedCountryFlag: "🇨🇦",
        currentUser: null,
        isLoading: false,
        firstName: Username(""),
        lastName: Lastname(""),
        isSubmitting: false,
        showErrorMessages: false,
        // authFailureOrSuccessOption: none(),
        selectImage: "",
        companyName: InputEmptyOrNot(""),
        phoneNumber: MobileNumber(""),
        email: EmailAddress(""),
        association: "",
        companyDescription: "",
        enteredPhoneNo: "",
      );
}
