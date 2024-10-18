import 'package:freezed_annotation/freezed_annotation.dart';


part 'proposal_detail_dto.freezed.dart';

part 'proposal_detail_dto.g.dart';


@freezed
class ProposalDetailDto with _$ProposalDetailDto {
  const factory ProposalDetailDto({
    int? id,
    int? user_id,
    String? profile,
    String? last_name,
    String? first_name,
    String? location,
    int? latitude,
    int? longitude,
    String? distance,
    int? posted_rate_hour,
    int? proposed_rate_hour,
    int? commute_allowance_type,
    int? posted_commute_allowance,
    int? proposed_commute_allowance,
    int? accommodation_allowance_type,
    int? proposed_accommodation_allowance,
    int? posted_accommodation_allowance,
    String? shift_type,
    int? revoke_status,
    int? revoke_start_time,
    int? status,
    List<dynamic>? hired_contractor_list,
    List<PostedProposedTime>? posted_proposed_time,
  }) = _ProposalDetailDto;

  factory ProposalDetailDto.fromJson(Map<String, dynamic> json) => _$ProposalDetailDtoFromJson(json);
}


@freezed
class PostedProposedTime with _$PostedProposedTime {
  const factory PostedProposedTime({
    int? id,
    int? start_date,
    int? start_time,
    int? end_date,
    int? end_time,
    int? unpaid_break_id,
    String? payable_hour,
  }) = _PostedProposedTime;

  factory PostedProposedTime.fromJson(Map<String, dynamic> json) => _$PostedProposedTimeFromJson(json);
}





