// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DateTimeDTOImpl _$$DateTimeDTOImplFromJson(Map<String, dynamic> json) =>
    _$DateTimeDTOImpl(
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
      objId: (json['objId'] as num?)?.toInt(),
      date: json['date'] as String?,
      startHour: json['startHour'] as String?,
      startMinute: json['startMinute'] as String?,
      endHour: json['endHour'] as String?,
      endMinute: json['endMinute'] as String?,
    );

Map<String, dynamic> _$$DateTimeDTOImplToJson(_$DateTimeDTOImpl instance) =>
    <String, dynamic>{
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'objId': instance.objId,
      'date': instance.date,
      'startHour': instance.startHour,
      'startMinute': instance.startMinute,
      'endHour': instance.endHour,
      'endMinute': instance.endMinute,
    };
