part of 'monthly_statement_bloc.dart';

@freezed
class MonthlyStatementState with _$MonthlyStatementState {
  const factory MonthlyStatementState({
    @Default([]) List<DateTime> selectedDateTime,
  }) = _MonthlyStatementState;
}
