part of 'hired_contractor_bloc.dart';

@freezed
class HiredContractorEvent with _$HiredContractorEvent {
  const factory HiredContractorEvent.getHiredFilledContractorList(
      {required bool refresh, required int postId}) = GetHiredFilledContractorList;

        const factory HiredContractorEvent.getHiredApproveContractorList(
      {required bool refresh, required int postId}) = GetHiredApproveContractorList;
}
