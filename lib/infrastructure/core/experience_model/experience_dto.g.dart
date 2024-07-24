// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExperienceDTOImpl _$$ExperienceDTOImplFromJson(Map<String, dynamic> json) =>
    _$ExperienceDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      experience_year: json['experience_year'] as String?,
      experience_month: json['experience_month'] as String?,
    );

Map<String, dynamic> _$$ExperienceDTOImplToJson(_$ExperienceDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'experience_year': instance.experience_year,
      'experience_month': instance.experience_month,
    };
