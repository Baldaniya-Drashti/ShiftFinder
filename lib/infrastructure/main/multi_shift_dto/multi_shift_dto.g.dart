// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MultiShiftDTOImpl _$$MultiShiftDTOImplFromJson(Map<String, dynamic> json) =>
    _$MultiShiftDTOImpl(
      post_id: (json['post_id'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      date: json['date'] as String?,
      same_or_different_time: (json['same_or_different_time'] as num?)?.toInt(),
      multi_date: (json['multi_date'] as List<dynamic>?)
          ?.map((e) => DateTimeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
      unpaid_break_id: (json['unpaid_break_id'] as num?)?.toInt(),
      total_payable_hour: json['total_payable_hour'] as String?,
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      commute_allowance: json['commute_allowance'] as String?,
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      accommodation_allowance: json['accommodation_allowance'] as String?,
      individual_shift: (json['individual_shift'] as num?)?.toInt(),
      shift_note: json['shift_note'] as String?,
      vacancie_type: (json['vacancie_type'] as num?)?.toInt(),
      number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
      script_volume: (json['script_volume'] as num?)?.toInt(),
      assistant_on_site: (json['assistant_on_site'] as num?)?.toInt(),
      technician_on_site: (json['technician_on_site'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MultiShiftDTOImplToJson(_$MultiShiftDTOImpl instance) =>
    <String, dynamic>{
      'post_id': instance.post_id,
      'shift_type': instance.shift_type,
      'date': instance.date,
      'same_or_different_time': instance.same_or_different_time,
      'multi_date': instance.multi_date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'unpaid_break_id': instance.unpaid_break_id,
      'total_payable_hour': instance.total_payable_hour,
      'commute_allowance_type': instance.commute_allowance_type,
      'commute_allowance': instance.commute_allowance,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'accommodation_allowance': instance.accommodation_allowance,
      'individual_shift': instance.individual_shift,
      'shift_note': instance.shift_note,
      'vacancie_type': instance.vacancie_type,
      'number_of_vacancie': instance.number_of_vacancie,
      'script_volume': instance.script_volume,
      'assistant_on_site': instance.assistant_on_site,
      'technician_on_site': instance.technician_on_site,
    };
