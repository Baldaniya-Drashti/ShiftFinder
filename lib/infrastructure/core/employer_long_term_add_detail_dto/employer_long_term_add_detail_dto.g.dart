// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_long_term_add_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerLongTermAddDetailDtoImpl _$$EmployerLongTermAddDetailDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerLongTermAddDetailDtoImpl(
      start_date: const DateTimeConverter()
          .fromJson((json['start_date'] as num?)?.toInt()),
      end_date: const DateTimeConverter()
          .fromJson((json['end_date'] as num?)?.toInt()),
      applicationDeadline: const DateTimeConverter()
          .fromJson((json['applicationDeadline'] as num?)?.toInt()),
      shift_schedule_type: (json['shift_schedule_type'] as num?)?.toInt(),
      job_description: json['job_description'] as String?,
      requirements: json['requirements'] as String?,
      responsibilities: json['responsibilities'] as String?,
      benefits: json['benefits'] as String?,
      qualifications: json['qualifications'] as String?,
      onboarding_process: json['onboarding_process'] as String?,
      on_call_included: (json['on_call_included'] as num?)?.toInt(),
      licenses_certifications: json['licenses_certifications'] as String?,
      terms_document: json['terms_document'] as String?,
      estimated_weekly_hours: const TimeConverter()
          .fromJson(json['estimated_weekly_hours'] as String?),
      share_team_status: (json['share_team_status'] as num?)?.toInt(),
      employer_payment_confirmation:
          (json['employer_payment_confirmation'] as num?)?.toInt(),
      save_template_status: (json['save_template_status'] as num?)?.toInt(),
      vacancie_type: (json['vacancie_type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$EmployerLongTermAddDetailDtoImplToJson(
        _$EmployerLongTermAddDetailDtoImpl instance) =>
    <String, dynamic>{
      'start_date': const DateTimeConverter().toJson(instance.start_date),
      'end_date': const DateTimeConverter().toJson(instance.end_date),
      'applicationDeadline':
          const DateTimeConverter().toJson(instance.applicationDeadline),
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
      'estimated_weekly_hours':
          const TimeConverter().toJson(instance.estimated_weekly_hours),
      'share_team_status': instance.share_team_status,
      'employer_payment_confirmation': instance.employer_payment_confirmation,
      'save_template_status': instance.save_template_status,
      'vacancie_type': instance.vacancie_type,
    };
