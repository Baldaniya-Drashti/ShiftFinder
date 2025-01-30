// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_calendar_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyCalendarDTOImpl _$$MyCalendarDTOImplFromJson(Map<String, dynamic> json) =>
    _$MyCalendarDTOImpl(
      employer_post_id: json['employer_post_id'] as String?,
      date: (json['date'] as num?)?.toInt(),
      isUnAvailable: json['isUnAvailable'] as bool? ?? false,
      colorText: json['colorText'] as String?,
    );

Map<String, dynamic> _$$MyCalendarDTOImplToJson(_$MyCalendarDTOImpl instance) =>
    <String, dynamic>{
      'employer_post_id': instance.employer_post_id,
      'date': instance.date,
      'isUnAvailable': instance.isUnAvailable,
      'colorText': instance.colorText,
    };

_$ContractorMyCalendarListDTOImpl _$$ContractorMyCalendarListDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ContractorMyCalendarListDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      employer_user_id: (json['employer_user_id'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      application_id: (json['application_id'] as num?)?.toInt(),
      roles_list_name: json['roles_list_name'] as String?,
      company_name: json['company_name'] as String?,
      industry_id: (json['industry_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      distance: json['distance'] as String?,
      date: (json['date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ContractorMyCalendarListDTOImplToJson(
        _$ContractorMyCalendarListDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employer_user_id': instance.employer_user_id,
      'shift_type': instance.shift_type,
      'application_id': instance.application_id,
      'roles_list_name': instance.roles_list_name,
      'company_name': instance.company_name,
      'industry_id': instance.industry_id,
      'listing_id': instance.listing_id,
      'location': instance.location,
      'distance': instance.distance,
      'date': instance.date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'total_shift': instance.total_shift,
    };

_$ContractorMyCalendarDTOImpl _$$ContractorMyCalendarDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ContractorMyCalendarDTOImpl(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) =>
              ContractorMyCalendarListDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      current_date: (json['current_date'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ContractorMyCalendarDTOImplToJson(
        _$ContractorMyCalendarDTOImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'current_date': instance.current_date,
    };
