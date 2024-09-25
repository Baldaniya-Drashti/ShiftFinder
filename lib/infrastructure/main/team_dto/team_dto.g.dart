// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamDTOImpl _$$TeamDTOImplFromJson(Map<String, dynamic> json) =>
    _$TeamDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      location_id: (json['location_id'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      total_member: (json['total_member'] as num?)?.toInt(),
      members: json['members'] as List<dynamic>?,
    );

Map<String, dynamic> _$$TeamDTOImplToJson(_$TeamDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location_id': instance.location_id,
      'location': instance.location,
      'name': instance.name,
      'total_member': instance.total_member,
      'members': instance.members,
    };

_$TeamAvailableDTOImpl _$$TeamAvailableDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamAvailableDTOImpl(
      isTeamAvailable: (json['isTeamAvailable'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TeamAvailableDTOImplToJson(
        _$TeamAvailableDTOImpl instance) =>
    <String, dynamic>{
      'isTeamAvailable': instance.isTeamAvailable,
    };
