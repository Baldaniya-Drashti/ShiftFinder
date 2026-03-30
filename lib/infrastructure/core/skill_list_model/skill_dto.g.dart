// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillDTOImpl _$$SkillDTOImplFromJson(Map<String, dynamic> json) =>
    _$SkillDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      short_name: json['short_name'] as String?,
      answer: (json['answer'] as num?)?.toInt(),
      minute: (json['minute'] as num?)?.toInt(),
      isMandatory: json['isMandatory'] as bool?,
      yearLimit: json['yearLimit'] as String?,
    );

Map<String, dynamic> _$$SkillDTOImplToJson(_$SkillDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_name': instance.short_name,
      'answer': instance.answer,
      'minute': instance.minute,
      'isMandatory': instance.isMandatory,
      'yearLimit': instance.yearLimit,
    };
