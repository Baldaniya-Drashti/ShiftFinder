part of 'contractor_statement_bloc.dart';

@freezed
class ContractorStatementState with _$ContractorStatementState {
  factory ContractorStatementState({
    required StatementFilterModel currentStatementFilter,
    required List<DateTime> selectedDates,
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required StatementDTO? statement,
  }) = _ContractorStatementState;
  factory ContractorStatementState.initial() => ContractorStatementState(
        currentStatementFilter: CommonList.statementList[0],
        selectedDates: [],
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        statement: null,
      );
}
