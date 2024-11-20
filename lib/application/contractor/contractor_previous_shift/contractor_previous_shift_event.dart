part of 'contractor_previous_shift_bloc.dart';

@freezed
class ContractorPreviousShiftEvent with _$ContractorPreviousShiftEvent {
  factory ContractorPreviousShiftEvent.onCancelTypeSorting(SkillDTO currentSorting) = OnCancelTypeSorting;

  factory ContractorPreviousShiftEvent.tabChange(int index) = TabChange;

  factory ContractorPreviousShiftEvent.getCompletedList({
    required bool refresh,
  }) = GetCompletedList;

  factory ContractorPreviousShiftEvent.getCancelledShift({
    required bool refresh,
    required int sortBy,
  }) = GetCancelledShift;
}
