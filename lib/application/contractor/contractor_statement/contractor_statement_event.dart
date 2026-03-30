part of 'contractor_statement_bloc.dart';

@freezed
class ContractorStatementEvent with _$ContractorStatementEvent {
  const factory ContractorStatementEvent.onFilterChanged(
    BuildContext context, {
    required StatementFilterModel value,
  }) = onFilterChanged;

  const factory ContractorStatementEvent.onSelectDateRange(
    BuildContext context, {
    required List<DateTime> value,
  }) = onSelectDateRange;

  const factory ContractorStatementEvent.getStatement(BuildContext context) =
      GetStatement;
}
