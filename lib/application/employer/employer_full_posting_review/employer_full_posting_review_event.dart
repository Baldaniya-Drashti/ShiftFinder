part of 'employer_full_posting_review_bloc.dart';

@freezed
class EmployerFullPostingReviewEvent with _$EmployerFullPostingReviewEvent {
  const factory EmployerFullPostingReviewEvent.onSubmit({
    required BuildContext context,
    required EmployerLongTermSuccessDto employer,
    required EmployerLongTermSuccessDto data,
    required int id,
    required bool fromReview,
    required bool fromTemplate,
    required bool isCreate,
    int? postId,
  }) = OnSubmit;
}
