// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SkillDTOImpl _$$SkillDTOImplFromJson(Map<String, dynamic> json) =>
    _$SkillDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      shortName: json['shortName'] as String?,
      answer: (json['answer'] as num?)?.toInt(),
      minute: (json['minute'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SkillDTOImplToJson(_$SkillDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'answer': instance.answer,
      'minute': instance.minute,
    };
