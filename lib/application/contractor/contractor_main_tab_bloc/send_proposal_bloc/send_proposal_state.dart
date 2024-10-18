part of 'send_proposal_bloc.dart';

@freezed
class SendProposalState with _$SendProposalState {
  factory SendProposalState({
    required HealthcarePostDTO shift,
    required InputEmptyOrNot startHour,
    required InputEmptyOrNot startMinute,
    required InputEmptyOrNot endHour,
    required InputEmptyOrNot endMinute,
    required InputEmptyOrNot unpaidBreak,
    required String totalPaybleHours,
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
    required List<DateTimeDTO> unAvailableDates,
  }) = _SendProposalState;
  factory SendProposalState.initial() => SendProposalState(
        selectedTab: 0,
        startHour: InputEmptyOrNot(""),
        startMinute: InputEmptyOrNot("00 Min"),
        endHour: InputEmptyOrNot(""),
        endMinute: InputEmptyOrNot("00 Min"),
        unpaidBreak: InputEmptyOrNot(""),
        totalPaybleHours: "00h 00min",
        rateHour: Rate(""),
        commuteHour: InputEmptyOrNot(""),
        commuteRate: Rate(""),
        accomdationHour: InputEmptyOrNot(""),
        accomdationRate: Rate(""),
        accomdationHoursList: [],
        multiDates: [],
        unAvailableDates: [],
        isLoading: false,
        isSubmitting: false,
        showErrorMessages: false,
        shift: HealthcarePostDTO(),
        failureOrSuccessOption: none(),
      );
}
