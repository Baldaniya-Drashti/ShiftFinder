// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentHistoryDTOImpl _$$PaymentHistoryDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentHistoryDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      listing_id: json['listing_id'] as String?,
      roles_list_name: json['roles_list_name'] as String?,
      industry: (json['industry'] as num?)?.toInt(),
      shift_type: json['shift_type'] as String?,
      end_date: (json['end_date'] as num?)?.toInt(),
      date: (json['date'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
      total_amount_payble: json['total_amount_payble'] as String?,
      total_wage: json['total_wage'] as String?,
      total_allowance: json['total_allowance'] as String?,
    );

Map<String, dynamic> _$$PaymentHistoryDTOImplToJson(
        _$PaymentHistoryDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'listing_id': instance.listing_id,
      'roles_list_name': instance.roles_list_name,
      'industry': instance.industry,
      'shift_type': instance.shift_type,
      'end_date': instance.end_date,
      'date': instance.date,
      'location': instance.location,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'total_amount_payble': instance.total_amount_payble,
      'total_wage': instance.total_wage,
      'total_allowance': instance.total_allowance,
    };
