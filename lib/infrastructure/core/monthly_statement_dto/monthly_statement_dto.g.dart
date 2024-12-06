// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_statement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonthlyStatementDTOImpl _$$MonthlyStatementDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$MonthlyStatementDTOImpl(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) =>
              MonthlyStatementDetailDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      company_name: json['company_name'] as String?,
      industry_id: (json['industry_id'] as num?)?.toInt(),
      total_wage: json['total_wage'] as String?,
      total_service_fee: json['total_service_fee'] as String?,
      total_cancellation_fee: json['total_cancellation_fee'] as String?,
    );

Map<String, dynamic> _$$MonthlyStatementDTOImplToJson(
        _$MonthlyStatementDTOImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'company_name': instance.company_name,
      'industry_id': instance.industry_id,
      'total_wage': instance.total_wage,
      'total_service_fee': instance.total_service_fee,
      'total_cancellation_fee': instance.total_cancellation_fee,
    };

_$MonthlyStatementDetailDTOImpl _$$MonthlyStatementDetailDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$MonthlyStatementDetailDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      date_of_transaction: json['date_of_transaction'] as String?,
      contractor_first_name: json['contractor_first_name'] as String?,
      contractor_last_name: json['contractor_last_name'] as String?,
      shiftfinder_service_fee: json['shiftfinder_service_fee'] as String?,
      type: (json['type'] as num?)?.toInt(),
      total_wage: json['total_wage'] as String?,
    );

Map<String, dynamic> _$$MonthlyStatementDetailDTOImplToJson(
        _$MonthlyStatementDetailDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date_of_transaction': instance.date_of_transaction,
      'contractor_first_name': instance.contractor_first_name,
      'contractor_last_name': instance.contractor_last_name,
      'shiftfinder_service_fee': instance.shiftfinder_service_fee,
      'type': instance.type,
      'total_wage': instance.total_wage,
    };
