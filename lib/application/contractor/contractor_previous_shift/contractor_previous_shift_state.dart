part of 'contractor_previous_shift_bloc.dart';

@freezed
class ContractorPreviousShiftState with _$ContractorPreviousShiftState {
  const factory ContractorPreviousShiftState({
    @Default(1) int currentIndex,
    @Default(SkillDTO(id: 1, name: "Withdrawn by You")) SkillDTO currentCancelFilter,
    @Default(false) bool postDataLoading,
    @Default(false) bool completedDataListLoading,
    @Default(false) bool cancelledDataListLoading,
    @Default(false) bool completedDataNoDataFound,
    @Default(false) bool cancelledDataNoDataFound,
    @Default(false) bool completedDataListIsErrorApi,
    @Default(false) bool cancelledDataIsErrorApi,
    @Default([]) List<dynamic> completedDataList,
    @Default([]) List<dynamic> cancelledDataList,
  }) = _ContractorPreviousShiftState;
}
