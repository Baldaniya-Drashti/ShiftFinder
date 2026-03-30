// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_saved_template_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerSavedTemplateDtoImpl _$$EmployerSavedTemplateDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerSavedTemplateDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      roles: json['roles'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      job_type: (json['job_type'] as num?)?.toInt(),
      post_type: (json['post_type'] as num?)?.toInt(),
      shift: (json['shift'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EmployerSavedTemplateDtoImplToJson(
        _$EmployerSavedTemplateDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roles': instance.roles,
      'roles_list_name': instance.roles_list_name,
      'location': instance.location,
      'job_type': instance.job_type,
      'post_type': instance.post_type,
      'shift': instance.shift,
    };
