// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_applicant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerApplicantsDtoImpl _$$EmployerApplicantsDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerApplicantsDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      last_ago: json['last_ago'] as String?,
      distance: json['distance'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      request: (json['request'] as num?)?.toInt(),
      revoke_status: (json['revoke_status'] as num?)?.toInt(),
      revoke_start: (json['revoke_start'] as num?)?.toInt(),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$$EmployerApplicantsDtoImplToJson(
        _$EmployerApplicantsDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'profile': instance.profile,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'last_ago': instance.last_ago,
      'distance': instance.distance,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'request': instance.request,
      'revoke_status': instance.revoke_status,
      'revoke_start': instance.revoke_start,
      'duration': instance.duration?.inMicroseconds,
    };
