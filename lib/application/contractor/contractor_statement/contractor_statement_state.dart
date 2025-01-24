part of 'contractor_statement_bloc.dart';

// @freezed
// class ContractorStatementState with _$ContractorStatementState {
//   const factory ContractorStatementState({
//     @Default(StatementFilterModel(id: 1, label: 'Shifts Earnings')) StatementFilterModel currentStatementFilter,
//     @Default([]) List<DateTime> selectedDates,
//   }) = _ContractorStatementState;
// }

@freezed
class ContractorStatementState with _$ContractorStatementState {
  factory ContractorStatementState({
    // required GetBalanceDTO? currentBalance,
    required StatementFilterModel currentStatementFilter,
    required List<DateTime> selectedDates,
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required StatementDTO? statement,
    // required List<ContractorWalletDTO> walletList,
    // required Rate withdrawAmount,
  }) = _ContractorStatementState;
  factory ContractorStatementState.initial() => ContractorStatementState(
        currentStatementFilter: CommonList.statementList[0],
        selectedDates: [],
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        statement: null,
        // currentBalance: null,
        // walletList: [],
        // withdrawAmount: Rate(""),
      );
}
