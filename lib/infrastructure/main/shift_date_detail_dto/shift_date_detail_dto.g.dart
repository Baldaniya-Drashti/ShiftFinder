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
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      days: json['days'] as String?,
    );

Map<String, dynamic> _$$ShiftDateDetailDTOImplToJson(
        _$ShiftDateDetailDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recurrence_mode': instance.recurrence_mode,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'days': instance.days,
    };
