part of 'send_proposal_bloc.dart';

@freezed
class SendProposalState with _$SendProposalState {
  factory SendProposalState({
    required HealthcarePostDTO shift,
    required InputEmptyOrNot startHour,
    required InputEmptyOrNot startMinute,
    required InputEmptyOrNot endHour,
    required InputEmptyOrNot endMinute,
    required InputEmptyOrNot commuteHour,
    required Rate commuteRate,
    required InputEmptyOrNot accomdationHour,
    required Rate accomdationRate,
    required List<SkillDTO> accomdationHoursList,
    required Rate rateHour,
    required bool isLoading,
    required bool isSubmitting,
    required bool showErrorMessages,
    required Option<Either<MainFailure, HealthcarePostDTO>>
        failureOrSuccessOption,
    required int selectedTab,
    required List<DateTimeDTO> multiDates,
  }) = _SendProposalState;
  factory SendProposalState.initial() => SendProposalState(
        selectedTab: 0,
        startHour: InputEmptyOrNot(""),
        startMinute: InputEmptyOrNot("00 Min"),
        endHour: InputEmptyOrNot(""),
        endMinute: InputEmptyOrNot("00 Min"),
        rateHour: Rate(""),
        commuteHour: InputEmptyOrNot(""),
        commuteRate: Rate(""),
        accomdationHour: InputEmptyOrNot(""),
        accomdationRate: Rate(""),
        accomdationHoursList: [],
        multiDates: [],
        isLoading: false,
        isSubmitting: false,
        showErrorMessages: false,
        shift: HealthcarePostDTO(),
        failureOrSuccessOption: none(),
      );
}
