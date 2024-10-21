// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerShiftDtoImpl _$$EmployerShiftDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerShiftDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      start_time: (json['start_time'] as num?)?.toInt(),
      start_date: (json['start_date'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      estimated_payables: (json['estimated_payables'] as num?)?.toDouble(),
      total_shifts: (json['total_shifts'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : HiredContractorDTO.fromJson(json['user'] as Map<String, dynamic>),
      total_user: (json['total_user'] as num?)?.toInt(),
      remaining_shift: (json['remaining_shift'] as num?)?.toInt(),
      isdelete: json['isdelete'] as bool?,
    );

Map<String, dynamic> _$$EmployerShiftDtoImplToJson(
        _$EmployerShiftDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listing_id,
      'roles_list_name': instance.roles_list_name,
      'industry': instance.industry,
      'shift_type': instance.shift_type,
      'location': instance.location,
      'start_time': instance.start_time,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'estimated_payables': instance.estimated_payables,
      'total_shifts': instance.total_shifts,
      'user': instance.user,
      'total_user': instance.total_user,
      'remaining_shift': instance.remaining_shift,
      'isdelete': instance.isdelete,
    };

_$HiredContractorDTOImpl _$$HiredContractorDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$HiredContractorDTOImpl(
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$$HiredContractorDTOImplToJson(
        _$HiredContractorDTOImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
    };
