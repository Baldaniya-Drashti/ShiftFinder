part of 'post_shift_bloc.dart';

@freezed
class PostShiftEvent with _$PostShiftEvent {
  /// change shift type
  const factory PostShiftEvent.changeShiftType(
    String shiftType, {
    required int postId,
    required PostShiftDTO? post,
    required HealthcarePostDTO? updateShift,
    bool? fromSaveTemplate,
  }) = ChangeShiftType;

  /// Single Shift
  const factory PostShiftEvent.getBreakAllownceListApi(
      HealthcarePostDTO? updateShift,
      {bool? fromSaveTemplate}) = GetBreakAllownceListApi;

  const factory PostShiftEvent.singleShiftDateChangedEvent(
      String selectedDate) = SingleShiftDateChangedEvent;

  const factory PostShiftEvent.startHourChanged(String hour) = StartHourChanged;

  const factory PostShiftEvent.startMinuteChanged(String minute) =
      StartMinuteChanged;

  const factory PostShiftEvent.endHourChanged(String hour) = EndHourChanged;

  const factory PostShiftEvent.endMinuteChanged(String minute) =
      EndMinuteChanged;

  const factory PostShiftEvent.unpaidBreakChanged(String breakTime) =
      UnpaidBreakChanged;

  const factory PostShiftEvent.totalPayableHoursChanged() =
      TotalPayableHoursChanged;

  const factory PostShiftEvent.commuteAllownceChanged(String selectedValue) =
      CommuteAllownceChanged;

  const factory PostShiftEvent.commuteHoursChanged(String selectedValue) =
      CommuteHoursChanged;

  const factory PostShiftEvent.commuteRateChanged(String selectedValue) =
      CommuteRateChanged;

  const factory PostShiftEvent.accomdationAllownceChanged(
      String selectedValue) = AccomdationAllownceChanged;

  const factory PostShiftEvent.accomdationHoursChanged(String selectedValue) =
      AccomdationHoursChanged;

  const factory PostShiftEvent.accomdationRateChanged(String selectedValue) =
      AccomdationRateChanged;

  const factory PostShiftEvent.singleShiftNotesChanged(String note) =
      SingleShiftNotes;

  const factory PostShiftEvent.checkIsMoreVancancy(bool isMoreVacancy) =
      CheckIsMoreVancancy;

  const factory PostShiftEvent.addVacancyChanged(String vacancy) =
      AddVacancyChanged;

  const factory PostShiftEvent.singleShiftSubmitted(
      BuildContext context, bool fromSaveTemplate) = SingleShiftSubmitted;

  /// For recurring, template,share with teams

  const factory PostShiftEvent.getTeamsListEvent(
      {required PostShiftDTO post,
      required HealthcarePostDTO? updateShift}) = GetTeamsList;

  const factory PostShiftEvent.recurringCheck(bool isCheck) = RecurringCheck;

  const factory PostShiftEvent.shareWithTeamsCheck(bool isCheck) =
      ShareWithTeamsCheck;

  const factory PostShiftEvent.saveAsTemplateCheck(bool isCheck) =
      SaveAsTemplateCheck;

  const factory PostShiftEvent.disclaimerChanged(String note) =
      DisclaimerChanged;

  const factory PostShiftEvent.recurringStartDateChanged(String selectedDate) =
      RecurringStartDateChanged;

  const factory PostShiftEvent.recurrenceModeChanged(
      String mode, BuildContext context) = RecurrenceModeChanged;

  const factory PostShiftEvent.recurrenceWeeksChanged(SkillDTO day) =
      RecurrenceWeeksChanged;

  const factory PostShiftEvent.recurringEndDateChanged(String selectedDate) =
      RecurringEndDateChanged;

  const factory PostShiftEvent.selectTeamEvent(TeamDTO team) = SelectTeamEvent;

  const factory PostShiftEvent.recurringButtonEvent(
          BuildContext context, int postShiftId, bool fromSaveTemplate) =
      RecurringButtonEvent;

  /// Multi Shift
  const factory PostShiftEvent.checkIsIndividualPost(bool isIndividualPost) =
      CheckIsIndividualPost;

  const factory PostShiftEvent.multiDateSelectionChanged(
      List<DateTime> selectedDates) = multiDateSelectionChanged;

  const factory PostShiftEvent.multidateContinueButtonPressed(
      {required bool fromSaveTemplate}) = MultidateContinueButtonPressed;

  const factory PostShiftEvent.multiDateSameDiffTypeChanged(int selectedType) =
      MultiDateSameDiffTypeChanged;

  const factory PostShiftEvent.unpaidBreakListChanged(
      String breakTime, int index, String date) = UnpaidBreakListChanged;

  const factory PostShiftEvent.payableHourListChanged() =
      PayableHourListChanged;

  const factory PostShiftEvent.startHourListChanged(
      String hour, int index, String date) = StartHourListChanged;

  const factory PostShiftEvent.startMinuteListChanged(
      String minute, int index, String date) = StartMinuteListChanged;

  const factory PostShiftEvent.endHourListChanged(
      String hour, int index, String date) = EndHourListChanged;

  const factory PostShiftEvent.endMinuteListChanged(
      String minute, int index, String date) = EndMinuteListChanged;

  const factory PostShiftEvent.differentTimeShiftSubmitted(
      MultiShiftDTO shiftDetail,
      BuildContext context,
      bool fromSaveTemplate) = DifferentTimeShiftSubmitted;

  const factory PostShiftEvent.initMultiDifferentDateEvent(
    List<DateTimeDTO> list, {
    required PostShiftDTO post,
    required HealthcarePostDTO? updateShift,
    required bool? fromSaveTemplate,
  }) = InitMultiDifferentDateEvent;

  const factory PostShiftEvent.backEvent() = BackEvent;

  const factory PostShiftEvent.sameTimeShiftSubmitted(
      BuildContext context, bool fromSaveTemplate) = SameTimeShiftSubmitted;

  const factory PostShiftEvent.assitantOnSiteCheck(bool isCheck) =
      AssitantOnSiteCheck;

  const factory PostShiftEvent.technicianOnSiteCheck(bool isCheck) =
      TechnicianOnSiteCheck;

  /// Post the Shift
  const factory PostShiftEvent.postTheShiftEvent(
          int postId, PostShiftDTO? updatedPost, bool fromSaveTemp) =
      PostTheShiftEvent;
  const factory PostShiftEvent.scriptVolumeChanged(String scriptVolume) =
      ScriptVolumeChanged;
}
