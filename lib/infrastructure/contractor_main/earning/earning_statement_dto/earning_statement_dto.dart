// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'earning_statement_dto.freezed.dart';
part 'earning_statement_dto.g.dart';

@freezed
class EarningStatementDTO with _$EarningStatementDTO {
  const factory EarningStatementDTO({
    String? contractor_name,
    double? start_date,
    double? end_date,
    List<CompletedShiftsEarningDTO>? completed_shifts_earning,
    double? completed_total_wage,
    double? completed_total_allowance,
    double? completed_total_earnings,
    List<CompletedShiftsEarningDTO>? cancellations_shifts_earning,
    double? total_cancellation_fee,
    List<CompletedShiftsEarningDTO>? referrals_data,
    double? total_bonus,
    double? net_earnings,
  }) = _EarningStatementDTO;

  factory EarningStatementDTO.fromJson(Map<String, dynamic> json) =>
      _$EarningStatementDTOFromJson(json);
}

@freezed
class CompletedShiftsEarningDTO with _$CompletedShiftsEarningDTO {
  const factory CompletedShiftsEarningDTO({
    int? id,
    int? post_id,
    int? date,
    String? company_name,
    LocationDTO? location,
    String? hours_worked,
    double? hourly_rate,
    double? total_wage,
    double? total_allowance,
    double? total_earnings,
    double? amount,
    String? referred_contractor_name,
  }) = _CompletedShiftsEarningDTO;

  factory CompletedShiftsEarningDTO.fromJson(Map<String, dynamic> json) =>
      _$CompletedShiftsEarningDTOFromJson(json);
}
