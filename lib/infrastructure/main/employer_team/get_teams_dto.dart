import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_teams_dto.freezed.dart';
part 'get_teams_dto.g.dart';

@freezed
class GetTeamsListDTO with _$GetTeamsListDTO {
  const factory GetTeamsListDTO({
    int? id,
    int? location_id,
    Location? location,
    String? name,
    int? total_member,
    List<Members>? members,
  }) = _GetTeamsListDTO;

  factory GetTeamsListDTO.fromJson(Map<String, dynamic> json) =>
      _$GetTeamsListDTOFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    int? id,
    double? latitude,
    double? longitude,
    String? location,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class Members with _$Members {
  const factory Members({
    int? id,
    String? name,
    String? position,
    String? country_code,
    @Default('🇨🇦') String? country_name_code,
    String? phone,
    String? email,
  }) = _Members;

  factory Members.fromJson(Map<String, dynamic> json) =>
      _$MembersFromJson(json);
}
