part of 'bank_details_bloc.dart';

@freezed
class BankDetailsEvent with _$BankDetailsEvent {
  const factory BankDetailsEvent.bankNameChanged(String bankName) =
      BankNameChanged;
  const factory BankDetailsEvent.accountTypeChanged(String accountType) =
      AccountTypeChanged;
  const factory BankDetailsEvent.accountHolderNameChanged(String holderName) =
      AccountHolderNameChanged;
  const factory BankDetailsEvent.jobTitleChanged(String jobTitle) =
      JobTitleChanged;
  const factory BankDetailsEvent.firstNameChanged(String firstName) =
      FirstNameChanged;
  const factory BankDetailsEvent.lastNameChanged(String lastName) =
      LastNameChanged;
  const factory BankDetailsEvent.selectCountryCode(
          String countryCode, String countryFlag, String countryCodeName) =
      SelectCountryCode;
  const factory BankDetailsEvent.dobChanged(String dob) = DobChanged;
  const factory BankDetailsEvent.cityChanged(String city) = CityChanged;
  const factory BankDetailsEvent.stateChanged(String state) = StateChanged;
  const factory BankDetailsEvent.postalCodeChanged(String postalCode) =
      PostalCodeChanged;
  const factory BankDetailsEvent.phoneNumberChanged(String phoneNumber) =
      PhoneNumberChanged;
  const factory BankDetailsEvent.transitNumberChanged(String transitNumber) =
      TransitNumberChnaged;
  const factory BankDetailsEvent.instituteNumberChanged(
      String instituteNumber) = InstituteNumberChanged;
  const factory BankDetailsEvent.accountNumberChanged(String accountNumber) =
      AccountNumberChanged;
  const factory BankDetailsEvent.bankAddressChanged(String bankAddress) =
      BankAddressChanged;
  const factory BankDetailsEvent.checkTermsCondition(bool isCheck) =
      CheckTermsCondition;
  const factory BankDetailsEvent.submitBtnPressed(BuildContext context) =
      SubmitBtnPressed;

  const factory BankDetailsEvent.locationSelectedFromSearchList(
      Predictions selectedLocation) = LocationSelectedFromSearchList;

  const factory BankDetailsEvent.getBankDetails() = GetBankDetails;
  const factory BankDetailsEvent.getCurrentBank(
      {BankDTO? currentBank, @Default(false) bool isUpdate}) = GetCurrentBank;
}
