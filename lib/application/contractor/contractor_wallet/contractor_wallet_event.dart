part of 'contractor_wallet_bloc.dart';

@freezed
class ContractorWalletEvent with _$ContractorWalletEvent {
  const factory ContractorWalletEvent.onDateSelected({
    required List<DateTime> dates,
  }) = _OnDateSelected;
  const factory ContractorWalletEvent.onFilterChanged(
      {required WalletDropdownModel value}) = OnFilterChanged;
}
