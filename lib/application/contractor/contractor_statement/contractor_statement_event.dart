part of 'contractor_statement_bloc.dart';

@freezed
class ContractorStatementEvent with _$ContractorStatementEvent {
  const factory ContractorStatementEvent.onFilterChanged({
    required StatementFilterModel value,
  }) = onFilterChanged;


  const factory ContractorStatementEvent.onSelectDateRange({
    required List<DateTime> value,
  }) = onSelectDateRange;
}
