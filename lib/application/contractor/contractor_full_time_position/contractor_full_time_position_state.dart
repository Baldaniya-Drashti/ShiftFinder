part of 'contractor_full_time_position_bloc.dart';

@freezed
class ContractorFullTimePositionState with _$ContractorFullTimePositionState {
  const factory ContractorFullTimePositionState({
    @Default(false) bool isLoading,
    @Default(false) bool isNoDataFound,
    @Default(false) bool isErrorInAPI,
    @Default(false) bool appliedLoading,
    @Default(false) bool appliedNoDataFound,
    @Default(false) bool appliedIsErrorInAPI,
    @Default(false) bool postDataLoading,
    required List<ContractorLongTermDashboardDto> openPositionList,
    required List<ContractorLongTermDashboardDto> appliedPositionList,
    required int selectedTab,
  }) = _EmployerLongTermPositionAddDetailState;

  factory ContractorFullTimePositionState.initial() =>
      ContractorFullTimePositionState(
        openPositionList: [],
        appliedPositionList: [],
        selectedTab: 0,
      );
}
