part of 'proposal_detail_bloc.dart';

@freezed
class ProposalDetailEvent with _$ProposalDetailEvent {
  const factory ProposalDetailEvent.getProposalDetail({
    required int postId,
    required int userId,
    required BuildContext context,
  }) = GetProposalDetail;

  const factory ProposalDetailEvent.proposalAcceptReject({
    required int id,
    required int request,
    required BuildContext context,
  }) = ProposalAcceptReject;
  const factory ProposalDetailEvent.addConfirmDialogFlag(bool flag) =
      AddConfirmDialogFlag;
  const factory ProposalDetailEvent.getHoursList() = GetHoursList;
  const factory ProposalDetailEvent.checkConfirmAvailability(bool isCheck) =
      CheckConfirmAvailability;
  const factory ProposalDetailEvent.isCheckAvailability(BuildContext context) =
      IsCheckAvailability;
}
