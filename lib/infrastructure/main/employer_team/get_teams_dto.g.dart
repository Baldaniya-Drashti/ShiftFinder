// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_teams_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetTeamsListDTOImpl _$$GetTeamsListDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$GetTeamsListDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      location_id: (json['location_id'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String?,
      total_member: (json['total_member'] as num?)?.toInt(),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Members.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetTeamsListDTOImplToJson(
        _$GetTeamsListDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location_id': instance.location_id,
      'location': instance.location,
      'name': instance.name,
      'total_member': instance.total_member,
      'members': instance.members,
    };

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      id: (json['id'] as num?)?.toInt(),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
    };

_$MembersImpl _$$MembersImplFromJson(Map<String, dynamic> json) =>
    _$MembersImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      position: json['position'] as String?,
      country_code: json['country_code'] as String? ?? '1',
      country_name_code: json['country_name_code'] as String? ?? '🇨🇦',
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$MembersImplToJson(_$MembersImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
      'country_code': instance.country_code,
      'country_name_code': instance.country_name_code,
      'phone': instance.phone,
      'email': instance.email,
    };
