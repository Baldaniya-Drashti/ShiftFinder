part of 'contractor_long_term_bloc.dart';

@freezed
class ContractorLongTermState with _$ContractorLongTermState {
  const factory ContractorLongTermState({
    @Default(false) bool isLoading,
    @Default(false) bool isNoDataFound,
    @Default(false) bool isErrorInAPI,
    @Default(false) bool postDataLoading,
    required List<ContractorLongTermDashboardDto> openPositionList,
    required List<ContractorLongTermDashboardDto> upComingPositionList,
    required List<ContractorLongTermDashboardDto> appliedPositionList,
  }) = _EmployerLongTermPositionAddDetailState;

  factory ContractorLongTermState.initial() => ContractorLongTermState(
        openPositionList: [],
        upComingPositionList: [],
        appliedPositionList: [],
      );
}
