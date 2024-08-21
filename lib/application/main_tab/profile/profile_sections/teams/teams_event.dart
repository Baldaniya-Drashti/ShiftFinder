part of 'teams_bloc.dart';

@freezed
class TeamsEvent with _$TeamsEvent {
  const factory TeamsEvent.initialEvent() = InitialEvent;
  const factory TeamsEvent.changeLocation(String location) = ChangeLocation;

  const factory TeamsEvent.changeTeamName(String teamName) = ChangeTeamName;
  const factory TeamsEvent.createTeam() = CreateTeam;
}
