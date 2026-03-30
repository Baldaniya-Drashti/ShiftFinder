// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payable_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayableDTOImpl _$$PayableDTOImplFromJson(Map<String, dynamic> json) =>
    _$PayableDTOImpl(
      total_payable_hour: json['total_payable_hour'] as String?,
      rate_hour: json['rate_hour'] as String?,
      total_wage: json['total_wage'] as String?,
      commute_allowance: json['commute_allowance'] as String?,
      accommodation_allowance: json['accommodation_allowance'] as String?,
      total_allowance: json['total_allowance'] as String?,
      service_fee: json['service_fee'] as String?,
      total_one_shift: json['total_one_shift'] as String?,
      number_of_vacancie: (json['number_of_vacancie'] as num?)?.toInt(),
      total_amount_payable: json['total_amount_payable'] as String?,
      total_one_allowance: json['total_one_allowance'] as String?,
      number_of_shift: (json['number_of_shift'] as num?)?.toInt(),
      service_one_fee: json['service_one_fee'] as String?,
      third_party_fee: json['third_party_fee'] as String?,
      third_party_tax_fee: json['third_party_tax_fee'] as String?,
      total_amount_payable_contractor:
          json['total_amount_payable_contractor'] as String?,
    );

Map<String, dynamic> _$$PayableDTOImplToJson(_$PayableDTOImpl instance) =>
    <String, dynamic>{
      'total_payable_hour': instance.total_payable_hour,
      'rate_hour': instance.rate_hour,
      'total_wage': instance.total_wage,
      'commute_allowance': instance.commute_allowance,
      'accommodation_allowance': instance.accommodation_allowance,
      'total_allowance': instance.total_allowance,
      'service_fee': instance.service_fee,
      'total_one_shift': instance.total_one_shift,
      'number_of_vacancie': instance.number_of_vacancie,
      'total_amount_payable': instance.total_amount_payable,
      'total_one_allowance': instance.total_one_allowance,
      'number_of_shift': instance.number_of_shift,
      'service_one_fee': instance.service_one_fee,
      'third_party_fee': instance.third_party_fee,
      'third_party_tax_fee': instance.third_party_tax_fee,
      'total_amount_payable_contractor':
          instance.total_amount_payable_contractor,
    };
