part of 'counter_proposal_detail_bloc.dart';

@freezed
class CounterProposalDetailState with _$CounterProposalDetailState {
  const factory CounterProposalDetailState({
    required bool postDataLoading,
    required InputEmptyOrNot selectedCommuteAllownce,
    required InputEmptyOrNot commuteHour,
    required Rate commuteRate,
    required InputEmptyOrNot selectedAccomdationAllownce,
    required InputEmptyOrNot accomdationHour,
    required Rate accomdationRate,
    required List<SkillDTO> accomdationHoursList,
    required bool showErrorMessages,
    required Rate rateHour,
    required ProposalDetailDto data,
  }) = _CounterProposalDetailState;

  factory CounterProposalDetailState.initial() => CounterProposalDetailState(
      rateHour: Rate(""),
        data: ProposalDetailDto(),
        postDataLoading: false,
        selectedCommuteAllownce: InputEmptyOrNot(""),
        commuteHour: InputEmptyOrNot(""),
        commuteRate: Rate(""),
        selectedAccomdationAllownce: InputEmptyOrNot(""),
        accomdationHour: InputEmptyOrNot(""),
        accomdationRate: Rate(""),
        accomdationHoursList: [],
        showErrorMessages: false,
      );
}
