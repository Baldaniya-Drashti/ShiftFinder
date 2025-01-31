import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

part 'contractor_previus_shift_dto.freezed.dart';

part 'contractor_previus_shift_dto.g.dart';

@freezed
class ContractorPreviousShiftDTO with _$ContractorPreviousShiftDTO {
  const factory ContractorPreviousShiftDTO({
    int? id,
    int? post_id,
    int? applicants_id,
    String? listing_id,
    String? last_ago,
    String? roles_list_name,
    int? industry,
    String? company_name,
    String? distance,
    LocationDTO? location,
    int? start_date,
    int? start_time,
    int? end_date,
    int? end_time,
    String? reason,
    int? shift_type,
    int? total_shifts,
    List<PreviousShiftDetailDTO>? shift_date,
  }) = _ContractorPreviousShiftDTO;

  factory ContractorPreviousShiftDTO.fromJson(Map<String, dynamic> json) =>
      _$ContractorPreviousShiftDTOFromJson(json);
}

@freezed
class PreviousShiftDetailDTO with _$PreviousShiftDetailDTO {
  const factory PreviousShiftDetailDTO({
    int? id,
    int? start_date,
    int? start_time,
    int? end_date,
    int? end_time,
    int? unpaid_break_id,
    String? payable_hour,
  }) = _PreviousShiftDetailDTO;

  factory PreviousShiftDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$PreviousShiftDetailDTOFromJson(json);
}
