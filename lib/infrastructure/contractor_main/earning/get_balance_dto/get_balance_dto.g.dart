// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_balance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetBalanceDTOImpl _$$GetBalanceDTOImplFromJson(Map<String, dynamic> json) =>
    _$GetBalanceDTOImpl(
      available_balance: (json['available_balance'] as num?)?.toDouble(),
      pending_balance: (json['pending_balance'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      total_balance: (json['total_balance'] as num?)?.toDouble(),
      available_withdrawable_balance:
          (json['available_withdrawable_balance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$GetBalanceDTOImplToJson(_$GetBalanceDTOImpl instance) =>
    <String, dynamic>{
      'available_balance': instance.available_balance,
      'pending_balance': instance.pending_balance,
      'currency': instance.currency,
      'total_balance': instance.total_balance,
      'available_withdrawable_balance': instance.available_withdrawable_balance,
    };
