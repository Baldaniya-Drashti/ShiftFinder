import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer_dashboard_dto.freezed.dart';
part 'employer_dashboard_dto.g.dart';

@freezed
class EmployerDashboardDTO with _$EmployerDashboardDTO {
  const factory EmployerDashboardDTO({
    int? id,
    int? shift_type,
    String? listing_id,
    List<RolesList>? roles_list,
    String? roles_list_name,
    String? company_name,
    String? last_ago,
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
    List<dynamic>? total_application_profiles,
    int? total_proposal_counts,
    List<dynamic>? total_proposal_profiles,
    String? specialties_list,
    int? rate_hour,
    String? total_payable_hour,
    int? total_vacancy,
    int? accommodation_allowance,
    int? commute_allowance,
    int? total_amount,
  }) = _EmployerDashboardDTO;

  factory EmployerDashboardDTO.fromJson(Map<String, dynamic> json) =>
      _$EmployerDashboardDTOFromJson(json);
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
  }) = _ShiftDate;

  factory ShiftDate.fromJson(Map<String, dynamic> json) =>
      _$ShiftDateFromJson(json);
}
