part of 'employer_long_term_confirmation_bloc.dart';

@freezed
class EmployerLongTermConfirmationState with _$EmployerLongTermConfirmationState {
  const factory EmployerLongTermConfirmationState({
    @Default([]) List<TeamDTO> teamList,
    @Default([]) List<TeamDTO> selectedTeamList,
    @Default(false) bool shareWithTeam,
    @Default(false) bool saveAsFuturePost,
    @Default(false) bool agreeTermsAndCondition,
  }) = _EmployerLongTermConfirmationState;

  factory EmployerLongTermConfirmationState.initial() => EmployerLongTermConfirmationState();
}
