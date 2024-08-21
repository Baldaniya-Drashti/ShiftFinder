// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'performance_insight_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PerformanceInsightDTOImpl _$$PerformanceInsightDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$PerformanceInsightDTOImpl(
      date: (json['date'] as num?)?.toInt(),
      total_earnings: (json['total_earnings'] as num?)?.toDouble(),
      total_hours: json['total_hours'] as String?,
      completed_shifts: (json['completed_shifts'] as num?)?.toInt(),
      earning_over_time: json['earning_over_time'] == null
          ? null
          : EarningOverTimeDTO.fromJson(
              json['earning_over_time'] as Map<String, dynamic>),
      hours_worked: json['hours_worked'] == null
          ? null
          : HourWorkedDTO.fromJson(
              json['hours_worked'] as Map<String, dynamic>),
      completed_shift_map: json['completed_shift_map'] == null
          ? null
          : CompletedShiftMapDTO.fromJson(
              json['completed_shift_map'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PerformanceInsightDTOImplToJson(
        _$PerformanceInsightDTOImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'total_earnings': instance.total_earnings,
      'total_hours': instance.total_hours,
      'completed_shifts': instance.completed_shifts,
      'earning_over_time': instance.earning_over_time,
      'hours_worked': instance.hours_worked,
      'completed_shift_map': instance.completed_shift_map,
    };

_$EarningOverTimeDTOImpl _$$EarningOverTimeDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$EarningOverTimeDTOImpl(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => InsightListDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      heights:
          (json['heights'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$EarningOverTimeDTOImplToJson(
        _$EarningOverTimeDTOImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'heights': instance.heights,
    };

_$InsightListDTOImpl _$$InsightListDTOImplFromJson(Map<String, dynamic> json) =>
    _$InsightListDTOImpl(
      name: json['name'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$InsightListDTOImplToJson(
        _$InsightListDTOImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

_$HourWorkedDetailDTOImpl _$$HourWorkedDetailDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$HourWorkedDetailDTOImpl(
      name: json['name'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$HourWorkedDetailDTOImplToJson(
        _$HourWorkedDetailDTOImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

_$HourWorkedDTOImpl _$$HourWorkedDTOImplFromJson(Map<String, dynamic> json) =>
    _$HourWorkedDTOImpl(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => HourWorkedDetailDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      heights:
          (json['heights'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$HourWorkedDTOImplToJson(_$HourWorkedDTOImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'heights': instance.heights,
    };

_$CompletedShiftMapDTOImpl _$$CompletedShiftMapDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$CompletedShiftMapDTOImpl(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => InsightListDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      heights: (json['heights'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$CompletedShiftMapDTOImplToJson(
        _$CompletedShiftMapDTOImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'heights': instance.heights,
    };
