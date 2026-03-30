// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
part 'healthcare_post_dto.freezed.dart';
part 'healthcare_post_dto.g.dart';

@freezed
class HealthcarePostDTO with _$HealthcarePostDTO {
  const factory HealthcarePostDTO({
    int? id,
    int? post_id,
    String? listing_id,
    String? last_ago,
    String? company_name,
    String? distance,
    List<SkillDTO>? roles_list,
    String? roles_list_name,
    List<SkillDTO>? specialties_detail_list,
    List<SkillDTO>? softwares_skill_list,
    String? software_skill_other,
    String? specialties_detail_other,
    List<SkillDTO>? languages_list,
    String? language_other,
    LocationDTO? location,
    String? location_unit,
    double? rate_hour,
    ShiftDetailDTO? shift_detail,
    String? software_skill,
    String? specialties_detail,
    // ProposalReceivedDTO? proposal_received,
  }) = _HealthcarePostDTO;

  factory HealthcarePostDTO.fromJson(Map<String, dynamic> json) =>
      _$HealthcarePostDTOFromJson(json);
}

/* @freezed
class ProposalReceivedDTO with _$ProposalReceivedDTO {
  const factory ProposalReceivedDTO({
    double? posted_hourly_rate,
    double? proposed_hourly_rate,
    double? counter_proposal_hourly_rate,
    int? commute_allowance_type,
    // double? proposed_commute_allowance,
    double? posted_commute_allowance_rate,
    double? posted_commute_allowance_hour_id,
    double? proposed_commute_allowance_rate,
    double? proposed_commute_allowance_hour_id,
    int? accommodation_allowance_type,
    // double? proposed_accommodation_allowance,
    double? posted_accommodation_allowance_rate,
    double? posted_accommodation_allowance_hour_id,
    double? proposed_accommodation_allowance_rate,
    double? proposed_accommodation_allowance_hour_id,
    double? counter_proposal_commute_allowance,
    double? counter_proposal_accommodation_allowance,
  }) = _ProposalReceivedDTO;

  factory ProposalReceivedDTO.fromJson(Map<String, dynamic> json) =>
      _$ProposalReceivedDTOFromJson(json);
} */
