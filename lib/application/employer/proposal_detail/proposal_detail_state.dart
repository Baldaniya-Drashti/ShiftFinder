part of 'proposal_detail_bloc.dart';

@freezed
class ProposalDetailState with _$ProposalDetailState {
  const factory ProposalDetailState({
    required EmployerProposalDto proposalDetailDto,
    required bool isLoading,
    required bool isNoDataFound,
    required bool isErrorInAPI,
    required bool postDataLoading,
    required List<SkillDTO> hoursList,
    bool? confirmDialog,
    bool? isConfirmProposalDate,
    required bool isConfirmError,
  }) = _ProposalDetailState;

  factory ProposalDetailState.initial() => ProposalDetailState(
        hoursList: [],
        proposalDetailDto: EmployerProposalDto(),
        isNoDataFound: false,
        isErrorInAPI: false,
        isLoading: false,
        postDataLoading: false,
        isConfirmProposalDate: false,
        isConfirmError: false,
      );
}
