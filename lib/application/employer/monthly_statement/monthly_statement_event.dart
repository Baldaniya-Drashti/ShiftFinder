part of 'monthly_statement_bloc.dart';

@freezed
class MonthlyStatementEvent with _$MonthlyStatementEvent {
  const factory MonthlyStatementEvent.onDateSelected({
    required List<DateTime> dates,
  }) = _OnDateSelected;
  const factory MonthlyStatementEvent.downloadMonthlyStatementEvent(
      BuildContext context) = DownloadMonthlyStatementEvent;
  const factory MonthlyStatementEvent.getMonthlyStatementListEvent(
      bool isRefresh,
      {int? startDate,
      int? endDate}) = GetMonthlyStatementListEvent;
}
