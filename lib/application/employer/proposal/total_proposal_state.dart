part of 'total_proposal_bloc.dart';

@freezed
class TotalProposalState with _$TotalProposalState {
  factory TotalProposalState({
    required List<EmployerProposalPendingUserDto> totalProposedDataList,
    EmployerProposalDto? additionalData,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required int postId,
    required bool postDataLoading,
  }) = _TotalProposalState;

  factory TotalProposalState.initial() => TotalProposalState(
        postDataLoading: false,
        postId: -1,
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        totalProposedDataList: [],
      );
}
