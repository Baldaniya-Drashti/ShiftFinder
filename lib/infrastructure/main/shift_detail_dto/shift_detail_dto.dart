// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/payable_dto.dart/payable_dto.dart';
import 'package:shift/infrastructure/main/shift_date_detail_dto/shift_date_detail_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
part 'shift_detail_dto.freezed.dart';
part 'shift_detail_dto.g.dart';

@freezed
class ShiftDetailDTO with _$ShiftDetailDTO {
  const factory ShiftDetailDTO({
    int? id,
    int? shift_type,
    int? same_or_different_time,
    SkillDTO? unpaid_break,
    String? total_payable_hour,
    int? commute_allowance_type,
    double? commute_allowance_type_details,
    int? accommodation_allowance_type,
    double? accommodation_allowance_type_details,
    int? individual_shift,
    String? shift_note,
    int? vacancie_type,
    int? number_of_vacancie,
    int? pending_vacancie,
    int? recurring_status,
    int? share_team_status,
    int? save_template_status,
    String? disclaimer,
    List<TeamDTO>? teams,
    List<ShiftDateDetailDTO>? detail,
    PayableDTO? payables,
    int? date,
    int? start_time,
    int? end_time,
    int? recurring_start_date,
    int? recurring_end_date,
    String? recurrence_mode,
    int? recurrence_id,
    String? days,
    int? script_volume,
    int? assistant_on_site,
    int? technician_on_site,

    /// New change in send proposal UI
    double? posted_hourly_rate,
    double? proposed_hourly_rate,
    double? posted_commute_allowance_rate,
    int? posted_commute_allowance_hour_id,
    String? posted_commute_allowance_hour_name,
    double? proposed_commute_allowance_rate,
    int? proposed_commute_allowance_hour_id,
    String? proposed_commute_allowance_hour_name,
    double? posted_accommodation_allowance_rate,
    int? posted_accommodation_allowance_hour_id,
    String? posted_accommodation_allowance_hour_name,
    double? proposed_accommodation_allowance_rate,
    int? proposed_accommodation_allowance_hour_id,
    String? proposed_accommodation_allowance_hour_name,
    ProposalDTO? proposal_received,
  }) = _ShiftDetailDTO;

  factory ShiftDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$ShiftDetailDTOFromJson(json);
}

// @freezed
// class ProposalDTO with _$ProposalDTO {
//   const factory ProposalDTO({
//     double? posted_hourly_rate,
//     double? proposed_hourly_rate,
//     double? counter_proposal_hourly_rate,
//     String? commute_allowance_type,
//     double? posted_commute_allowance,
//     double? proposed_commute_allowance,
//     double? counter_proposal_commute_allowance,
//     String? accommodation_allowance_type,
//     double? posted_accommodation_allowance,
//     double? proposed_accommodation_allowance,
//     double? counter_proposal_accommodation_allowance,
//   }) = _ProposalDTO;

//   factory ProposalDTO.fromJson(Map<String, dynamic> json) =>
//       _$ProposalDTOFromJson(json);
// }

@freezed
class ProposalDTO with _$ProposalDTO {
  const factory ProposalDTO({
    int? commute_allowance_type,
    int? accommodation_allowance_type,

    /// Posted value is Original Value
    double? posted_hourly_rate,
    double? posted_commute_allowance_rate,
    int? posted_commute_allowance_hour_id,
    double? posted_accommodation_allowance_rate,
    int? posted_accommodation_allowance_hour_id,

    /// Proposed value is Contractor proposal value
    double? proposed_hourly_rate,
    double? proposed_commute_allowance_rate,
    int? proposed_commute_allowance_hour_id,
    double? proposed_accommodation_allowance_rate,
    int? proposed_accommodation_allowance_hour_id,

    /// Counter value is Employer proposal value
    double? counter_proposal_hourly_rate,
    double? counter_commute_allowance_rate,
    int? counter_commute_allowance_hour_id,
    double? counter_accommodation_allowance_rate,
    int? counter_accommodation_allowance_hour_id,
  }) = _ProposalDTO;

  factory ProposalDTO.fromJson(Map<String, dynamic> json) =>
      _$ProposalDTOFromJson(json);
}
