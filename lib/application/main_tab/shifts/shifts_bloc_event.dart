part of 'shifts_bloc_bloc.dart';

@freezed
class ShiftsBlocEvent with _$ShiftsBlocEvent {
  const factory ShiftsBlocEvent.started() = _Started;

  factory ShiftsBlocEvent.tabChange(int tabIndex) = ShiftsTabChange;

  const factory ShiftsBlocEvent.getLocationListAPI() = GetLocationListAPI;

  const factory ShiftsBlocEvent.withdrawShift() = WithdrawShift;

  factory ShiftsBlocEvent.deleteReasonChange(String value) = DeleteReasonChange;

  factory ShiftsBlocEvent.changeClockInClockOutTime(
      TimeOfDay time, bool isClockIn) = CangeClockInClockOutTime;

  factory ShiftsBlocEvent.onChangeSortBy(
      SingleValueDropDownController controller) = OnChangeSortBy;
  factory ShiftsBlocEvent.onFilledSorting(LocationDTO currentSorting) =
      onFilledSorting;

  factory ShiftsBlocEvent.fetchFilledShiftList({
    required bool refresh,
  }) = FetchAllPreviousPost;

  factory ShiftsBlocEvent.fetchApprovedShiftList({
    required bool refresh,
  }) = FetchApprovedShiftList;

  factory ShiftsBlocEvent.fetchCancelledShiftList({
    required bool refresh,
  }) = FetchCancelledShiftList;
}
