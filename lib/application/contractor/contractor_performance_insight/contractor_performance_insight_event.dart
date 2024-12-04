part of 'contractor_performance_insight_bloc.dart';

@freezed
class ContractorPerformanceInsightEvent
    with _$ContractorPerformanceInsightEvent {
  const factory ContractorPerformanceInsightEvent.onDateSelected(
    BuildContext context, {
    required List<DateTime> dates,
  }) = _OnDateSelected;
}
