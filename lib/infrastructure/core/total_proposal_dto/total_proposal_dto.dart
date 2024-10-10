import 'package:freezed_annotation/freezed_annotation.dart';

import '../employer_home/employer_dashboard_dto.dart';

part 'total_proposal_dto.freezed.dart';

part 'total_proposal_dto.g.dart';

@freezed
class TotalProposalDto with _$TotalProposalDto {
  const factory TotalProposalDto({
    TotalProposalDataDto? data,
    TotalProposalAdditionalDataDto? additional_data,
  }) = _TotalProposalDto;

  factory TotalProposalDto.fromJson(Map<String, dynamic> json) => _$TotalProposalDtoFromJson(json);
}

@freezed
class TotalProposalAdditionalDataDto with _$TotalProposalAdditionalDataDto {
  const factory TotalProposalAdditionalDataDto({
    int? id,
    String? role_lists_name,
    int? industry,
    String? profile,
    String? listing_id,
    String? last_ago,
    Location? location,
    int? start_date,
    int? start_time,
    int? end_time,
  }) = _TotalProposalAdditionalDataDto;

  factory TotalProposalAdditionalDataDto.fromJson(Map<String, dynamic> json) => _$TotalProposalAdditionalDataDtoFromJson(json);
}

@freezed
class TotalProposalDataDto with _$TotalProposalDataDto {
  const factory TotalProposalDataDto({
    int? id,
    String? first_name,
    String? last_name,
    String? profile,
  }) = _TotalProposalDataDto;

  factory TotalProposalDataDto.fromJson(Map<String, dynamic> json) => _$TotalProposalDataDtoFromJson(json);
}
