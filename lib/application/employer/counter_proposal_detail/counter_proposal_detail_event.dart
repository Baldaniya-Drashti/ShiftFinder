part of 'counter_proposal_detail_bloc.dart';

@freezed
class CounterProposalDetailEvent with _$CounterProposalDetailEvent {
  const factory CounterProposalDetailEvent.sendCounterProposal({
    required int id,
    required int counterRateHour,
    required int commuteAllowanceType,
    required int accommodationAllowanceType,
    required int? counterCommuteAllowance,
    required int? counterAccommodationAllowance,
    required BuildContext context,
  }) = ProposalAcceptReject;

  const factory CounterProposalDetailEvent.commuteAllownceChanged(String selectedValue) = CommuteAllownceChanged;

  const factory CounterProposalDetailEvent.commuteHoursChanged(String selectedValue) = CommuteHoursChanged;

  const factory CounterProposalDetailEvent.commuteRateChanged(String selectedValue) = CommuteRateChanged;

  const factory CounterProposalDetailEvent.accomdationAllownceChanged(String selectedValue) = AccomdationAllownceChanged;

  const factory CounterProposalDetailEvent.accomdationHoursChanged(String selectedValue) = AccomdationHoursChanged;

  const factory CounterProposalDetailEvent.accomdationRateChanged(String selectedValue) = AccomdationRateChanged;
}
