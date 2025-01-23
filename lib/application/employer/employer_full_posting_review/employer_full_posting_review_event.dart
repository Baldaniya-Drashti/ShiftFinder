part of 'employer_full_posting_review_bloc.dart';

@freezed
class EmployerFullPostingReviewEvent with _$EmployerFullPostingReviewEvent {
  const factory EmployerFullPostingReviewEvent.onIncludeCallChanged({
    required bool value,
  }) = onIncludeCallChanged;

  const factory EmployerFullPostingReviewEvent.onSaveTemplateFutureChanged({
    required bool value,
  }) = OnSaveTemplateFutureChanged;
}
