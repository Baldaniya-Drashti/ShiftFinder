// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EducationDTOImpl _$$EducationDTOImplFromJson(Map<String, dynamic> json) =>
    _$EducationDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      program_completed: json['program_completed'] as String?,
      year_of_completion: json['year_of_completion'] as String?,
      graduating_institution: json['graduating_institution'] as String?,
    );

Map<String, dynamic> _$$EducationDTOImplToJson(_$EducationDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'program_completed': instance.program_completed,
      'year_of_completion': instance.year_of_completion,
      'graduating_institution': instance.graduating_institution,
    };
