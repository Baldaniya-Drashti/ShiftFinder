part of 'contractor_wallet_bloc.dart';

@freezed
class ContractorWalletEvent with _$ContractorWalletEvent {
  const factory ContractorWalletEvent.onFilterChanged({required WalletDropdownModel value }) = OnFilterChanged;
}

