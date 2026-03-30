part of 'agreed_proposal_bloc.dart';

@freezed
class AgreedProposalState with _$AgreedProposalState {
  factory AgreedProposalState({
    required bool isLoading,
    required bool showErrorMessages,
    required bool noDataFound,
    required bool errorApi,
    required EmployerProposalDto contractorDetail,
  }) = _AgreedProposalState;
  factory AgreedProposalState.initial() => AgreedProposalState(
        errorApi: false,
        contractorDetail: EmployerProposalDto(),
        isLoading: false,
        noDataFound: false,
        showErrorMessages: false,
      );
}
