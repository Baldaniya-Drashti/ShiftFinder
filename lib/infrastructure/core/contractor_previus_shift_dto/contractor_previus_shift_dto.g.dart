// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_previus_shift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorPreviousShiftDTOImpl _$$ContractorPreviousShiftDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ContractorPreviousShiftDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      applicants_id: (json['applicants_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      last_ago: json['last_ago'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      company_name: json['company_name'] as String?,
      distance: json['distance'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      shift_type: (json['shift_type'] as num?)?.toInt(),
      total_shifts: (json['total_shifts'] as num?)?.toInt(),
      shift_date: (json['shift_date'] as List<dynamic>?)
          ?.map(
              (e) => PreviousShiftDetailDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      is_payment: (json['is_payment'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ContractorPreviousShiftDTOImplToJson(
        _$ContractorPreviousShiftDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'applicants_id': instance.applicants_id,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'roles_list_name': instance.roles_list_name,
      'industry': instance.industry,
      'company_name': instance.company_name,
      'distance': instance.distance,
      'location': instance.location,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'reason': instance.reason,
      'shift_type': instance.shift_type,
      'total_shifts': instance.total_shifts,
      'shift_date': instance.shift_date,
      'is_payment': instance.is_payment,
    };

_$PreviousShiftDetailDTOImpl _$$PreviousShiftDetailDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$PreviousShiftDetailDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      unpaid_break_id: (json['unpaid_break_id'] as num?)?.toInt(),
      payable_hour: json['payable_hour'] as String?,
    );

Map<String, dynamic> _$$PreviousShiftDetailDTOImplToJson(
        _$PreviousShiftDetailDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'unpaid_break_id': instance.unpaid_break_id,
      'payable_hour': instance.payable_hour,
    };
