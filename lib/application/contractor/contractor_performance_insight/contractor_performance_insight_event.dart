part of 'contractor_performance_insight_bloc.dart';

@freezed
class ContractorPerformanceInsightEvent
    with _$ContractorPerformanceInsightEvent {
  const factory ContractorPerformanceInsightEvent.onDateSelected(
    BuildContext context, {
    required DateTime? selectedDate,
  }) = _OnDateSelected;
  const factory ContractorPerformanceInsightEvent.onPointSelect(
    BuildContext context, {
    required ChartPointDetails? selectedPoint,
  }) = OnPointSelect;
}
