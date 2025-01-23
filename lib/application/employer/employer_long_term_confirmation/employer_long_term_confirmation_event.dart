part of 'employer_long_term_confirmation_bloc.dart';

@freezed
class EmployerLongTermConfirmationEvent with _$EmployerLongTermConfirmationEvent {
  const factory EmployerLongTermConfirmationEvent.getTeamList() = _GetTeamList;
  const factory EmployerLongTermConfirmationEvent.selectTeam(TeamDTO team) = _SelectTeam;
  const factory EmployerLongTermConfirmationEvent.selectSharePostWithTeam(int value) = _SelectSharePostWithTeam;
  const factory EmployerLongTermConfirmationEvent.selectFuturePosting(int value) = _SelectFuturePosting;
  const factory EmployerLongTermConfirmationEvent.selectTermsAndCondition(int value) = _SelectTermsAndCondition;
  const factory EmployerLongTermConfirmationEvent.onContinue(BuildContext context) = _OnContinue;
  const factory EmployerLongTermConfirmationEvent.onCreate(PostShiftDTO postDetail,EmployerLongTermSuccessDto employer) = _OnCreate;
}
