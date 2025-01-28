part of 'contractor_earning_bloc.dart';

@freezed
class ContractorEarningState with _$ContractorEarningState {
  factory ContractorEarningState({
    required List<DateTime> selectedDateTime,
    required bool isLoading,
    required EarningStatementDTO? statement,
  }) = _ContractorEarningState;
  factory ContractorEarningState.initial() => ContractorEarningState(
        selectedDateTime: [],
        isLoading: false,
        statement: null,
      );
}
