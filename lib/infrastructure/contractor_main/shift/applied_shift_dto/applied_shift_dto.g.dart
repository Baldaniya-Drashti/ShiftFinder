// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppliedShiftDTOImpl _$$AppliedShiftDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$AppliedShiftDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      employer_post_user_id: (json['employer_post_user_id'] as num?)?.toInt(),
      role_lists_name: json['role_lists_name'] as String?,
      company_name: json['company_name'] as String?,
      profile: json['profile'] as String?,
      industry_id: (json['industry_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      distance: json['distance'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      request: (json['request'] as num?)?.toInt(),
      urgent_action: (json['urgent_action'] as num?)?.toInt(),
      revoke_status: (json['revoke_status'] as num?)?.toInt(),
      revoke_start: (json['revoke_start'] as num?)?.toInt(),
      last_ago: json['last_ago'] as String?,
      applied_date: (json['applied_date'] as num?)?.toInt(),
      proposal_date: (json['proposal_date'] as num?)?.toInt(),
      last_request: (json['last_request'] as num?)?.toInt(),
      applied_date_status: (json['applied_date_status'] as num?)?.toInt(),
      applied_proposal_status:
          (json['applied_proposal_status'] as num?)?.toInt(),
      proposal_received: json['proposal_received'] == null
          ? null
          : ProposalReceivedDTO.fromJson(
              json['proposal_received'] as Map<String, dynamic>),
      remainingRevokeTime: json['remainingRevokeTime'] == null
          ? null
          : Duration(
              microseconds: (json['remainingRevokeTime'] as num).toInt()),
      deleteAt: json['deleteAt'] as bool?,
      shift_type: (json['shift_type'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      date: (json['date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AppliedShiftDTOImplToJson(
        _$AppliedShiftDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'employer_post_user_id': instance.employer_post_user_id,
      'role_lists_name': instance.role_lists_name,
      'company_name': instance.company_name,
      'profile': instance.profile,
      'industry_id': instance.industry_id,
      'listing_id': instance.listing_id,
      'distance': instance.distance,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'request': instance.request,
      'urgent_action': instance.urgent_action,
      'revoke_status': instance.revoke_status,
      'revoke_start': instance.revoke_start,
      'last_ago': instance.last_ago,
      'applied_date': instance.applied_date,
      'proposal_date': instance.proposal_date,
      'last_request': instance.last_request,
      'applied_date_status': instance.applied_date_status,
      'applied_proposal_status': instance.applied_proposal_status,
      'proposal_received': instance.proposal_received,
      'remainingRevokeTime': instance.remainingRevokeTime?.inMicroseconds,
      'deleteAt': instance.deleteAt,
      'shift_type': instance.shift_type,
      'total_shift': instance.total_shift,
      'date': instance.date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
    };

_$ProposalReceivedDTOImpl _$$ProposalReceivedDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ProposalReceivedDTOImpl(
      posted_hourly_rate: (json['posted_hourly_rate'] as num?)?.toDouble(),
      proposed_hourly_rate: (json['proposed_hourly_rate'] as num?)?.toDouble(),
      counter_proposal_hourly_rate:
          (json['counter_proposal_hourly_rate'] as num?)?.toDouble(),
      commute_allowance_type: json['commute_allowance_type'] as String?,
      posted_commute_allowance:
          (json['posted_commute_allowance'] as num?)?.toDouble(),
      proposed_commute_allowance:
          (json['proposed_commute_allowance'] as num?)?.toDouble(),
      counter_proposal_commute_allowance:
          (json['counter_proposal_commute_allowance'] as num?)?.toDouble(),
      accommodation_allowance_type:
          json['accommodation_allowance_type'] as String?,
      posted_accommodation_allowance:
          (json['posted_accommodation_allowance'] as num?)?.toDouble(),
      proposed_accommodation_allowance:
          (json['proposed_accommodation_allowance'] as num?)?.toDouble(),
      counter_proposal_accommodation_allowance:
          (json['counter_proposal_accommodation_allowance'] as num?)
              ?.toDouble(),
    );

Map<String, dynamic> _$$ProposalReceivedDTOImplToJson(
        _$ProposalReceivedDTOImpl instance) =>
    <String, dynamic>{
      'posted_hourly_rate': instance.posted_hourly_rate,
      'proposed_hourly_rate': instance.proposed_hourly_rate,
      'counter_proposal_hourly_rate': instance.counter_proposal_hourly_rate,
      'commute_allowance_type': instance.commute_allowance_type,
      'posted_commute_allowance': instance.posted_commute_allowance,
      'proposed_commute_allowance': instance.proposed_commute_allowance,
      'counter_proposal_commute_allowance':
          instance.counter_proposal_commute_allowance,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'posted_accommodation_allowance': instance.posted_accommodation_allowance,
      'proposed_accommodation_allowance':
          instance.proposed_accommodation_allowance,
      'counter_proposal_accommodation_allowance':
          instance.counter_proposal_accommodation_allowance,
    };
