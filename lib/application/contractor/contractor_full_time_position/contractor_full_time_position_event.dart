part of 'contractor_full_time_position_bloc.dart';

@freezed
class ContractorFullTimePositionEvent with _$ContractorFullTimePositionEvent {
  factory ContractorFullTimePositionEvent.fetchOpenPositionList({
    required bool refresh,
  }) = FetchOpenPositionList;

  factory ContractorFullTimePositionEvent.fetchAppliedPositionList({
    required bool refresh,
  }) = FetchAppliedPositionList;
  factory ContractorFullTimePositionEvent.confirmRejectOffer({
    required BuildContext context,
    required int id,
    required int urgent_action
  }) = ConfirmRejectOffer; factory ContractorFullTimePositionEvent.applyOpenPosition({
    required BuildContext context,
    required int id,
  }) = ApplyOpenPosition;
}
