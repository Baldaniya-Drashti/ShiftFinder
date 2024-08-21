// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hired_contractor_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HiredContractorListDTOImpl _$$HiredContractorListDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$HiredContractorListDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
      contractor_shift_type: (json['contractor_shift_type'] as num?)?.toInt(),
      shift_type: (json['shift_type'] as num?)?.toInt(),
      shift_date: (json['shift_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      clock_in_time: (json['clock_in_time'] as num?)?.toInt(),
      clock_out_time: (json['clock_out_time'] as num?)?.toInt(),
      clock_in_out_status: (json['clock_in_out_status'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      post_id: (json['post_id'] as num?)?.toInt(),
      shift_complete: json['shift_complete'] as bool?,
      count: (json['count'] as num?)?.toInt(),
      isLoading: json['isLoading'] as bool?,
    );

Map<String, dynamic> _$$HiredContractorListDTOImplToJson(
        _$HiredContractorListDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'contractor_shift_type': instance.contractor_shift_type,
      'shift_type': instance.shift_type,
      'shift_date': instance.shift_date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'clock_in_time': instance.clock_in_time,
      'clock_out_time': instance.clock_out_time,
      'clock_in_out_status': instance.clock_in_out_status,
      'reason': instance.reason,
      'post_id': instance.post_id,
      'shift_complete': instance.shift_complete,
      'count': instance.count,
      'isLoading': instance.isLoading,
    };
