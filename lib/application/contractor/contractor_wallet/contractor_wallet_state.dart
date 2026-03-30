part of 'contractor_wallet_bloc.dart';

@freezed
class ContractorWalletState with _$ContractorWalletState {
  factory ContractorWalletState({
    required GetBalanceDTO? currentBalance,
    required WalletDropdownModel initialWalletFilter,
    required List<DateTime> selectedDateTime,
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required List<ContractorWalletDTO> walletList,
    required Rate withdrawAmount,
  }) = _ContractorWalletState;
  factory ContractorWalletState.initial() => ContractorWalletState(
        initialWalletFilter: CommonList.walletList[0],
        selectedDateTime: [],
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        currentBalance: null,
        walletList: [],
        withdrawAmount: Rate(""),
      );
}
