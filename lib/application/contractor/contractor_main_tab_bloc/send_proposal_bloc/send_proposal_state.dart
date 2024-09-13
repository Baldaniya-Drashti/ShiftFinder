part of 'send_proposal_bloc.dart';

@freezed
class SendProposalState with _$SendProposalState {
  factory SendProposalState({
    required int selectedTab,
  }) = _SendProposalState;
  factory SendProposalState.initial() => SendProposalState(
        selectedTab: 0,
      );
}
