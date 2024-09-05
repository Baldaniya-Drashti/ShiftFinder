// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftDetailDTOImpl _$$ShiftDetailDTOImplFromJson(Map<String, dynamic> json) =>
    _$ShiftDetailDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      same_or_different_time: (json['same_or_different_time'] as num?)?.toInt(),
      unpaid_break: json['unpaid_break'] == null
          ? null
          : SkillDTO.fromJson(json['unpaid_break'] as Map<String, dynamic>),
      total_payable_hour: json['total_payable_hour'] as String?,
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      commute_allowance_type_details:
          (json['commute_allowance_type_details'] as num?)?.toInt(),
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      accommodation_allowance_type_details:
          (json['accommodation_allowance_type_details'] as num?)?.toInt(),
      individual_shift: (json['individual_shift'] as num?)?.toInt(),
      shift_note: json['shift_note'] as String?,
      vacancie_type: (json['vacancie_type'] as num?)?.toInt(),
      number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
      pending_vacancie: (json['pending_vacancie'] as num?)?.toInt(),
      recurring_status: (json['recurring_status'] as num?)?.toInt(),
      share_team_status: (json['share_team_status'] as num?)?.toInt(),
      save_template_status: (json['save_template_status'] as num?)?.toInt(),
      disclaimer: json['disclaimer'] as String?,
      teams: (json['teams'] as List<dynamic>?)
          ?.map((e) => SkillDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => ShiftDateDetailDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      payables: json['payables'] == null
          ? null
          : PayableDTO.fromJson(json['payables'] as Map<String, dynamic>),
      date: (json['date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ShiftDetailDTOImplToJson(
        _$ShiftDetailDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shift_type': instance.shift_type,
      'same_or_different_time': instance.same_or_different_time,
      'unpaid_break': instance.unpaid_break,
      'total_payable_hour': instance.total_payable_hour,
      'commute_allowance_type': instance.commute_allowance_type,
      'commute_allowance_type_details': instance.commute_allowance_type_details,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'accommodation_allowance_type_details':
          instance.accommodation_allowance_type_details,
      'individual_shift': instance.individual_shift,
      'shift_note': instance.shift_note,
      'vacancie_type': instance.vacancie_type,
      'number_of_vacancie': instance.number_of_vacancie,
      'pending_vacancie': instance.pending_vacancie,
      'recurring_status': instance.recurring_status,
      'share_team_status': instance.share_team_status,
      'save_template_status': instance.save_template_status,
      'disclaimer': instance.disclaimer,
      'teams': instance.teams,
      'detail': instance.detail,
      'payables': instance.payables,
      'date': instance.date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
    };
