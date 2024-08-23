part of 'add_new_member_bloc.dart';

@freezed
class AddNewMemberEvent with _$AddNewMemberEvent {
  const factory AddNewMemberEvent.initialEvent() = InitialEvent;
  const factory AddNewMemberEvent.changeTeamMemberName(String teamName) =
      ChangeTeamMemberName;
  const factory AddNewMemberEvent.jobLocationChange(String jobLocationChange) =
      JobLocationChange;
  const factory AddNewMemberEvent.phoneNumberChange(String phoneNumber) =
      PhoneNumberChange;
  const factory AddNewMemberEvent.emailChange(String email) = EmailChange;
  const factory AddNewMemberEvent.addNewMember() = AddNewMember;
}
