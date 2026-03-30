// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earning_statement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EarningStatementDTOImpl _$$EarningStatementDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$EarningStatementDTOImpl(
      contractor_name: json['contractor_name'] as String?,
      start_date: (json['start_date'] as num?)?.toDouble(),
      end_date: (json['end_date'] as num?)?.toDouble(),
      completed_shifts_earning:
          (json['completed_shifts_earning'] as List<dynamic>?)
              ?.map((e) =>
                  CompletedShiftsEarningDTO.fromJson(e as Map<String, dynamic>))
              .toList(),
      completed_total_wage: (json['completed_total_wage'] as num?)?.toDouble(),
      completed_total_allowance:
          (json['completed_total_allowance'] as num?)?.toDouble(),
      completed_total_earnings:
          (json['completed_total_earnings'] as num?)?.toDouble(),
      cancellations_shifts_earning:
          (json['cancellations_shifts_earning'] as List<dynamic>?)
              ?.map((e) =>
                  CompletedShiftsEarningDTO.fromJson(e as Map<String, dynamic>))
              .toList(),
      total_cancellation_fee:
          (json['total_cancellation_fee'] as num?)?.toDouble(),
      referrals_data: (json['referrals_data'] as List<dynamic>?)
          ?.map((e) =>
              CompletedShiftsEarningDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_bonus: (json['total_bonus'] as num?)?.toDouble(),
      net_earnings: (json['net_earnings'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$EarningStatementDTOImplToJson(
        _$EarningStatementDTOImpl instance) =>
    <String, dynamic>{
      'contractor_name': instance.contractor_name,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'completed_shifts_earning': instance.completed_shifts_earning,
      'completed_total_wage': instance.completed_total_wage,
      'completed_total_allowance': instance.completed_total_allowance,
      'completed_total_earnings': instance.completed_total_earnings,
      'cancellations_shifts_earning': instance.cancellations_shifts_earning,
      'total_cancellation_fee': instance.total_cancellation_fee,
      'referrals_data': instance.referrals_data,
      'total_bonus': instance.total_bonus,
      'net_earnings': instance.net_earnings,
    };

_$CompletedShiftsEarningDTOImpl _$$CompletedShiftsEarningDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$CompletedShiftsEarningDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      invoice_no: (json['invoice_no'] as num?)?.toInt(),
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

Map<String, dynamic> _$$CompletedShiftsEarningDTOImplToJson(
        _$CompletedShiftsEarningDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.post_id,
      'invoice_no': instance.invoice_no,
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
