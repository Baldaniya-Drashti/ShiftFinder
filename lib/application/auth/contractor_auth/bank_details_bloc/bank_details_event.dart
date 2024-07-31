part of 'bank_details_bloc.dart';

@freezed
class BankDetailsEvent with _$BankDetailsEvent {
  const factory BankDetailsEvent.bankNameChanged(String bankName) =
      BankNameChanged;
  const factory BankDetailsEvent.accountHolderNameChanged(String holderName) =
      AccountHolderNameChanged;
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
  const factory BankDetailsEvent.submitBtnPressed() = SubmitBtnPressed;
}
