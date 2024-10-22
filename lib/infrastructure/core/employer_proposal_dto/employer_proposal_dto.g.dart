// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_proposal_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployerProposalDtoImpl _$$EmployerProposalDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployerProposalDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      listing_id: json['listing_id'] as String?,
      user_id: (json['user_id'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      last_ago: json['last_ago'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      complete_shift: (json['complete_shift'] as num?)?.toInt(),
      pending_users: (json['pending_users'] as List<dynamic>?)
          ?.map((e) => EmployerProposalPendingUserDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      distance: json['distance'] as String?,
      post_id: (json['post_id'] as num?)?.toInt(),
      proposal_type: (json['proposal_type'] as num?)?.toInt(),
      last_request: (json['last_request'] as num?)?.toInt(),
      revoke_status: (json['revoke_status'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      same_or_different_time: (json['same_or_different_time'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      start_date: (json['start_date'] as num?)?.toInt(),
      counter_proposal_hourly_rate:
          (json['counter_proposal_hourly_rate'] as num?)?.toInt(),
      counter_proposal_commute_allowance:
          (json['counter_proposal_commute_allowance'] as num?)?.toInt(),
      counter_proposal_accommodation_allowance:
          (json['counter_proposal_accommodation_allowance'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      posted_start_time: (json['posted_start_time'] as num?)?.toInt(),
      posted_end_time: (json['posted_end_time'] as num?)?.toInt(),
      agreed_start_time: (json['agreed_start_time'] as num?)?.toInt(),
      agreed_end_time: (json['agreed_end_time'] as num?)?.toInt(),
      posted_hourly_rate: (json['posted_hourly_rate'] as num?)?.toInt(),
      proposed_hourly_rate: (json['proposed_hourly_rate'] as num?)?.toInt(),
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      posted_commute_allowance_rate:
          (json['posted_commute_allowance_rate'] as num?)?.toInt(),
      posted_commute_allowance_hour_id:
          (json['posted_commute_allowance_hour_id'] as num?)?.toInt(),
      proposed_commute_allowance_rate:
          (json['proposed_commute_allowance_rate'] as num?)?.toInt(),
      proposed_commute_allowance_hour_id:
          (json['proposed_commute_allowance_hour_id'] as num?)?.toInt(),
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      posted_accommodation_allowance_rate:
          (json['posted_accommodation_allowance_rate'] as num?)?.toInt(),
      posted_accommodation_allowance_hour_id:
          (json['posted_accommodation_allowance_hour_id'] as num?)?.toInt(),
      proposed_accommodation_allowance_rate:
          (json['proposed_accommodation_allowance_rate'] as num?)?.toInt(),
      proposed_accommodation_allowance_hour_id:
          (json['proposed_accommodation_allowance_hour_id'] as num?)?.toInt(),
      proposed_accommodation_allowance_hour_name:
          json['proposed_accommodation_allowance_hour_name'] as String?,
      posted_accommodation_allowance_hour_name:
          json['posted_accommodation_allowance_hour_name'] as String?,
      proposed_commute_allowance_hour_name:
          json['proposed_commute_allowance_hour_name'] as String?,
      posted_commute_allowance_hour_name:
          json['posted_commute_allowance_hour_name'] as String?,
      shift_details: (json['shift_details'] as List<dynamic>?)
          ?.map((e) => EmployerProposalShiftDetailDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$EmployerProposalDtoImplToJson(
        _$EmployerProposalDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'listing_id': instance.listing_id,
      'user_id': instance.user_id,
      'profile': instance.profile,
      'last_ago': instance.last_ago,
      'roles_list_name': instance.roles_list_name,
      'industry': instance.industry,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'complete_shift': instance.complete_shift,
      'pending_users': instance.pending_users,
      'location': instance.location,
      'distance': instance.distance,
      'post_id': instance.post_id,
      'proposal_type': instance.proposal_type,
      'last_request': instance.last_request,
      'revoke_status': instance.revoke_status,
      'shift_type': instance.shift_type,
      'same_or_different_time': instance.same_or_different_time,
      'total_shift': instance.total_shift,
      'start_date': instance.start_date,
      'counter_proposal_hourly_rate': instance.counter_proposal_hourly_rate,
      'counter_proposal_commute_allowance':
          instance.counter_proposal_commute_allowance,
      'counter_proposal_accommodation_allowance':
          instance.counter_proposal_accommodation_allowance,
      'end_date': instance.end_date,
      'posted_start_time': instance.posted_start_time,
      'posted_end_time': instance.posted_end_time,
      'agreed_start_time': instance.agreed_start_time,
      'agreed_end_time': instance.agreed_end_time,
      'posted_hourly_rate': instance.posted_hourly_rate,
      'proposed_hourly_rate': instance.proposed_hourly_rate,
      'commute_allowance_type': instance.commute_allowance_type,
      'posted_commute_allowance_rate': instance.posted_commute_allowance_rate,
      'posted_commute_allowance_hour_id':
          instance.posted_commute_allowance_hour_id,
      'proposed_commute_allowance_rate':
          instance.proposed_commute_allowance_rate,
      'proposed_commute_allowance_hour_id':
          instance.proposed_commute_allowance_hour_id,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'posted_accommodation_allowance_rate':
          instance.posted_accommodation_allowance_rate,
      'posted_accommodation_allowance_hour_id':
          instance.posted_accommodation_allowance_hour_id,
      'proposed_accommodation_allowance_rate':
          instance.proposed_accommodation_allowance_rate,
      'proposed_accommodation_allowance_hour_id':
          instance.proposed_accommodation_allowance_hour_id,
      'proposed_accommodation_allowance_hour_name':
          instance.proposed_accommodation_allowance_hour_name,
      'posted_accommodation_allowance_hour_name':
          instance.posted_accommodation_allowance_hour_name,
      'proposed_commute_allowance_hour_name':
          instance.proposed_commute_allowance_hour_name,
      'posted_commute_allowance_hour_name':
          instance.posted_commute_allowance_hour_name,
      'shift_details': instance.shift_details,
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
          revoke_status: (json['revoke_status'] as num?)?.toInt(),
          revoke_start: (json['revoke_start'] as num?)?.toInt(),
          duration: json['duration'] == null
              ? null
              : Duration(microseconds: (json['duration'] as num).toInt()),
          sent_received_status: (json['sent_received_status'] as num?)?.toInt(),
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
      'revoke_status': instance.revoke_status,
      'revoke_start': instance.revoke_start,
      'duration': instance.duration?.inMicroseconds,
      'sent_received_status': instance.sent_received_status,
    };

_$EmployerProposalShiftDetailDtoImpl
    _$$EmployerProposalShiftDetailDtoImplFromJson(Map<String, dynamic> json) =>
        _$EmployerProposalShiftDetailDtoImpl(
          id: (json['id'] as num?)?.toInt(),
          start_date: (json['start_date'] as num?)?.toInt(),
          posted_start_time: (json['posted_start_time'] as num?)?.toInt(),
          posted_end_time: (json['posted_end_time'] as num?)?.toInt(),
          proposed_start_time: (json['proposed_start_time'] as num?)?.toInt(),
          proposed_end_time: (json['proposed_end_time'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$EmployerProposalShiftDetailDtoImplToJson(
        _$EmployerProposalShiftDetailDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.start_date,
      'posted_start_time': instance.posted_start_time,
      'posted_end_time': instance.posted_end_time,
      'proposed_start_time': instance.proposed_start_time,
      'proposed_end_time': instance.proposed_end_time,
    };
