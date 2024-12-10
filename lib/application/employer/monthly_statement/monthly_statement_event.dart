part of 'monthly_statement_bloc.dart';

@freezed
class MonthlyStatementEvent with _$MonthlyStatementEvent {
  const factory MonthlyStatementEvent.onDateSelected({
    required List<DateTime> dates,
  }) = _OnDateSelected;
  const factory MonthlyStatementEvent.downloadMonthlyStatementEvent(
      BuildContext context,
      {required MonthlyStatementDTO statement}) = DownloadMonthlyStatementEvent;
  const factory MonthlyStatementEvent.getMonthlyStatementListEvent(
      bool isRefresh,
      {DateTime? startDate,
      DateTime? endDate}) = GetMonthlyStatementListEvent;
}
