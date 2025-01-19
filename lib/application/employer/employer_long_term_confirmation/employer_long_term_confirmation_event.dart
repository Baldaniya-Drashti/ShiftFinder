part of 'employer_long_term_confirmation_bloc.dart';

@freezed
class EmployerLongTermConfirmationEvent with _$EmployerLongTermConfirmationEvent {
  const factory EmployerLongTermConfirmationEvent.getTeamList() = _GetTeamList;
  const factory EmployerLongTermConfirmationEvent.selectTeam(TeamDTO team) = _SelectTeam;
  const factory EmployerLongTermConfirmationEvent.selectSharePostWithTeam(bool value) = _SelectSharePostWithTeam;
  const factory EmployerLongTermConfirmationEvent.selectFuturePosting(bool value) = _SelectFuturePosting;
  const factory EmployerLongTermConfirmationEvent.selectTermsAndCondition(bool value) = _SelectTermsAndCondition;
}
