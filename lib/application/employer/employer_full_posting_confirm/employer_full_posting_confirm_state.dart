part of 'employer_full_posting_confirm_bloc.dart';

@freezed
class EmployerFullPostingConfirmState with _$EmployerFullPostingConfirmState {
  const factory EmployerFullPostingConfirmState({
    @Default(false) bool postDataLoading,
    int? postId,

    @Default(EmployerLongTermSuccessDto()) final EmployerLongTermSuccessDto employerFullPosting,
  }) = _EmployerFullPostingConfirmState;
}
