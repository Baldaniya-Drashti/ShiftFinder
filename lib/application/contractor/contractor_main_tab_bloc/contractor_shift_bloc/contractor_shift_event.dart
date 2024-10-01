part of 'contractor_shift_bloc.dart';

@freezed
class ContractorShiftEvent with _$ContractorShiftEvent {
  const factory ContractorShiftEvent.changeShiftTab(int tabIndex) =
      ChangeShiftTab;

  const factory ContractorShiftEvent.getCurrentShiftDetailAPI(bool isRefresh,
      {int? filterType}) = GetCurrentShiftDetailAPI;

  const factory ContractorShiftEvent.getUpcomingShiftAPI(bool isRefresh) =
      GetUpcomingShiftAPI;

  const factory ContractorShiftEvent.setClockIn(BuildContext context,
      {required int index, required TimeOfDay clockInTime}) = SetClockIn;
  const factory ContractorShiftEvent.setClockOut(BuildContext context,
      {required int index, required TimeOfDay clockOutTime}) = SetClockOut;
  const factory ContractorShiftEvent.submitClockInOut(BuildContext context,
      {required int clockInOutTime, required int postId}) = SubmitClockInOut;
  const factory ContractorShiftEvent.deleteUpcomingShift(BuildContext context,
      {required int postId}) = DeleteUpcomingShift;

  const factory ContractorShiftEvent.deletePostReasonChanged(String reason) =
      DeletePostReasonChanged;
}
