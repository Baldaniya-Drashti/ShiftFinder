part of 'employer_full_posting_confirm_bloc.dart';

@freezed
class EmployerFullPostingConfirmEvent with _$EmployerFullPostingConfirmEvent {
  const factory EmployerFullPostingConfirmEvent.onApplicationDeadlineChanged({
    required DateTime selectedDateTime,
  }) = OnApplicationDeadlineChanged;

  const factory EmployerFullPostingConfirmEvent.onIncludeOnCallChanged({
    required bool value,
  }) = OnIncludeOnCallChanged;

  const factory EmployerFullPostingConfirmEvent.onFuturePostingChanged({
    required bool value,
  }) = OnFuturePostingChanged;

  const factory EmployerFullPostingConfirmEvent.onMoreVacancyChanged({
    required bool value,
  }) = OnMoreVacancyChanged;
  const factory EmployerFullPostingConfirmEvent.onTermsAndConditionChanged({
    required bool value,
  }) = OnTermsAndConditionChanged;
  const factory EmployerFullPostingConfirmEvent.onCreate(
      {required EmployerLongTermSuccessDto employerLongTermSuccessDto,
      int? post}) = OnCreate;

  const factory EmployerFullPostingConfirmEvent.onContinue({
    required BuildContext context,
    required bool fromReview,
    required bool fromTemplate,
    required bool isCreate,
  }) = OnContinue;

  const factory EmployerFullPostingConfirmEvent.addVacancyChanged(
      String vacancy) = AddVacancyChanged;

  const factory EmployerFullPostingConfirmEvent.checkIsMoreVancancy(
      bool isMoreVacancy) = CheckIsMoreVancancy;
}
