part of 'agreed_proposal_bloc.dart';

@freezed
class AgreedProposalEvent with _$AgreedProposalEvent {
  const factory AgreedProposalEvent.getProposalDataEvent(
    BuildContext context, {
    required int userId,
    required int postId,
  }) = GetProposalDataEvent;
}
