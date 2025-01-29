part of 'employer_full_posting_review_bloc.dart';

@freezed
class EmployerFullPostingReviewEvent with _$EmployerFullPostingReviewEvent {
  const factory EmployerFullPostingReviewEvent.onSubmit({
    required BuildContext context,
    required int id,
  }) = OnSubmit;
}
