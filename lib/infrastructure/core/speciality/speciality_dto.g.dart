// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpecialityDTOImpl _$$SpecialityDTOImplFromJson(Map<String, dynamic> json) =>
    _$SpecialityDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      shortName: json['shortName'] as String?,
      experienceId: (json['experienceId'] as num?)?.toInt(),
      specialityExperience: json['specialityExperience'] as String?,
      specialityOther: json['specialityOther'] as String?,
      specialtie_lists: json['specialtie_lists'] == null
          ? null
          : SkillDTO.fromJson(json['specialtie_lists'] as Map<String, dynamic>),
      experience_lists: json['experience_lists'] == null
          ? null
          : SkillDTO.fromJson(json['experience_lists'] as Map<String, dynamic>),
      specialtie_lists_other: json['specialtie_lists_other'] as String?,
      experience_other: json['experience_other'] as String?,
    );

Map<String, dynamic> _$$SpecialityDTOImplToJson(_$SpecialityDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'experienceId': instance.experienceId,
      'specialityExperience': instance.specialityExperience,
      'specialityOther': instance.specialityOther,
      'specialtie_lists': instance.specialtie_lists,
      'experience_lists': instance.experience_lists,
      'specialtie_lists_other': instance.specialtie_lists_other,
      'experience_other': instance.experience_other,
    };
