part of 'contractor_full_time_position_bloc.dart';

@freezed
class ContractorFullTimePositionEvent with _$ContractorFullTimePositionEvent {
  factory ContractorFullTimePositionEvent.fetchOpenPositionList({
    required bool refresh,
  }) = FetchOpenPositionList;

  factory ContractorFullTimePositionEvent.fetchAppliedPositionList({
    required bool refresh,
  }) = FetchAppliedPositionList;

}
