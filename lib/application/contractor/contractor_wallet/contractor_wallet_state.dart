part of 'contractor_wallet_bloc.dart';

@freezed
class ContractorWalletState with _$ContractorWalletState {
  const factory ContractorWalletState({
    @Default(WalletDropdownModel(id: 1, label: "All Transactions")) final WalletDropdownModel initialWalletFilter,
  }) = _ContractorWalletState;
}
