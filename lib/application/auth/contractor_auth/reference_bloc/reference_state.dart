part of 'reference_bloc.dart';

@freezed
class ReferenceState with _$ReferenceState {
  const factory ReferenceState({
    required List<ReferenceDTO> referenceList,
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
    required Option<Either<AuthFailure, Account>> skipFailureOrSuccessOption,

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
    required Option<Either<AccountFailure, Account>>
        authFailureOrSuccessOptionProfessional,

    /// PERSONAL SUBMIT
    required bool isPersonalSubmitting,
    required bool showPersonalErrorMessage,
    required Option<Either<AccountFailure, Account>>
        authFailureOrSuccessOptionPersonal,
    required bool isLoading,
    required Option<Either<AccountFailure, Account>>
        failureOrSuccessOptionPersonal,
  }) = _ReferenceState;
  factory ReferenceState.initial() => ReferenceState(
        referenceList: [],
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

        isLoading: false,
        failureOrSuccessOptionPersonal: none(),
        skipFailureOrSuccessOption: none(),
      );
}
