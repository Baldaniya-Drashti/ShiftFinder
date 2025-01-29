part of 'contractor_full_time_position_bloc.dart';

@freezed
class ContractorFullTimePositionState with _$ContractorFullTimePositionState {
  const factory ContractorFullTimePositionState({
    @Default(false) bool isLoading,
    @Default(false) bool isNoDataFound,
    @Default(false) bool isErrorInAPI,
    @Default(false) bool postDataLoading,
    required List<EmployerLongFullTermDashboardDto> openPositionList,
    required List<EmployerLongFullTermDashboardDto> appliedPositionList,
  }) = _EmployerLongTermPositionAddDetailState;

  factory ContractorFullTimePositionState.initial() => ContractorFullTimePositionState(
    openPositionList: [],
    appliedPositionList: [],
  );
}
