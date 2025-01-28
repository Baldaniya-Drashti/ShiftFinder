// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StatementDTOImpl _$$StatementDTOImplFromJson(Map<String, dynamic> json) =>
    _$StatementDTOImpl(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => StatementDetailDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      additional_data: json['additional_data'] == null
          ? null
          : StatementAdditionalDetailDTO.fromJson(
              json['additional_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StatementDTOImplToJson(_$StatementDTOImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'additional_data': instance.additional_data,
    };

_$StatementDetailDTOImpl _$$StatementDetailDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$StatementDetailDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      date: (json['date'] as num?)?.toInt(),
      company_name: json['company_name'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
      hours_worked: json['hours_worked'] as String?,
      hourly_rate: (json['hourly_rate'] as num?)?.toDouble(),
      total_wage: (json['total_wage'] as num?)?.toDouble(),
      total_allowance: (json['total_allowance'] as num?)?.toDouble(),
      total_earnings: (json['total_earnings'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      referred_contractor_name: json['referred_contractor_name'] as String?,
    );

Map<String, dynamic> _$$StatementDetailDTOImplToJson(
        _$StatementDetailDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'date': instance.date,
      'company_name': instance.company_name,
      'location': instance.location,
      'hours_worked': instance.hours_worked,
      'hourly_rate': instance.hourly_rate,
      'total_wage': instance.total_wage,
      'total_allowance': instance.total_allowance,
      'total_earnings': instance.total_earnings,
      'amount': instance.amount,
      'referred_contractor_name': instance.referred_contractor_name,
    };

_$StatementAdditionalDetailDTOImpl _$$StatementAdditionalDetailDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$StatementAdditionalDetailDTOImpl(
      completed_total_earnings:
          (json['completed_total_earnings'] as num?)?.toDouble(),
      total_cancellation_fee:
          (json['total_cancellation_fee'] as num?)?.toDouble(),
      total_bonus: (json['total_bonus'] as num?)?.toDouble(),
      total_withdraw: (json['total_withdraw'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$StatementAdditionalDetailDTOImplToJson(
        _$StatementAdditionalDetailDTOImpl instance) =>
    <String, dynamic>{
      'completed_total_earnings': instance.completed_total_earnings,
      'total_cancellation_fee': instance.total_cancellation_fee,
      'total_bonus': instance.total_bonus,
      'total_withdraw': instance.total_withdraw,
    };
