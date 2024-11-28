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
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      shift: (json['shift'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EmployerSavedTemplateDtoImplToJson(
        _$EmployerSavedTemplateDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roles': instance.roles,
      'location': instance.location,
      'shift': instance.shift,
    };
