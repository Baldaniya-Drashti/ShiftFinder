part of 'bank_details_bloc.dart';

@freezed
class BankDetailsState with _$BankDetailsState {
  const factory BankDetailsState({
    required Username accountHolderName,
    required InputEmptyOrNot jobTitle,
    required InputEmptyOrNot accountType,
    required Username firstName,
    required Username lastName,
    required InputEmptyOrNot dateOfBirth,
    required InputEmptyOrNot city,
    required InputEmptyOrNot stateName,
    required InputEmptyOrNot postalCode,
    required MobileNumber phoneNumber,
    required String selectedCountrycode,
    required String selectedCountryFlag,
    required InputEmptyOrNot bankName,
    required InputEmptyOrNot transitNumber,
    required InputEmptyOrNot bankInstitutionNumber,
    required InputEmptyOrNot accountNumber,
    required InputEmptyOrNot bankAddress,
    required bool isCheck,
    required bool showErrorMessages,
    required bool isSubmitting,
    required Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
  }) = _BankDetailsState;

  factory BankDetailsState.initial() => BankDetailsState(
        accountHolderName: Username(""),
        jobTitle: InputEmptyOrNot(""),
        accountType: InputEmptyOrNot(""),
        firstName: Username(""),
        lastName: Username(""),
        phoneNumber: MobileNumber(""),
        selectedCountrycode: "1",
        selectedCountryFlag: "🇨🇦",
        dateOfBirth: InputEmptyOrNot(""),
        city: InputEmptyOrNot(""),
        stateName: InputEmptyOrNot(""),
        postalCode: InputEmptyOrNot(""),
        transitNumber: InputEmptyOrNot(""),
        accountNumber: InputEmptyOrNot(""),
        bankName: InputEmptyOrNot(""),
        bankAddress: InputEmptyOrNot(""),
        bankInstitutionNumber: InputEmptyOrNot(""),
        isCheck: false,
        isSubmitting: false,
        showErrorMessages: false,
        authFailureOrSuccessOption: none(),
      );
}
