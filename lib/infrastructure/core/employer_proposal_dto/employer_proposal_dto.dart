import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

part 'employer_proposal_dto.freezed.dart';

part 'employer_proposal_dto.g.dart';

@freezed
class EmployerProposalDto with _$EmployerProposalDto {
  const factory EmployerProposalDto({
    int? id,
    String? listing_id,
    String? last_ago,
    String? roles_list_name,
    int? industry,
    int? shift_type,
    LocationDTO? location,
    int? start_date,
    int? start_time,
    int? end_date,
    int? end_time,
    int? total_shift,
    int? complete_shift,
    List<EmployerProposalPendingUserDto>? pending_users,
  }) = _EmployerProposalDto;

  factory EmployerProposalDto.fromJson(Map<String, dynamic> json) => _$EmployerProposalDtoFromJson(json);
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
  }) = _EmployerProposalPendingUserDto;

  factory EmployerProposalPendingUserDto.fromJson(Map<String, dynamic> json) => _$EmployerProposalPendingUserDtoFromJson(json);
}
