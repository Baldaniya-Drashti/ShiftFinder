import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

part 'contractor_long_term_dashboard_dto.freezed.dart';

part 'contractor_long_term_dashboard_dto.g.dart';

@freezed
class ContractorLongTermDashboardDto with _$ContractorLongTermDashboardDto {
  const factory ContractorLongTermDashboardDto({
    int? id,
    String? roles_list_name,
    String? company_name,
    int? post_id,
    int? employer_post_user_id,
    String? listing_id,
    String? last_ago,
    String? distance,
    String? profile,
    String? shift_schedule_type,
    String? specialties_list,
    int? industry,
    int? request,
    int? urgent_action,
    @DateTimeConverter() DateTime? start_date,
    @TimeConverter() TimeOfDay? estimated_weekly_hours,
    @DateTimeConverter() DateTime? end_date,
    int? total_vacancy,
    int? rate_hour,
    int? total_payable_hour,
    int? number_of_vacancie,
    @DateTimeConverter() DateTime? application_deadline,
    int? total_weeks,
    int? applied_proposal_status,
    int? applied_date,
    int? offer_expires,
    int? total_months,
    int? button,
    int? counter_proposal_button,
    double? latitude,
    bool? offer_expires_status,
    LocationDTO? location,

  }) = _ContractorLongTermDashboardDto;

  factory ContractorLongTermDashboardDto.fromJson(Map<String, dynamic> json) => _$ContractorLongTermDashboardDtoFromJson(json);
}
