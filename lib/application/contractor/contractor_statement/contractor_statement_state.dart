part of 'contractor_statement_bloc.dart';

@freezed
class ContractorStatementState with _$ContractorStatementState {
  const factory ContractorStatementState({
    @Default(StatementFilterModel(id: 1, label: 'Shifts Earnings')) StatementFilterModel currentStatementFilter,
    @Default([]) List<DateTime> selectedDates,
  }) = _ContractorStatementState;
}
