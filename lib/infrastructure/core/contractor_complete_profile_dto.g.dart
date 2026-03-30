// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_complete_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorCompleteProfileDTOImpl _$$ContractorCompleteProfileDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ContractorCompleteProfileDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      roles_list: (json['roles_list'] as List<dynamic>?)
          ?.map((e) => ExperienceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialties_detail: (json['specialties_detail'] as List<dynamic>?)
          ?.map((e) => ExperienceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      softwares_skill_list: (json['softwares_skill_list'] as List<dynamic>?)
          ?.map((e) => ExperienceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      software_skill_other: json['software_skill_other'] as String?,
      specialties_other: json['specialties_other'] as String?,
      languages_list: (json['languages_list'] as List<dynamic>?)
          ?.map((e) => ExperienceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      language_other: json['language_other'] as String?,
    );

Map<String, dynamic> _$$ContractorCompleteProfileDTOImplToJson(
        _$ContractorCompleteProfileDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roles_list': instance.roles_list,
      'specialties_detail': instance.specialties_detail,
      'softwares_skill_list': instance.softwares_skill_list,
      'software_skill_other': instance.software_skill_other,
      'specialties_other': instance.specialties_other,
      'languages_list': instance.languages_list,
      'language_other': instance.language_other,
    };
