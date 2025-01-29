// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_long_term_success_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerLongTermSuccessDtoImpl _$$EmployerLongTermSuccessDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerLongTermSuccessDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      languages_list_id: json['languages_list_id'] as String?,
      post_type: (json['post_type'] as num?)?.toInt(),
      location_id: json['location_id'] as String?,
      last_ago: json['last_ago'] as String?,
      company_name: json['company_name'] as String?,
      roles_list_id: json['roles_list_id'] as String?,
      specialties_detail_id: json['specialties_detail_id'] as String?,
      softwares_skill_list_id: json['softwares_skill_list_id'] as String?,
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
      team_id: json['team_id'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      location_unit: json['location_unit'] as String?,
      rate_hour: json['rate_hour'] as num?,
      software_skill: json['software_skill'] as String?,
      specialties_detail: json['specialties_detail'] as String?,
      reason: json['reason'] as String?,
      monthly_service_fee: json['monthly_service_fee'] as String?,
      total_amount_payable: json['total_amount_payable'] as String?,
      total_months: (json['total_months'] as num?)?.toInt(),
      number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
      start_date: const DateTimeConverter()
          .fromJson((json['start_date'] as num?)?.toInt()),
      end_date: const DateTimeConverter()
          .fromJson((json['end_date'] as num?)?.toInt()),
      application_deadline: const DateTimeConverter()
          .fromJson((json['application_deadline'] as num?)?.toInt()),
      shift_schedule_type: json['shift_schedule_type'] as String?,
      job_description: json['job_description'] as String?,
      requirements: json['requirements'] as String?,
      responsibilities: json['responsibilities'] as String?,
      benefits: json['benefits'] as String?,
      qualifications: json['qualifications'] as String?,
      onboarding_process: json['onboarding_process'] as String?,
      on_call_included: (json['on_call_included'] as num?)?.toInt() ?? 0,
      licenses_certifications: json['licenses_certifications'] as String?,
      terms_document: json['terms_document'] as String?,
      terms: json['terms'] as String?,
      estimated_weekly_hours: const TimeConverter()
          .fromJson(json['estimated_weekly_hours'] as String?),
      share_team_status: (json['share_team_status'] as num?)?.toInt() ?? 0,
      employer_payment_confirmation:
          (json['employer_payment_confirmation'] as num?)?.toInt() ?? 0,
      save_template_status:
          (json['save_template_status'] as num?)?.toInt() ?? 0,
      vacancie_type: (json['vacancie_type'] as num?)?.toInt() ?? 0,
      job_type: (json['job_type'] as num?)?.toInt(),
      industry: (json['industry'] as num?)?.toInt(),
      total_teams: (json['total_teams'] as num?)?.toInt(),
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => TeamDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] as String?,
      compensation_type: (json['compensation_type'] as num?)?.toInt(),
      job_summary: json['job_summary'] as String?,
      external_internal_relationships:
          json['external_internal_relationships'] as String?,
      experience: json['experience'] as String?,
      skills: json['skills'] as String?,
      other: json['other'] as String?,
      union_bargaining_unit: json['union_bargaining_unit'] as String?,
      compensation_package: json['compensation_package'] as String?,
    );

Map<String, dynamic> _$$EmployerLongTermSuccessDtoImplToJson(
        _$EmployerLongTermSuccessDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'user_id': instance.user_id,
      'listing_id': instance.listing_id,
      'languages_list_id': instance.languages_list_id,
      'post_type': instance.post_type,
      'location_id': instance.location_id,
      'last_ago': instance.last_ago,
      'company_name': instance.company_name,
      'roles_list_id': instance.roles_list_id,
      'specialties_detail_id': instance.specialties_detail_id,
      'softwares_skill_list_id': instance.softwares_skill_list_id,
      'distance': instance.distance,
      'roles_list': instance.roles_list,
      'roles_list_name': instance.roles_list_name,
      'specialties_detail_list': instance.specialties_detail_list,
      'softwares_skill_list': instance.softwares_skill_list,
      'software_skill_other': instance.software_skill_other,
      'specialties_detail_other': instance.specialties_detail_other,
      'languages_list': instance.languages_list,
      'language_other': instance.language_other,
      'team_id': instance.team_id,
      'location': instance.location,
      'location_unit': instance.location_unit,
      'rate_hour': instance.rate_hour,
      'software_skill': instance.software_skill,
      'specialties_detail': instance.specialties_detail,
      'reason': instance.reason,
      'monthly_service_fee': instance.monthly_service_fee,
      'total_amount_payable': instance.total_amount_payable,
      'total_months': instance.total_months,
      'number_of_vacancie': instance.number_of_vacancie,
      'start_date': const DateTimeConverter().toJson(instance.start_date),
      'end_date': const DateTimeConverter().toJson(instance.end_date),
      'application_deadline':
          const DateTimeConverter().toJson(instance.application_deadline),
      'shift_schedule_type': instance.shift_schedule_type,
      'job_description': instance.job_description,
      'requirements': instance.requirements,
      'responsibilities': instance.responsibilities,
      'benefits': instance.benefits,
      'qualifications': instance.qualifications,
      'onboarding_process': instance.onboarding_process,
      'on_call_included': instance.on_call_included,
      'licenses_certifications': instance.licenses_certifications,
      'terms_document': instance.terms_document,
      'terms': instance.terms,
      'estimated_weekly_hours':
          const TimeConverter().toJson(instance.estimated_weekly_hours),
      'share_team_status': instance.share_team_status,
      'employer_payment_confirmation': instance.employer_payment_confirmation,
      'save_template_status': instance.save_template_status,
      'vacancie_type': instance.vacancie_type,
      'job_type': instance.job_type,
      'industry': instance.industry,
      'total_teams': instance.total_teams,
      'teams': instance.teams,
      'position': instance.position,
      'compensation_type': instance.compensation_type,
      'job_summary': instance.job_summary,
      'external_internal_relationships':
          instance.external_internal_relationships,
      'experience': instance.experience,
      'skills': instance.skills,
      'other': instance.other,
      'union_bargaining_unit': instance.union_bargaining_unit,
      'compensation_package': instance.compensation_package,
    };
