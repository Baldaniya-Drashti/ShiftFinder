part of 'shifts_bloc_bloc.dart';

@freezed
class ShiftsBlocEvent with _$ShiftsBlocEvent {
  const factory ShiftsBlocEvent.started() = _Started;
  factory ShiftsBlocEvent.tabChange(int tabIndex) = ShiftsTabChange;

  const factory ShiftsBlocEvent.getLocationListAPI() = GetLocationListAPI;
  const factory ShiftsBlocEvent.withdrawShift() = WithdrawShift;

  factory ShiftsBlocEvent.deleteReasonChange(String value) = DeleteReasonChange;
}
