// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
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
    double? latitude,
    double? longitude,
    int? request,
    int? urgent_action,
    int? revoke_status,
    int? revoke_start,
    String? last_ago,
    int? applied_date,
    int? last_request,
    ProposalReceivedDTO? proposal_received,
    Duration? remainingRevokeTime,
  }) = _AppliedShiftDTO;

  factory AppliedShiftDTO.fromJson(Map<String, dynamic> json) =>
      _$AppliedShiftDTOFromJson(json);
}

@freezed
class ProposalReceivedDTO with _$ProposalReceivedDTO {
  const factory ProposalReceivedDTO({
    int? posted_hourly_rate,
    int? proposed_hourly_rate,
    int? counter_proposal_hourly_rate,
    String? commute_allowance_type,
    int? posted_commute_allowance,
    int? proposed_commute_allowance,
    int? counter_proposal_commute_allowance,
    String? accommodation_allowance_type,
    int? posted_accommodation_allowance,
    int? proposed_accommodation_allowance,
    int? counter_proposal_accommodation_allowance,
  }) = _ProposalReceivedDTO;

  factory ProposalReceivedDTO.fromJson(Map<String, dynamic> json) =>
      _$ProposalReceivedDTOFromJson(json);
}
