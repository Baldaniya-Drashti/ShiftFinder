part of 'employer_full_position_confirm_bloc.dart';

@freezed
class EmployerFullPositionConfirmEvent with _$EmployerFullPositionConfirmEvent {
  const factory EmployerFullPositionConfirmEvent.onApplicationDeadlineChanged({
    required DateTime selectedDateTime,
  }) = OnApplicationDeadlineChanged;

  const factory EmployerFullPositionConfirmEvent.onIncludeOnCallChanged({
    required bool value,
  }) = OnIncludeOnCallChanged;


  const factory EmployerFullPositionConfirmEvent.onFuturePostingChanged({
    required bool value,
  }) = OnFuturePostingChanged;

  const factory EmployerFullPositionConfirmEvent.onMoreVacancyChanged({
    required bool value,
  }) = OnMoreVacancyChanged;
  const factory EmployerFullPositionConfirmEvent.onTermsAndConditionChanged({
    required bool value,
  }) = OnTermsAndConditionChanged;
}
