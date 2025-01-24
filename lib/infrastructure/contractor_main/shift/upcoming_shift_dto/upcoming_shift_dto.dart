// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'upcoming_shift_dto.freezed.dart';
part 'upcoming_shift_dto.g.dart';

@freezed
class UpComingShiftDTO with _$UpComingShiftDTO {
  const factory UpComingShiftDTO({
    int? id,
    int? post_id,
    int? employer_post_user_id,
    String? role_lists_name,
    String? company_name,
    String? profile,
    int? industry_id,
    String? listing_id,
    String? distance,
    double? longitude,
    double? latitude,
    String? location,
    FacilityTypeDto? facility_type,
    String? facility_type_other,
    int? request,
    int? urgent_action,
    int? revoke_status,
    String? last_ago,
    int? applied_date,
    bool? check_delete,
    int? date,
    int? start_time,
    int? end_time,
    int? shift_type,
    int? total_shift,
    bool? isCad,
  }) = _UpComingShiftDTO;

  factory UpComingShiftDTO.fromJson(Map<String, dynamic> json) =>
      _$UpComingShiftDTOFromJson(json);
}
