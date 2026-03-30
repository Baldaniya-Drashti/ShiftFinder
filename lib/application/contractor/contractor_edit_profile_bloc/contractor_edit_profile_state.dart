part of 'contractor_edit_profile_bloc.dart';

@freezed
class ContractorEditProfileState with _$ContractorEditProfileState {
  const factory ContractorEditProfileState({
    required Account? currentUser,
    required Username firstName,
    required Lastname lastName,
    required FocusNode firstNameFocusNode,
    required bool isSubmitting,
    required bool isLoading,
    required bool isCheck,
    required bool showErrorMessages,

    /// >>>>>>>>>>>>>>>>>>> FOR REGISTER PROFILE PAGE <<<<<<<<<<<<<<<<<<<<

    required String selectImage,
    required InputEmptyOrNot companyName,
    required MobileNumber phoneNumber,
    required String enteredPhoneNo,
    required String enteredPassword,
    required EmailAddress email,
    required InputEmptyOrNot locationAddress,
    required List<Predictions> searchLocationList,
    required Predictions selectedLocationPrediction,
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

    /// EDIT PHONE OR EMAIL VIEW
    required EmailAddress editedEmail,
    required MobileNumber editedPhone,
    required String editedCountrycode,
    required String editedCountryFlag,
    required bool isEditing,
    required bool showEditedErrorMessage,
    required PlaceDetailDTO selectedAddress,
  }) = _ContractorEditProfileState;

  factory ContractorEditProfileState.initial() => ContractorEditProfileState(
        currentUser: null,
        isLoading: false,
        firstNameFocusNode: FocusNode(),
        firstName: Username(""),
        lastName: Lastname(""),
        isSubmitting: false,
        showErrorMessages: false,
        isCheck: false,

        /// >>>>>>>>>>>>>>>>>>> FOR REGISTER PROFILE PAGE <<<<<<<<<<<<<<<<<<<<
        selectImage: "",
        companyName: InputEmptyOrNot(""),
        phoneNumber: MobileNumber(""),
        email: EmailAddress(""),
        locationAddress: InputEmptyOrNot(""),
        searchLocationList: [],
        password: Password(""),
        confirmPassword: ConfirmPassword("", ""),
        association: "",
        referralCode: "",
        companyDescription: "",
        selectedCountrycode: "1",
        selectedCountryFlag: "🇨🇦",
        isNewPassObscure: true,
        isConfirmPassObscure: true,
        enteredPassword: "",
        enteredPhoneNo: "",
        selectedAddress: PlaceDetailDTO(),
        selectedLocationPrediction: Predictions(),

        /// OTP VIEW
        enteredOTP: OTPText(''),
        secondsRemaining: 0,
        showOtpErrorMessages: false,

        /// EDIT PHONE OR EMAIL VIEW
        editedPhone: MobileNumber(""),
        editedEmail: EmailAddress(""),
        editedCountrycode: "1",
        editedCountryFlag: "🇨🇦",
        isEditing: false,
        showEditedErrorMessage: false,
      );
}
