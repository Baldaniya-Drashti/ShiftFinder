part of 'hired_contractor_bloc.dart';

@freezed
class HiredContractorEvent with _$HiredContractorEvent {
  const factory HiredContractorEvent.getHiredContractorList({
    required int postId,
    required BuildContext context,
    required bool refresh,
  }) = GetHiredContractorList;
}
