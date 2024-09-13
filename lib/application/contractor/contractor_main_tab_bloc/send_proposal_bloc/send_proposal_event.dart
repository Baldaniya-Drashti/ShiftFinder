part of 'send_proposal_bloc.dart';

@freezed
class SendProposalEvent with _$SendProposalEvent {
  const factory SendProposalEvent.tabChangeEvent(int tabIndex) = TabChangeEvent;
}
