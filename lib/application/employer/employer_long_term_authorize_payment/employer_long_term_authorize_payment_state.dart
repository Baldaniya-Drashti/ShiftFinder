part of 'employer_long_term_authorize_payment_bloc.dart';

@freezed
class EmployerLongTermAuthorizePaymentState with _$EmployerLongTermAuthorizePaymentState {
  const factory EmployerLongTermAuthorizePaymentState({
    @Default(false) bool postDataLoading,
  }) = _EmployerLongTermAuthorizePaymentState;
}
