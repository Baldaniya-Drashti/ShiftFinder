// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'team_dto.freezed.dart';
part 'team_dto.g.dart';

@freezed
class TeamDTO with _$TeamDTO {
  const factory TeamDTO({
    int? id,
    int? location_id,
    LocationDTO? location,
    String? name,
    int? total_member,
    List? members,
  }) = _TeamDTO;

  factory TeamDTO.fromJson(Map<String, dynamic> json) =>
      _$TeamDTOFromJson(json);
}

@freezed
class TeamAvailableDTO with _$TeamAvailableDTO {
  const factory TeamAvailableDTO({
    int? isTeamAvailable,
  }) = _TeamAvailableDTO;

  factory TeamAvailableDTO.fromJson(Map<String, dynamic> json) =>
      _$TeamAvailableDTOFromJson(json);
}
