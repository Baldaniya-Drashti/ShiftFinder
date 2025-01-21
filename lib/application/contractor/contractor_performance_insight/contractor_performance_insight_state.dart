part of 'contractor_performance_insight_bloc.dart';

@freezed
class ContractorPerformanceInsightState
    with _$ContractorPerformanceInsightState {
  const factory ContractorPerformanceInsightState({
    required bool isLoading,
    required bool isDeleting,
    required bool showErrorMessages,
    required Option<Either<MainFailure, CommonResponse>> failureOrSuccessOption,
    required List<DateTime> selectedDateTime,
    required DateTime? selectedMonth,
  }) = _ContractorPerformanceInsightState;

  factory ContractorPerformanceInsightState.initial() =>
      ContractorPerformanceInsightState(
        isLoading: false,
        isDeleting: false,
        showErrorMessages: false,
        failureOrSuccessOption: none(),
        selectedDateTime: [],
        selectedMonth: null,
      );
}
