part of 'employer_long_term_payable_bloc.dart';

@freezed
class EmployerLongTermPayableState with _$EmployerLongTermPayableState {
  const factory EmployerLongTermPayableState({
    @Default(false) bool postDataLoading
  }) = _EmployerLongTermPayableState;

  factory EmployerLongTermPayableState.initial() => EmployerLongTermPayableState();
}
