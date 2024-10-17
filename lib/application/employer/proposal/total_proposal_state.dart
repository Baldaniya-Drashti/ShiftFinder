part of 'total_proposal_bloc.dart';

@freezed
class TotalProposalState with _$TotalProposalState {
  factory TotalProposalState({
    required List<EmployerProposalPendingUserDto> totalProposedDataList,
    required EmployerProposalDto additionalData,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required int postId,
  }) = _TotalProposalState;

  factory TotalProposalState.initial() => TotalProposalState(
        postId: -1,
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        totalProposedDataList: [],
        additionalData: EmployerProposalDto(),
      );
}
