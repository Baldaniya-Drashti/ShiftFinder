part of 'employer_full_position_confirm_bloc.dart';

@freezed
class EmployerFullPositionConfirmState with _$EmployerFullPositionConfirmState {
  const factory EmployerFullPositionConfirmState({
    final DateTime? applicationDeadline,
    @Default(false) final bool includeOnCall,
    @Default(false) final bool saveFuturePosting,
    @Default(false) final bool moreVacancy,
    @Default(false) final bool termsAndCondition,
  }) = _EmployerFullPositionConfirmState;
}
