part of 'hired_contractor_bloc.dart';

@freezed
class HiredContractorEvent with _$HiredContractorEvent {
  const factory HiredContractorEvent.getHiredFilledContractorList(
      {required bool refresh,
      required int postId}) = GetHiredFilledContractorList;

  const factory HiredContractorEvent.getHiredCancelledContractorList(
      {required bool refresh,
      required int postId}) = GetHiredCancelledContractorList;
  const factory HiredContractorEvent.getHiredApproveContractorList(
      {required bool refresh,
      required int postId}) = GetHiredApproveContractorList;

  factory HiredContractorEvent.changeClockInClockOutTime(
      TimeOfDay time, bool isClockIn) = ChangeClockInClockOutTime;

  factory HiredContractorEvent.getEditClockInTime(
      {int? clockIn, int? clockOut}) = GetEditClockInTime;
  factory HiredContractorEvent.submitClockInOutTime(
    BuildContext context, {
    required int postId,
    required int userId,
    int? clockIn,
    int? clockOut,
  }) = SubmitClockInOutTime;
}
