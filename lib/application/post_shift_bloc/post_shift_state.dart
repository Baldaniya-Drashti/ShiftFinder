// ignore_for_file: prefer_const_literals_to_create_immutables

part of 'post_shift_bloc.dart';

@freezed
class PostShiftState with _$PostShiftState {
  const factory PostShiftState({
    /// Change hift Type(Single, Multi,Long-Term)
    required int shiftType,
    required bool isLoading,

    /// Single Shift
    required InputEmptyOrNot signleShiftDate,
    required InputEmptyOrNot startHour,
    required InputEmptyOrNot startMinute,
    required InputEmptyOrNot endHour,
    required InputEmptyOrNot endMinute,
    required List<SkillDTO> breakList,
    required List<SkillDTO> accomdationHoursList,
    required InputEmptyOrNot unpaidBreak,
    required String totalPaybleHours,
    required InputEmptyOrNot selectedCommuteAllownce,
    required InputEmptyOrNot commuteHour,
    required InputEmptyOrNot commuteRate,
    required InputEmptyOrNot selectedAccomdationAllownce,
    required InputEmptyOrNot accomdationHour,
    required InputEmptyOrNot accomdationRate,
    required String singleShiftNote,
    required bool isMoreVacancy,
    required InputEmptyOrNot selectedVacancy,
    required bool singleShiftErrorMessages,
    required Option<Either<AuthFailure, String>>
        singleShiftFailureOrSuccessOption,

    /// For recurring,sahre with teams, save as template
    required bool isToBeRecurring,
    required bool isShareWithTeams,
    required bool isSaveAsTemplate,
    required String disclaimerNote,
    required InputEmptyOrNot recurringStartDate,
    required InputEmptyOrNot recurringEndDate,
    required ListInputEmptyOrNot<SkillDTO> recurrenceWeekList,
    required ListInputEmptyOrNot<SkillDTO> selectedTeamList,
    required InputEmptyOrNot recurrenceMode,
    required bool isNeverEndDate,
    required bool recurringErrorMessage,
    required Option<Either<AuthFailure, String>>
        recurringFailureOrSuccessOption,
  }) = _PostShiftState;

  factory PostShiftState.initial() => PostShiftState(
        /// Change shift Type(Single, Multi,Long-Term)
        shiftType: -1,
        isLoading: false,

        /// Single Shift
        signleShiftDate: InputEmptyOrNot(""),
        // startTime: InputEmptyOrNot(""),
        startHour: InputEmptyOrNot(""),
        startMinute: InputEmptyOrNot(""),
        endHour: InputEmptyOrNot(""),
        endMinute: InputEmptyOrNot(""),
        totalPaybleHours: "00h 00min",
        breakList: [],
        accomdationHoursList: [],
        unpaidBreak: InputEmptyOrNot(""),
        selectedCommuteAllownce: InputEmptyOrNot(""),
        commuteHour: InputEmptyOrNot(""),
        commuteRate: InputEmptyOrNot(""),
        selectedAccomdationAllownce: InputEmptyOrNot(""),
        accomdationHour: InputEmptyOrNot(""),
        accomdationRate: InputEmptyOrNot(""),
        selectedVacancy: InputEmptyOrNot(""),
        singleShiftNote: "",
        isMoreVacancy: false,
        singleShiftErrorMessages: false,
        singleShiftFailureOrSuccessOption: none(),

        /// For recurring,share with teams, save as template
        isSaveAsTemplate: false,
        isShareWithTeams: false,
        isToBeRecurring: false,
        disclaimerNote: "",
        recurringStartDate: InputEmptyOrNot(""),
        recurringEndDate: InputEmptyOrNot(""),
        recurrenceMode: InputEmptyOrNot(""),
        recurrenceWeekList: ListInputEmptyOrNot([]),
        selectedTeamList: ListInputEmptyOrNot([]),
        isNeverEndDate: false,

        recurringErrorMessage: false,
        recurringFailureOrSuccessOption: none(),
      );
}
