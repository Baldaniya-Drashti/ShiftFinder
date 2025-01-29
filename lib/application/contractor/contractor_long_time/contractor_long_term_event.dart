part of 'contractor_long_term_bloc.dart';

@freezed
class ContractorLongTermEvent with _$ContractorLongTermEvent {
  factory ContractorLongTermEvent.fetchOpenPositionList({
    required bool refresh,
  }) = FetchOpenPositionList;

  factory ContractorLongTermEvent.fetchUpcomingPositionList({
    required bool refresh,
  }) = FetchUpcomingPositionList;

  factory ContractorLongTermEvent.fetchAppliedPositionList({
    required bool refresh,
  }) = FetchAppliedPositionList;

  factory ContractorLongTermEvent.applyOpenPosition({
    required BuildContext context,
    required int id
  }) = ApplyOpenPosition;
}
