// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_proposal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerProposalDtoImpl _$$EmployerProposalDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerProposalDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      last_ago: json['last_ago'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      complete_shift: (json['complete_shift'] as num?)?.toInt(),
      pending_users: (json['pending_users'] as List<dynamic>?)
          ?.map((e) => EmployerProposalPendingUserDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EmployerProposalDtoImplToJson(
        _$EmployerProposalDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'roles_list_name': instance.roles_list_name,
      'industry': instance.industry,
      'shift_type': instance.shift_type,
      'location': instance.location,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'total_shift': instance.total_shift,
      'complete_shift': instance.complete_shift,
      'pending_users': instance.pending_users,
    };

_$EmployerProposalPendingUserDtoImpl
    _$$EmployerProposalPendingUserDtoImplFromJson(Map<String, dynamic> json) =>
        _$EmployerProposalPendingUserDtoImpl(
          id: (json['id'] as num?)?.toInt(),
          first_name: json['first_name'] as String?,
          last_name: json['last_name'] as String?,
          profile: json['profile'] as String?,
          user_id: (json['user_id'] as num?)?.toInt(),
          last_request: (json['last_request'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$EmployerProposalPendingUserDtoImplToJson(
        _$EmployerProposalPendingUserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'user_id': instance.user_id,
      'last_request': instance.last_request,
    };
