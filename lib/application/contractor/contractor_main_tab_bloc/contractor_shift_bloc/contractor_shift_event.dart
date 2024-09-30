part of 'contractor_shift_bloc.dart';

@freezed
class ContractorShiftEvent with _$ContractorShiftEvent {
  const factory ContractorShiftEvent.changeShiftTab(int tabIndex) =
      ChangeShiftTab;

  const factory ContractorShiftEvent.getCurrentShiftDetailAPI(bool isRefresh,
      {int? filterType}) = GetCurrentShiftDetailAPI;

  const factory ContractorShiftEvent.getUpcomingShiftAPI(bool isRefresh) =
      GetUpcomingShiftAPI;

  const factory ContractorShiftEvent.setClockIn(
      {required int index, required String clockInTime}) = SetClockIn;
  const factory ContractorShiftEvent.submitClockInOut(
      {required String clockInOutTime}) = SubmitClockInOut;
}
