part of 'employer_full_posting_review_bloc.dart';

@freezed
class EmployerFullPostingReviewState with _$EmployerFullPostingReviewState {
  const factory EmployerFullPostingReviewState({
    @Default(false) final bool loading
  }) = _EmployerFullPostingReviewState;
}
