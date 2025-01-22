part of 'contractor_wallet_bloc.dart';

@freezed
class ContractorWalletEvent with _$ContractorWalletEvent {
  const factory ContractorWalletEvent.getAvailableBalance() =
      GetAvailableBalance;
  const factory ContractorWalletEvent.onDateSelected(
    BuildContext context, {
    required List<DateTime> dates,
  }) = _OnDateSelected;
  const factory ContractorWalletEvent.onFilterChanged(BuildContext context,
      {required WalletDropdownModel value}) = OnFilterChanged;

  const factory ContractorWalletEvent.getWalletList(
      bool isRefresh, BuildContext context) = GetWalletList;
}
