part of 'contractor_wallet_bloc.dart';

// @freezed
// class ContractorWalletState with _$ContractorWalletState {
//   const factory ContractorWalletState({
//     @Default(WalletDropdownModel(id: 1, label: "All Transactions")) final WalletDropdownModel initialWalletFilter,
//   }) = _ContractorWalletState;
// }

@freezed
class ContractorWalletState with _$ContractorWalletState {
  factory ContractorWalletState({
    required WalletDropdownModel initialWalletFilter,
    required List<DateTime> selectedDateTime,
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
  }) = _ContractorWalletState;
  factory ContractorWalletState.initial() => ContractorWalletState(
        initialWalletFilter: CommonList.walletList[0],
        selectedDateTime: [],
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
      );
}
