part of 'total_proposal_bloc.dart';

@freezed
class TotalProposalEvent with _$TotalProposalEvent {
  const factory TotalProposalEvent.getTotalProposalList({
    required int id,
    required bool isRefresh,
  }) = _GetTotalProposalList;
}
