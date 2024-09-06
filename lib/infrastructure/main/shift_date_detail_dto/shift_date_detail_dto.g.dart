// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_date_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShiftDateDetailDTOImpl _$$ShiftDateDetailDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ShiftDateDetailDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      recurrence_mode: (json['recurrence_mode'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      date: (json['date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      days: json['days'] as String?,
      objId: (json['objId'] as num?)?.toInt(),
      startHour: json['startHour'] as String?,
      startMinute: json['startMinute'] as String?,
      endHour: json['endHour'] as String?,
      endMinute: json['endMinute'] as String?,
      totalPaybleHours: json['totalPaybleHours'] as String?,
      unpaid_break: json['unpaid_break'] == null
          ? null
          : SkillDTO.fromJson(json['unpaid_break'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ShiftDateDetailDTOImplToJson(
        _$ShiftDateDetailDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recurrence_mode': instance.recurrence_mode,
      'start_time': instance.start_time,
      'date': instance.date,
      'end_time': instance.end_time,
      'days': instance.days,
      'objId': instance.objId,
      'startHour': instance.startHour,
      'startMinute': instance.startMinute,
      'endHour': instance.endHour,
      'endMinute': instance.endMinute,
      'totalPaybleHours': instance.totalPaybleHours,
      'unpaid_break': instance.unpaid_break,
    };
