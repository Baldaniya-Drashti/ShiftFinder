// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

part of 'post_shift_bloc.dart';

@freezed
class PostShiftState with _$PostShiftState {
  const factory PostShiftState({
    /// Change hift Type(Single, Multi,Long-Term)
    required int shiftType,
    required int postId,
    required bool isLoading,
    required PostShiftDTO post,

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
    required Option<Either<MainFailure, HealthcarePostDTO>>
        singleShiftFailureOrSuccessOption,

    /// For recurring,sahre with teams, save as template
    required List<TeamDTO> teamList,
    required bool isToBeRecurring,
    required bool isShareWithTeams,
    required bool isSaveAsTemplate,
    required String disclaimerNote,
    required InputEmptyOrNot recurringStartDate,
    required InputEmptyOrNot recurringEndDate,
    required ListInputEmptyOrNot<SkillDTO> recurrenceWeekList,
    required ListInputEmptyOrNot<TeamDTO> selectedTeamList,
    required InputEmptyOrNot recurrenceMode,
    required bool recurringErrorMessage,
    required Option<Either<MainFailure, HealthcarePostDTO>>
        recurringFailureOrSuccessOption,

    /// Multi shift
    required bool isIndividualPost,
    required int selectedMultiShiftType,
    required ListInputEmptyOrNot<DateTime> selectedMultiDates,
    required List<String> startHourList,
    required List<String> startMinuteList,
    required List<String> endHourList,
    required List<String> endMinuteList,
    required List<DateTimeDTO> multiDateTimeList,
    required bool isDifferentDateDataValid,
    required Option<Either<AuthFailure, MultiShiftDTO>>
        differentDateFailureOrSuccessOption,

    /// Post the Shift
    required Option<Either<MainFailure, String>>
        postShiftFailureOrSuccessOption,
  }) = _PostShiftState;

  factory PostShiftState.initial() => PostShiftState(
        /// Change shift Type(Single, Multi,Long-Term)
        post: PostShiftDTO(),
        shiftType: -1,
        postId: -1,
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
        teamList: [],
        isSaveAsTemplate: false,
        isShareWithTeams: false,
        isToBeRecurring: false,
        disclaimerNote: "",
        recurringStartDate: InputEmptyOrNot(""),
        recurringEndDate: InputEmptyOrNot(""),
        recurrenceMode: InputEmptyOrNot(""),
        recurrenceWeekList: ListInputEmptyOrNot([]),
        selectedTeamList: ListInputEmptyOrNot([]),
        recurringErrorMessage: false,
        recurringFailureOrSuccessOption: none(),

        /// Multi Shift
        isIndividualPost: false,
        selectedMultiShiftType: 1,
        selectedMultiDates: ListInputEmptyOrNot([]),
        startHourList: [],
        startMinuteList: [],
        endHourList: [],
        endMinuteList: [],
        multiDateTimeList: [],
        isDifferentDateDataValid: false,
        differentDateFailureOrSuccessOption: none(),

        /// Post the shift
        postShiftFailureOrSuccessOption: none(),
      );
}
