// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_long_term_applicant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerLongTermApplicantDtoImpl _$$EmployerLongTermApplicantDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerLongTermApplicantDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      last_ago: json['last_ago'] as String?,
      distance: json['distance'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      request: (json['request'] as num?)?.toInt(),
      urgent_action: (json['urgent_action'] as num?)?.toInt(),
      revoke_status: (json['revoke_status'] as num?)?.toInt(),
      revoke_start: (json['revoke_start'] as num?)?.toInt(),
      occupied: json['occupied'] as bool?,
      accept_btn_toggle: json['accept_btn_toggle'] as bool?,
      deleteAt: (json['deleteAt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EmployerLongTermApplicantDtoImplToJson(
        _$EmployerLongTermApplicantDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'post_id': instance.post_id,
      'profile': instance.profile,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'last_ago': instance.last_ago,
      'distance': instance.distance,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'request': instance.request,
      'urgent_action': instance.urgent_action,
      'revoke_status': instance.revoke_status,
      'revoke_start': instance.revoke_start,
      'occupied': instance.occupied,
      'accept_btn_toggle': instance.accept_btn_toggle,
      'deleteAt': instance.deleteAt,
    };
