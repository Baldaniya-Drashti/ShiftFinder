part of 'contractor_long_term_bloc.dart';

@freezed
class ContractorLongTermState with _$ContractorLongTermState {
  const factory ContractorLongTermState({
    @Default(false) bool isLoading,
    @Default(false) bool isNoDataFound,
    @Default(false) bool isErrorInAPI,
    @Default(false) bool postDataLoading,
    @Default(false) bool upcomingLoading,
    @Default(false) bool upcomingNoDataFound,
    @Default(false) bool upcomingIsErrorInAPI,
    @Default(false) bool appliedLoading,
    @Default(false) bool appliedNoDataFound,
    @Default(false) bool appliedIsErrorInAPI,
    required List<ContractorLongTermDashboardDto> openPositionList,
    required List<ContractorLongTermDashboardDto> upComingPositionList,
    required List<ContractorLongTermDashboardDto> appliedPositionList,
    required int selectedTab,
  }) = _EmployerLongTermPositionAddDetailState;

  factory ContractorLongTermState.initial() => ContractorLongTermState(
        openPositionList: [],
        upComingPositionList: [],
        appliedPositionList: [],
        upcomingLoading: false,
        upcomingIsErrorInAPI: false,
        upcomingNoDataFound: false,
        appliedIsErrorInAPI: false,
        appliedLoading: false,
        appliedNoDataFound: false,
        selectedTab: 0,
      );
}
