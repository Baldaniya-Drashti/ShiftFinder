// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExperienceDTOImpl _$$ExperienceDTOImplFromJson(Map<String, dynamic> json) =>
    _$ExperienceDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      role: json['role'] == null
          ? null
          : CompleteProfileDataDto.fromJson(
              json['role'] as Map<String, dynamic>),
      specialtie_lists_other: json['specialtie_lists_other'] as String?,
      experience_year: json['experience_year'] as String?,
      experience_month: json['experience_month'] as String?,
    );

Map<String, dynamic> _$$ExperienceDTOImplToJson(_$ExperienceDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'specialtie_lists_other': instance.specialtie_lists_other,
      'experience_year': instance.experience_year,
      'experience_month': instance.experience_month,
    };
