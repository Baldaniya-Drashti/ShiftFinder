// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'applied_shift_dto.freezed.dart';
part 'applied_shift_dto.g.dart';

@freezed
class AppliedShiftDTO with _$AppliedShiftDTO {
  const factory AppliedShiftDTO({
    int? id,
    int? post_id,
    int? employer_post_user_id,
    String? role_lists_name,
    String? company_name,
    String? profile,
    int? industry_id,
    String? listing_id,
    String? distance,
    String? location,
    FacilityTypeDto? facility_type,
    String? facility_type_other,
    double? latitude,
    double? longitude,
    int? request,
    int? urgent_action,
    int? revoke_status,
    int? revoke_start,
    String? last_ago,
    int? applied_date,
    int? proposal_date,
    int? last_request,
    int? applied_date_status,
    int? applied_proposal_status,
    ProposalReceivedDTO? proposal_received,
    Duration? remainingRevokeTime,
    bool? deleteAt,
    bool? isVacancies,
    int? shift_type,
    int? total_shift,
    int? date,
    int? start_time,
    int? end_time,
    int? start_date,
    int? end_date,
    int? posted_start_time,
    int? posted_end_time,
    int? agreed_start_time,
    int? agreed_end_time,
    String? date_list,
    List<ProposalShiftDetailDTO>? shift_details,
    int? is_delete,
  }) = _AppliedShiftDTO;

  factory AppliedShiftDTO.fromJson(Map<String, dynamic> json) =>
      _$AppliedShiftDTOFromJson(json);
}

@freezed
class ProposalReceivedDTO with _$ProposalReceivedDTO {
  const factory ProposalReceivedDTO({
    double? posted_hourly_rate,
    double? proposed_hourly_rate,
    double? counter_proposal_hourly_rate,
    String? commute_allowance_type,
    double? posted_commute_allowance,
    double? proposed_commute_allowance,
    double? counter_proposal_commute_allowance,
    String? accommodation_allowance_type,
    double? posted_accommodation_allowance,
    double? proposed_accommodation_allowance,
    double? counter_proposal_accommodation_allowance,
  }) = _ProposalReceivedDTO;

  factory ProposalReceivedDTO.fromJson(Map<String, dynamic> json) =>
      _$ProposalReceivedDTOFromJson(json);
}

@freezed
class ProposalShiftDetailDTO with _$ProposalShiftDetailDTO {
  const factory ProposalShiftDetailDTO({
    int? start_date,
    int? posted_start_time,
    int? posted_end_time,
    int? proposed_start_time,
    int? proposed_end_time,
  }) = _ProposalShiftDetailDTO;

  factory ProposalShiftDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$ProposalShiftDetailDTOFromJson(json);
}
