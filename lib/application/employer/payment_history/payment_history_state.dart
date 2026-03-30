part of 'payment_history_bloc.dart';

@freezed
class PaymentHistoryState with _$PaymentHistoryState {
  factory PaymentHistoryState({
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required List<PaymentHistoryDTO> historyList,
  }) = _PaymentHistoryState;
  factory PaymentHistoryState.initial() => PaymentHistoryState(
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        historyList: [],
      );
}
