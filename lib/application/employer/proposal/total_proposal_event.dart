part of 'total_proposal_bloc.dart';

@freezed
class TotalProposalEvent with _$TotalProposalEvent {
  const factory TotalProposalEvent.getTotalProposalList({
    required int id,
    required bool isRefresh,
    required BuildContext context,
  }) = GetTotalProposalList;


  const factory TotalProposalEvent.startRevokingTimer({
    required Duration duration,
    required int postId,
    required int revokeTime
  }) = StartRevokingTimer;

  const factory TotalProposalEvent.onRevoke({required int postId, required int userId, required BuildContext context}) = OnRevoke;

}
