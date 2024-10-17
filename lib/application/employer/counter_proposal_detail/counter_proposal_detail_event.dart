part of 'counter_proposal_detail_bloc.dart';

@freezed
class CounterProposalDetailEvent with _$CounterProposalDetailEvent {
  const factory CounterProposalDetailEvent.sendCounterProposal({required BuildContext context}) = ProposalAcceptReject;


  const factory CounterProposalDetailEvent.commuteRateChanged(String selectedValue) = CommuteRateChanged;



  const factory CounterProposalDetailEvent.accomdationRateChanged(String selectedValue) = AccomdationRateChanged;

  const factory CounterProposalDetailEvent.getHoursList() = GetHoursList;

  const factory CounterProposalDetailEvent.addProposalData({required ProposalDetailDto data}) = AddProposalData;

  const factory CounterProposalDetailEvent.accomdationHourChanged(String rate) = AccomdationHourChanged;

  const factory CounterProposalDetailEvent.commuteHourChanged(String rate) = CommuteHourChanged;
  const factory CounterProposalDetailEvent.rateHourChanged(String rate) =RateHourChanged;
}
