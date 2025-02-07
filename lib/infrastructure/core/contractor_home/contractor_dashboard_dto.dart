import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';

part 'contractor_dashboard_dto.freezed.dart';
part 'contractor_dashboard_dto.g.dart';

@freezed
class ContactorDashboardDTO with _$ContactorDashboardDTO {
  const factory ContactorDashboardDTO({
    int? id,
    int? shift_type,
    int? same_or_different_time,
    String? listing_id,
    List<RolesList>? roles_list,
    String? roles_list_name,
    String? company_name,
    String? last_ago,
    SkillDTO? unpaid_break,
    int? industry,
    String? distance,
    Location? location,
    List<ShiftDate>? shift_date,
    int? start_date,
    int? start_time,
    int? end_date,
    int? end_time,
    int? total_shift,
    int? total_application_counts,
    List<ApplicationProfile>? total_application_profiles,
    int? total_proposal_counts,
    List<ApplicationProfile>? total_proposal_profiles,
    String? specialties_list,
    num? rate_hour,
    String? total_payable_hour,
    int? total_vacancy,
    String? accommodation_allowance,
    String? commute_allowance,
    String? total_amount,
    String? total_wage,
    String? total_allowance,
    bool? isHighlightShift,
  }) = _ContactorDashboardDTO;

  factory ContactorDashboardDTO.fromJson(Map<String, dynamic> json) =>
      _$ContactorDashboardDTOFromJson(json);
}

@freezed
class RolesList with _$RolesList {
  const factory RolesList({
    int? id,
    String? name,
  }) = _RolesList;

  factory RolesList.fromJson(Map<String, dynamic> json) =>
      _$RolesListFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    int? id,
    double? latitude,
    double? longitude,
    String? location,
    FacilityTypeDto? facility_type,
    String? facility_type_other,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class ShiftDate with _$ShiftDate {
  const factory ShiftDate({
    int? start_date,
    int? start_time,
    int? end_date,
    int? end_time,
    int? date,
    SkillDTO? unpaid_break,
  }) = _ShiftDate;

  factory ShiftDate.fromJson(Map<String, dynamic> json) =>
      _$ShiftDateFromJson(json);
}

@freezed
class ApplicationProfile with _$ApplicationProfile {
  const factory ApplicationProfile({
    int? id,
    String? profile,
  }) = _ApplicationProfile;

  factory ApplicationProfile.fromJson(Map<String, dynamic> json) =>
      _$ApplicationProfileFromJson(json);
}
