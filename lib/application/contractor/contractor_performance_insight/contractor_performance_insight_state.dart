part of 'contractor_performance_insight_bloc.dart';

@freezed
class ContractorPerformanceInsightState with _$ContractorPerformanceInsightState {
  const factory ContractorPerformanceInsightState({
    @Default([])List<DateTime> selectedDates
}) = _ContractorPerformanceInsightState;
}
