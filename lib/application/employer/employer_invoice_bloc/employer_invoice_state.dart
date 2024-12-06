part of 'employer_invoice_bloc.dart';

@freezed
class EmployerInvoiceState with _$EmployerInvoiceState {
  factory EmployerInvoiceState({
    required bool isLoading,
    required bool noDataFound,
    required bool isErrorInApi,
    required List<PaymentHistoryDTO> invoiceList,
  }) = _EmployerInvoiceState;
  factory EmployerInvoiceState.initial() => EmployerInvoiceState(
        isErrorInApi: false,
        isLoading: false,
        noDataFound: false,
        invoiceList: [],
      );
}
