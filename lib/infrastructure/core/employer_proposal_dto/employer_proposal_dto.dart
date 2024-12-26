import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'employer_proposal_dto.freezed.dart';
part 'employer_proposal_dto.g.dart';

@freezed
class EmployerProposalDto with _$EmployerProposalDto {
  const factory EmployerProposalDto({
    int? id,
    String? first_name,
    String? last_name,
    String? listing_id,
    int? user_id,
    String? profile,
    String? last_ago,
    String? roles_list_name,
    int? industry,
    int? start_time,
    int? end_time,
    int? complete_shift,
    List<EmployerProposalPendingUserDto>? pending_users,
    LocationDTO? location,
    String? distance,
    int? post_id,
    int? proposal_type,
    int? last_request,
    int? revoke_status,
    int? shift_type,
    int? same_or_different_time,
    int? total_shift,
    int? start_date,
    int? counter_proposal_hourly_rate,
    int? counter_proposal_commute_allowance,
    int? counter_proposal_accommodation_allowance,
    int? end_date,
    int? posted_start_time,
    int? posted_end_time,
    int? agreed_start_time,
    int? agreed_end_time,
    int? posted_hourly_rate,
    double? proposed_hourly_rate,
    int? commute_allowance_type,
    double? posted_commute_allowance_rate,
    int? posted_commute_allowance_hour_id,
    double? proposed_commute_allowance_rate,
    int? proposed_commute_allowance_hour_id,
    int? accommodation_allowance_type,
    double? posted_accommodation_allowance_rate,
    int? posted_accommodation_allowance_hour_id,
    double? proposed_accommodation_allowance_rate,
    int? proposed_accommodation_allowance_hour_id,
    String? proposed_accommodation_allowance_hour_name,
    String? posted_accommodation_allowance_hour_name,
    String? proposed_commute_allowance_hour_name,
    String? posted_commute_allowance_hour_name,
    List<EmployerProposalShiftDetailDto>? shift_details,
    bool? isCardAdded,
    bool? occupied,
  }) = _EmployerProposalDto;

  factory EmployerProposalDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerProposalDtoFromJson(json);
}

@freezed
class EmployerProposalPendingUserDto with _$EmployerProposalPendingUserDto {
  const factory EmployerProposalPendingUserDto({
    int? id,
    String? first_name,
    String? last_name,
    String? profile,
    int? user_id,
    int? last_request,
    int? revoke_status,
    int? revoke_start,
    Duration? duration,
    int? sent_received_status,
    int? deleteAt,
    bool? accept_btn_toggle,
    bool? occupied,
  }) = _EmployerProposalPendingUserDto;

  factory EmployerProposalPendingUserDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerProposalPendingUserDtoFromJson(json);
}

@freezed
class EmployerProposalShiftDetailDto with _$EmployerProposalShiftDetailDto {
  const factory EmployerProposalShiftDetailDto({
    int? id,
    int? start_date,
    int? posted_start_time,
    int? posted_end_time,
    int? proposed_start_time,
    int? proposed_end_time,
  }) = _EmployerProposalShiftDetailDto;

  factory EmployerProposalShiftDetailDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerProposalShiftDetailDtoFromJson(json);
}
