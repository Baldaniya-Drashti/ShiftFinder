// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostShiftDTOImpl _$$PostShiftDTOImplFromJson(Map<String, dynamic> json) =>
    _$PostShiftDTOImpl(
      roles_list_id: json['roles_list_id'] as String?,
      specialties_detail_id: json['specialties_detail_id'] as String?,
      specialties_detail_other: json['specialties_detail_other'] as String?,
      softwares_skill_list_id: json['softwares_skill_list_id'] as String?,
      software_skill_other: json['software_skill_other'] as String?,
      languages_list_id: json['languages_list_id'] as String?,
      language_other: json['language_other'] as String?,
      location_id: json['location_id'] as String?,
      location_unit: json['location_unit'] as String?,
      rate_hour: (json['rate_hour'] as num?)?.toDouble(),
      shiftDetail: json['shiftDetail'] == null
          ? null
          : MultiShiftDTO.fromJson(json['shiftDetail'] as Map<String, dynamic>),
      post_shift_id: (json['post_shift_id'] as num?)?.toInt(),
      recurring_status: (json['recurring_status'] as num?)?.toInt(),
      start_date: json['start_date'] as String?,
      recurrence_mode: (json['recurrence_mode'] as num?)?.toInt(),
      days: json['days'] as String?,
      end_date: json['end_date'] as String?,
      disclaimer: json['disclaimer'] as String?,
      share_team_status: (json['share_team_status'] as num?)?.toInt(),
      team_id: json['team_id'] as String?,
      save_template_status: (json['save_template_status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PostShiftDTOImplToJson(_$PostShiftDTOImpl instance) =>
    <String, dynamic>{
      'roles_list_id': instance.roles_list_id,
      'specialties_detail_id': instance.specialties_detail_id,
      'specialties_detail_other': instance.specialties_detail_other,
      'softwares_skill_list_id': instance.softwares_skill_list_id,
      'software_skill_other': instance.software_skill_other,
      'languages_list_id': instance.languages_list_id,
      'language_other': instance.language_other,
      'location_id': instance.location_id,
      'location_unit': instance.location_unit,
      'rate_hour': instance.rate_hour,
      'shiftDetail': instance.shiftDetail,
      'post_shift_id': instance.post_shift_id,
      'recurring_status': instance.recurring_status,
      'start_date': instance.start_date,
      'recurrence_mode': instance.recurrence_mode,
      'days': instance.days,
      'end_date': instance.end_date,
      'disclaimer': instance.disclaimer,
      'share_team_status': instance.share_team_status,
      'team_id': instance.team_id,
      'save_template_status': instance.save_template_status,
    };
