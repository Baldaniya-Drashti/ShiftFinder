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
      unpaid_break: json['unpaid_break'] as String?,
      estimated_payables: (json['estimated_payables'] as num?)?.toDouble(),
      formatted_payables: json['formatted_payables'] as String?,
      total_shifts: (json['total_shifts'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      user: json['user'] == null
          ? null
          : HiredContractorDTO.fromJson(json['user'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => HiredContractorDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_user: (json['total_user'] as num?)?.toInt(),
      hired_user: (json['hired_user'] as num?)?.toInt(),
      remaining_shift: (json['remaining_shift'] as num?)?.toInt(),
      isdelete: json['isdelete'] as bool?,
      compassion: (json['compassion'] as num?)?.toInt(),
      cancel_shift: (json['cancel_shift'] as num?)?.toInt(),
      total_contractor: (json['total_contractor'] as num?)?.toInt(),
      isCad: json['isCad'] as bool?,
      reason: json['reason'] as String?,
      contractor_shift_type: (json['contractor_shift_type'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
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
      'unpaid_break': instance.unpaid_break,
      'estimated_payables': instance.estimated_payables,
      'formatted_payables': instance.formatted_payables,
      'total_shifts': instance.total_shifts,
      'total_shift': instance.total_shift,
      'user': instance.user,
      'users': instance.users,
      'total_user': instance.total_user,
      'hired_user': instance.hired_user,
      'remaining_shift': instance.remaining_shift,
      'isdelete': instance.isdelete,
      'compassion': instance.compassion,
      'cancel_shift': instance.cancel_shift,
      'total_contractor': instance.total_contractor,
      'isCad': instance.isCad,
      'reason': instance.reason,
      'contractor_shift_type': instance.contractor_shift_type,
      'count': instance.count,
    };

_$HiredContractorDTOImpl _$$HiredContractorDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$HiredContractorDTOImpl(
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$HiredContractorDTOImplToJson(
        _$HiredContractorDTOImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'reason': instance.reason,
    };
