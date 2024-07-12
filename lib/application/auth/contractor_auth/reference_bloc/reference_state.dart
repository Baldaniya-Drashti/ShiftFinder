part of 'reference_bloc.dart';

@freezed
class ReferenceState with _$ReferenceState {
  const factory ReferenceState({
    required int selectedTab,
    // FOR PROFESSIONAL
    required InputEmptyOrNot jobPosition,
    required InputEmptyOrNot organization,
    required InputEmptyOrNot referrer,
    required EmailAddress referrerEmail,
    required MobileNumber referrerPhoneNo,
    required InputEmptyOrNot jobLocation,
    required InputEmptyOrNot unitDepartment,
    required InputEmptyOrNot startDate,
    required InputEmptyOrNot endDate,
    required String selectedCountrycode,
    required String selectedCountryFlag,

    // FOR PERSONAL
    required InputEmptyOrNot contactPerson,
    required EmailAddress personalEmail,
    required MobileNumber personalPhoneNo,
    required InputEmptyOrNot profession,
    required String personalCountrycode,
    required String personalCountryFlag,

    /// PROFESSIONAL SUBMIT
    required bool isProfessionalSubmitting,
    required bool showProfessionalErrorMessage,
    required Option<Either<AuthFailure, String>>
        authFailureOrSuccessOptionProfessional,

    /// PERSONAL SUBMIT
    required bool isPersonalSubmitting,
    required bool showPersonalErrorMessage,
    required Option<Either<AuthFailure, String>>
        authFailureOrSuccessOptionPersonal,
  }) = _ReferenceState;
  factory ReferenceState.initial() => ReferenceState(
        selectedTab: 0,
        // FOR PROFESSIONAL
        jobPosition: InputEmptyOrNot(""),
        organization: InputEmptyOrNot(""),
        referrer: InputEmptyOrNot(""),
        referrerEmail: EmailAddress(""),
        referrerPhoneNo: MobileNumber(""),
        jobLocation: InputEmptyOrNot(""),
        unitDepartment: InputEmptyOrNot(""),
        startDate: InputEmptyOrNot(""),
        endDate: InputEmptyOrNot(""),
        selectedCountrycode: "1",
        selectedCountryFlag: "🇨🇦",

        // FOR PERSONAL
        personalEmail: EmailAddress(""),
        personalPhoneNo: MobileNumber(""),
        contactPerson: InputEmptyOrNot(""),
        profession: InputEmptyOrNot(""),
        personalCountrycode: "1",
        personalCountryFlag: "🇨🇦",

        /// PROFESSIONAL SUBMIT
        isProfessionalSubmitting: false,
        showProfessionalErrorMessage: false,
        authFailureOrSuccessOptionProfessional: none(),

        /// PERSONAL SUBMIT
        isPersonalSubmitting: false,
        showPersonalErrorMessage: false,
        authFailureOrSuccessOptionPersonal: none(),
      );
}
