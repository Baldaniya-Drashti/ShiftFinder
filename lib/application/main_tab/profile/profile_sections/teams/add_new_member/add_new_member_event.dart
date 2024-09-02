part of 'add_new_member_bloc.dart';

@freezed
class AddNewMemberEvent with _$AddNewMemberEvent {
  const factory AddNewMemberEvent.initialEvent() = InitialEvent;
  const factory AddNewMemberEvent.changeTeamMemberName(String teamName) =
      ChangeTeamMemberName;
  const factory AddNewMemberEvent.changeCountryCode(
      String countryCode, String countryFlag) = ChangeCountryCode;
  const factory AddNewMemberEvent.jobLocationChange(String jobLocationChange) =
      JobLocationChange;
  const factory AddNewMemberEvent.phoneNumberChange(String phoneNumber) =
      PhoneNumberChange;
  const factory AddNewMemberEvent.emailChange(String email) = EmailChange;
  const factory AddNewMemberEvent.prefillDataForUpdateTeamMember(
      Members getTeamsListDTO, bool isEdit) = PrefillDataForUpdateTeamMember;
  const factory AddNewMemberEvent.addNewMember() = AddNewMember;
  const factory AddNewMemberEvent.updateTeamMember(String updateTeamID) =
      UpdateTeamMember;
  const factory AddNewMemberEvent.deleteTeamMember(String updateTeamID) =
      DeleteTeamMember;
  const factory AddNewMemberEvent.setTeamID(String teamID) = SetTeamID;
}
