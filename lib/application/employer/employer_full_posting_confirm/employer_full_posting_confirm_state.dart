part of 'employer_full_posting_confirm_bloc.dart';

@freezed
class EmployerFullPostingConfirmState with _$EmployerFullPostingConfirmState {
  const factory EmployerFullPostingConfirmState({
    final DateTime? applicationDeadline,
    @Default(false) final bool includeOnCall,
    @Default(false) final bool saveFuturePosting,
    @Default(false) final bool moreVacancy,
    @Default(false) final bool termsAndCondition,
  }) = _EmployerFullPostingConfirmState;
}
