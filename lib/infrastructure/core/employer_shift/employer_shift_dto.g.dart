// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerShiftDtoImpl _$$EmployerShiftDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerShiftDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      industry: (json['industry'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      start_date: (json['start_date'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      estimated_payables: json['estimated_payables'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      total_shifts: (json['total_shifts'] as num?)?.toInt(),
      total_user: (json['total_user'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      remaining_shift: (json['remaining_shift'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      isdelete: json['isdelete'] as bool?,
    );

Map<String, dynamic> _$$EmployerShiftDtoImplToJson(
        _$EmployerShiftDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shift_type': instance.shift_type,
      'industry': instance.industry,
      'start_time': instance.start_time,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'estimated_payables': instance.estimated_payables,
      'roles_list_name': instance.roles_list_name,
      'total_shifts': instance.total_shifts,
      'total_user': instance.total_user,
      'location': instance.location,
      'remaining_shift': instance.remaining_shift,
      'listing_id': instance.listing_id,
      'isdelete': instance.isdelete,
    };
