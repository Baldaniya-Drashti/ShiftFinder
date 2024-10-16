import 'package:freezed_annotation/freezed_annotation.dart';


part 'total_proposal_dto.freezed.dart';

part 'total_proposal_dto.g.dart';


@freezed
class TotalProposalDto with _$TotalProposalDto {
  const factory TotalProposalDto({
    int? id,
    String? first_name,
    String? last_name,
    String? profile,
    int? user_id,
  }) = _TotalProposalDto;

  factory TotalProposalDto.fromJson(Map<String, dynamic> json) => _$TotalProposalDtoFromJson(json);
}
