part of 'monthly_statement_bloc.dart';

@freezed
class MonthlyStatementState with _$MonthlyStatementState {
  factory MonthlyStatementState({
    required List<DateTime> selectedDateTime,
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required MonthlyStatementDTO statement,
  }) = _MonthlyStatementState;
  factory MonthlyStatementState.initial() => MonthlyStatementState(
        selectedDateTime: [],
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        statement: MonthlyStatementDTO(),
      );
}
