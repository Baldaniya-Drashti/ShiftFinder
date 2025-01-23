part of 'employer_long_term_authorize_payment_bloc.dart';

@freezed
class EmployerLongTermAuthorizePaymentEvent with _$EmployerLongTermAuthorizePaymentEvent {
  const factory EmployerLongTermAuthorizePaymentEvent.onAuthorizePayment(BuildContext context, int id) = _OnAuthorizePayment;
}
