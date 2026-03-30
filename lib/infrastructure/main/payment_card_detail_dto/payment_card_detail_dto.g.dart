// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentCardDTOImpl _$$PaymentCardDTOImplFromJson(Map<String, dynamic> json) =>
    _$PaymentCardDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      number: json['number'] as String?,
      exp_month: (json['exp_month'] as num?)?.toInt(),
      exp_year: (json['exp_year'] as num?)?.toInt(),
      user_name: json['user_name'] as String?,
      brand: json['brand'] as String?,
      is_default: (json['is_default'] as num?)?.toInt(),
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$$PaymentCardDTOImplToJson(
        _$PaymentCardDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'exp_month': instance.exp_month,
      'exp_year': instance.exp_year,
      'user_name': instance.user_name,
      'brand': instance.brand,
      'is_default': instance.is_default,
      'icon': instance.icon,
    };
