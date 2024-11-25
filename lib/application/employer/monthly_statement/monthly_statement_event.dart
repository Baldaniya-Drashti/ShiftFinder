part of 'monthly_statement_bloc.dart';

@freezed
class MonthlyStatementEvent with _$MonthlyStatementEvent {
  const factory MonthlyStatementEvent.onDateSelected({
    required List<DateTime> dates,
  }) = _OnDateSelected;
}
