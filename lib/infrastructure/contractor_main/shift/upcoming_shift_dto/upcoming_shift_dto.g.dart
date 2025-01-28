// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpComingShiftDTOImpl _$$UpComingShiftDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$UpComingShiftDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      employer_post_user_id: (json['employer_post_user_id'] as num?)?.toInt(),
      role_lists_name: json['role_lists_name'] as String?,
      company_name: json['company_name'] as String?,
      profile: json['profile'] as String?,
      industry_id: (json['industry_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      distance: json['distance'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      location: json['location'] as String?,
      facility_type: json['facility_type'] == null
          ? null
          : FacilityTypeDto.fromJson(
              json['facility_type'] as Map<String, dynamic>),
      facility_type_other: json['facility_type_other'] as String?,
      request: (json['request'] as num?)?.toInt(),
      urgent_action: (json['urgent_action'] as num?)?.toInt(),
      revoke_status: (json['revoke_status'] as num?)?.toInt(),
      last_ago: json['last_ago'] as String?,
      applied_date: (json['applied_date'] as num?)?.toInt(),
      check_delete: json['check_delete'] as bool?,
      date: (json['date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      isCad: json['isCad'] as bool?,
    );

Map<String, dynamic> _$$UpComingShiftDTOImplToJson(
        _$UpComingShiftDTOImpl instance) =>
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
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'location': instance.location,
      'facility_type': instance.facility_type,
      'facility_type_other': instance.facility_type_other,
      'request': instance.request,
      'urgent_action': instance.urgent_action,
      'revoke_status': instance.revoke_status,
      'last_ago': instance.last_ago,
      'applied_date': instance.applied_date,
      'check_delete': instance.check_delete,
      'date': instance.date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'shift_type': instance.shift_type,
      'total_shift': instance.total_shift,
      'isCad': instance.isCad,
    };
