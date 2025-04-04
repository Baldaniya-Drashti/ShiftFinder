part of 'contractor_previous_shift_bloc.dart';

@freezed
class ContractorPreviousShiftState with _$ContractorPreviousShiftState {
  factory ContractorPreviousShiftState(
          {required bool isLoading,
          required int currentIndex,
          required SkillDTO currentCancelFilter,
          required bool postDataLoading,
          required bool completedDataListLoading,
          required bool cancelledDataListLoading,
          required bool completedDataNoDataFound,
          required bool cancelledDataNoDataFound,
          required bool completedDataListIsErrorApi,
          required bool cancelledDataIsErrorApi,
          required List<ContractorPreviousShiftDTO> completedDataList,
          required List<ContractorPreviousShiftDTO> cancelledDataList}) =
      _ContractorPreviousShiftState;
  factory ContractorPreviousShiftState.initial() =>
      ContractorPreviousShiftState(
        isLoading: false,
        currentCancelFilter: SkillDTO(id: 1, name: "Withdrawn by You"),
        currentIndex: 0,
        cancelledDataIsErrorApi: false,
        cancelledDataListLoading: false,
        cancelledDataNoDataFound: false,
        completedDataListIsErrorApi: false,
        completedDataListLoading: false,
        completedDataNoDataFound: false,
        cancelledDataList: [],
        completedDataList: [],
        postDataLoading: false,
      );
}
