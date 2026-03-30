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
    required EmployerProposalDto data,
    required bool loading,
  }) = _CounterProposalDetailState;

  factory CounterProposalDetailState.initial() => CounterProposalDetailState(
    loading: false,
      rateHour: Rate(""),
        data: EmployerProposalDto(),
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
