// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProposalDetailDtoImpl _$$ProposalDetailDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProposalDetailDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      last_name: json['last_name'] as String?,
      first_name: json['first_name'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toInt(),
      longitude: (json['longitude'] as num?)?.toInt(),
      distance: json['distance'] as String?,
      posted_rate_hour: (json['posted_rate_hour'] as num?)?.toInt(),
      proposed_rate_hour: (json['proposed_rate_hour'] as num?)?.toInt(),
      commute_allowance_type: (json['commute_allowance_type'] as num?)?.toInt(),
      posted_commute_allowance:
          (json['posted_commute_allowance'] as num?)?.toInt(),
      proposed_commute_allowance:
          (json['proposed_commute_allowance'] as num?)?.toInt(),
      accommodation_allowance_type:
          (json['accommodation_allowance_type'] as num?)?.toInt(),
      proposed_accommodation_allowance:
          (json['proposed_accommodation_allowance'] as num?)?.toInt(),
      posted_accommodation_allowance:
          (json['posted_accommodation_allowance'] as num?)?.toInt(),
      shift_type: json['shift_type'] as String?,
      revoke_status: (json['revoke_status'] as num?)?.toInt(),
      revoke_start_time: (json['revoke_start_time'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      hired_contractor_list: json['hired_contractor_list'] as List<dynamic>?,
      posted_proposed_time: (json['posted_proposed_time'] as List<dynamic>?)
          ?.map((e) => PostedProposedTime.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProposalDetailDtoImplToJson(
        _$ProposalDetailDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'profile': instance.profile,
      'last_name': instance.last_name,
      'first_name': instance.first_name,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distance': instance.distance,
      'posted_rate_hour': instance.posted_rate_hour,
      'proposed_rate_hour': instance.proposed_rate_hour,
      'commute_allowance_type': instance.commute_allowance_type,
      'posted_commute_allowance': instance.posted_commute_allowance,
      'proposed_commute_allowance': instance.proposed_commute_allowance,
      'accommodation_allowance_type': instance.accommodation_allowance_type,
      'proposed_accommodation_allowance':
          instance.proposed_accommodation_allowance,
      'posted_accommodation_allowance': instance.posted_accommodation_allowance,
      'shift_type': instance.shift_type,
      'revoke_status': instance.revoke_status,
      'revoke_start_time': instance.revoke_start_time,
      'status': instance.status,
      'hired_contractor_list': instance.hired_contractor_list,
      'posted_proposed_time': instance.posted_proposed_time,
    };

_$PostedProposedTimeImpl _$$PostedProposedTimeImplFromJson(
        Map<String, dynamic> json) =>
    _$PostedProposedTimeImpl(
      id: (json['id'] as num?)?.toInt(),
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      unpaid_break_id: (json['unpaid_break_id'] as num?)?.toInt(),
      payable_hour: json['payable_hour'] as String?,
    );

Map<String, dynamic> _$$PostedProposedTimeImplToJson(
        _$PostedProposedTimeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'unpaid_break_id': instance.unpaid_break_id,
      'payable_hour': instance.payable_hour,
    };
