part of 'teams_bloc.dart';

@freezed
class TeamsEvent with _$TeamsEvent {
  const factory TeamsEvent.initialEvent() = InitialEvent;
  const factory TeamsEvent.changeLocation(String location) = ChangeLocation;

  const factory TeamsEvent.changeTeamName(String teamName) = ChangeTeamName;
  const factory TeamsEvent.createTeam() = CreateTeam;
  const factory TeamsEvent.updateTeam(String teamId) = UpdateTeam;
  const factory TeamsEvent.deleteTeam(String teamId) = DeleteTeam;

  const factory TeamsEvent.getTeamList(bool isRefresh) = GetTeamList;
  const factory TeamsEvent.getLocationListAPI() = GetLocationListAPI;
  const factory TeamsEvent.prefillDataForUpdateTeam(
          GetTeamsListDTO getTeamListDTO, bool isEdit, String teamID) =
      PrefillDataForUpdateTeam;
}
