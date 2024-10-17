part of 'proposal_detail_bloc.dart';

@freezed
class ProposalDetailState with _$ProposalDetailState {
  const factory ProposalDetailState({
    required ProposalDetailDto proposalDetailDto,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
     bool? confirmDialog,
  }) = _ProposalDetailState;

  factory ProposalDetailState.initial() => ProposalDetailState(
        proposalDetailDto: ProposalDetailDto(),
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
      );
}
