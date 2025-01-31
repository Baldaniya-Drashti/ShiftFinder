// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentShiftDTOImpl _$$CurrentShiftDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$CurrentShiftDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      employer_post_user_id: (json['employer_post_user_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      last_ago: json['last_ago'] as String?,
      industry_id: (json['industry_id'] as num?)?.toInt(),
      distance: json['distance'] as String?,
      roles_list: (json['roles_list'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      company_name: json['company_name'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      specialties_detail_list:
          (json['specialties_detail_list'] as List<dynamic>?)
              ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
              .toList(),
      softwares_skill_list: (json['softwares_skill_list'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      software_skill_other: json['software_skill_other'] as String?,
      specialties_detail_other: json['specialties_detail_other'] as String?,
      languages_list: (json['languages_list'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      language_other: json['language_other'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      location_unit: json['location_unit'] as String?,
      remaining_shifts: (json['remaining_shifts'] as num?)?.toInt(),
      rate_hour: (json['rate_hour'] as num?)?.toDouble(),
      shift_detail: json['shift_detail'] == null
          ? null
          : ShiftDetailDTO.fromJson(
              json['shift_detail'] as Map<String, dynamic>),
      software_skill: json['software_skill'] as String?,
      specialties_detail: json['specialties_detail'] as String?,
      clock_in: (json['clock_in'] as num?)?.toInt(),
      clock_out: (json['clock_out'] as num?)?.toInt(),
      selectedClockInTime: (json['selectedClockInTime'] as num?)?.toInt(),
      selectedClockOutTime: (json['selectedClockOutTime'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CurrentShiftDTOImplToJson(
        _$CurrentShiftDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'employer_post_user_id': instance.employer_post_user_id,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'industry_id': instance.industry_id,
      'distance': instance.distance,
      'roles_list': instance.roles_list,
      'company_name': instance.company_name,
      'roles_list_name': instance.roles_list_name,
      'specialties_detail_list': instance.specialties_detail_list,
      'softwares_skill_list': instance.softwares_skill_list,
      'software_skill_other': instance.software_skill_other,
      'specialties_detail_other': instance.specialties_detail_other,
      'languages_list': instance.languages_list,
      'language_other': instance.language_other,
      'location': instance.location,
      'location_unit': instance.location_unit,
      'remaining_shifts': instance.remaining_shifts,
      'rate_hour': instance.rate_hour,
      'shift_detail': instance.shift_detail,
      'software_skill': instance.software_skill,
      'specialties_detail': instance.specialties_detail,
      'clock_in': instance.clock_in,
      'clock_out': instance.clock_out,
      'selectedClockInTime': instance.selectedClockInTime,
      'selectedClockOutTime': instance.selectedClockOutTime,
    };
