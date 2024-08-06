// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'healthcare_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthcarePostDTOImpl _$$HealthcarePostDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthcarePostDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      last_ago: json['last_ago'] as String?,
      roles_list: (json['roles_list'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialties_detail_list:
          (json['specialties_detail_list'] as List<dynamic>?)
              ?.map((e) => SpecialityDTO.fromJson(e as Map<String, dynamic>))
              .toList(),
      softwares_skill_list: (json['softwares_skill_list'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      software_skill_other: json['software_skill_other'] as String?,
      languages_list: (json['languages_list'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      language_other: json['language_other'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      location_unit: json['location_unit'] as String?,
      rate_hour: (json['rate_hour'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$HealthcarePostDTOImplToJson(
        _$HealthcarePostDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'roles_list': instance.roles_list,
      'specialties_detail_list': instance.specialties_detail_list,
      'softwares_skill_list': instance.softwares_skill_list,
      'software_skill_other': instance.software_skill_other,
      'languages_list': instance.languages_list,
      'language_other': instance.language_other,
      'location': instance.location,
      'location_unit': instance.location_unit,
      'rate_hour': instance.rate_hour,
    };
