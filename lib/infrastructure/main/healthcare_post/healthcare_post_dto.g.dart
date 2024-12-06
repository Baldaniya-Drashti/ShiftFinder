// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'healthcare_post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthcarePostDTOImpl _$$HealthcarePostDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthcarePostDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      last_ago: json['last_ago'] as String?,
      company_name: json['company_name'] as String?,
      distance: json['distance'] as String?,
      roles_list: (json['roles_list'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      rate_hour: (json['rate_hour'] as num?)?.toDouble(),
      shift_detail: json['shift_detail'] == null
          ? null
          : ShiftDetailDTO.fromJson(
              json['shift_detail'] as Map<String, dynamic>),
      software_skill: json['software_skill'] as String?,
      specialties_detail: json['specialties_detail'] as String?,
      proposal_received: json['proposal_received'] == null
          ? null
          : ProposalReceivedDTO.fromJson(
              json['proposal_received'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HealthcarePostDTOImplToJson(
        _$HealthcarePostDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'company_name': instance.company_name,
      'distance': instance.distance,
      'roles_list': instance.roles_list,
      'roles_list_name': instance.roles_list_name,
      'specialties_detail_list': instance.specialties_detail_list,
      'softwares_skill_list': instance.softwares_skill_list,
      'software_skill_other': instance.software_skill_other,
      'specialties_detail_other': instance.specialties_detail_other,
      'languages_list': instance.languages_list,
      'language_other': instance.language_other,
      'location': instance.location,
      'location_unit': instance.location_unit,
      'rate_hour': instance.rate_hour,
      'shift_detail': instance.shift_detail,
      'software_skill': instance.software_skill,
      'specialties_detail': instance.specialties_detail,
      'proposal_received': instance.proposal_received,
    };

_$ProposalReceivedDTOImpl _$$ProposalReceivedDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ProposalReceivedDTOImpl(
      proposed_hourly_rate: (json['proposed_hourly_rate'] as num?)?.toDouble(),
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      proposed_commute_allowance:
          (json['proposed_commute_allowance'] as num?)?.toDouble(),
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      proposed_accommodation_allowance:
          (json['proposed_accommodation_allowance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ProposalReceivedDTOImplToJson(
        _$ProposalReceivedDTOImpl instance) =>
    <String, dynamic>{
      'proposed_hourly_rate': instance.proposed_hourly_rate,
      'commute_allowance_type': instance.commute_allowance_type,
      'proposed_commute_allowance': instance.proposed_commute_allowance,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'proposed_accommodation_allowance':
          instance.proposed_accommodation_allowance,
    };
