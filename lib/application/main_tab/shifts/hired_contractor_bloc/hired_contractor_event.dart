part of 'hired_contractor_bloc.dart';

@freezed
class HiredContractorEvent with _$HiredContractorEvent {
  const factory HiredContractorEvent.getHiredFilledContractorList(
      {required bool refresh,
      required int postId}) = GetHiredFilledContractorList;

  const factory HiredContractorEvent.getHiredApproveContractorList(
      {required bool refresh,
      required int postId}) = GetHiredApproveContractorList;

  factory HiredContractorEvent.changeClockInClockOutTime(
      TimeOfDay time, bool isClockIn) = ChangeClockInClockOutTime;
  factory HiredContractorEvent.submitClockInOutTime(
    BuildContext context,
  {
    required int postId,
    required int userId,
    
  }) = SubmitClockInOutTime;
}
