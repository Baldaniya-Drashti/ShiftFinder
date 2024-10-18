part of 'hired_contractor_bloc.dart';

@freezed
class HiredContractorState with _$HiredContractorState {
  factory HiredContractorState({
    required List<dynamic> hiredContractorList,
    required bool loading,
    required bool apiError,
    required bool noDataFound,
    required int postId,
  }) = _HiredContractorState;

  factory HiredContractorState.initial() => HiredContractorState(
        postId: -1,
        hiredContractorList: [],
        noDataFound: false,
        apiError: false,
        loading: false,
      );
}
