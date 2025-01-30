// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdditionalDataDtoImpl _$$AdditionalDataDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$AdditionalDataDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      is_card_added: json['is_card_added'] as bool?,
      profile: json['profile'] as String?,
      role_lists_name: json['role_lists_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      last_ago: json['last_ago'] as String?,
      role_list_name: json['role_list_name'] as String?,
      location: json['location'] as String?,
      start_date: (json['start_date'] as num?)?.toInt(),
      start_time: (json['start_time'] as num?)?.toInt(),
      end_time: (json['end_time'] as num?)?.toInt(),
      complete_shift: (json['complete_shift'] as num?)?.toInt(),
      total_shift: (json['total_shift'] as num?)?.toInt(),
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$$AdditionalDataDtoImplToJson(
        _$AdditionalDataDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_card_added': instance.is_card_added,
      'profile': instance.profile,
      'role_lists_name': instance.role_lists_name,
      'industry': instance.industry,
      'listing_id': instance.listing_id,
      'last_ago': instance.last_ago,
      'role_list_name': instance.role_list_name,
      'location': instance.location,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'complete_shift': instance.complete_shift,
      'total_shift': instance.total_shift,
      'status': instance.status,
    };
