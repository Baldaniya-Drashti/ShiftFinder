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
}
