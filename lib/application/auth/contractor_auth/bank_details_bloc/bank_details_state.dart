part of 'bank_details_bloc.dart';

@freezed
class BankDetailsState with _$BankDetailsState {
  const factory BankDetailsState({
    required Username accountHolderName,
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
