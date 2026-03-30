part of 'employer_invoice_bloc.dart';

@freezed
class EmployerInvoiceEvent with _$EmployerInvoiceEvent {
  const factory EmployerInvoiceEvent.getEmployerInvoiceEvent(
    bool isRefresh,
  ) = GetEmployerInvoiceEvent;

  const factory EmployerInvoiceEvent.getInvoiceDetailEvent(int id) =
      GetInvoiceDetailEvent;
}
