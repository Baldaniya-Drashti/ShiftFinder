part of 'post_shift_bloc.dart';

@freezed
class PostShiftEvent with _$PostShiftEvent {
  /// change shift type
  const factory PostShiftEvent.changeShiftType(String shiftType) =
      ChangeShiftType;

  /// Single Shift
  const factory PostShiftEvent.getBreakAllownceListApi() =
      GetBreakAllownceListApi;
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

  const factory PostShiftEvent.continueBtnPressed() = ContinueBtnPressed;
}
