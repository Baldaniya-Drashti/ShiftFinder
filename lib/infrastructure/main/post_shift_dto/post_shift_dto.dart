// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
part 'post_shift_dto.freezed.dart';
part 'post_shift_dto.g.dart';

@freezed
class PostShiftDTO with _$PostShiftDTO {
  const factory PostShiftDTO({
    String? roles_list_id,
    String? specialties_detail_id,
    String? specialties_detail_other,
    String? softwares_skill_list_id,
    String? software_skill_other,
    String? languages_list_id,
    String? language_other,
    String? location_id,
    String? location_unit,
    double? rate_hour,
    // MultiShiftDTO? shiftDetail,
    // int? post_shift_id,
    int? recurring_status,
    String? start_date,
    int? recurrence_mode,
    String? days,
    String? end_date,
    String? disclaimer,
    int? share_team_status,
    String? team_id,
    int? save_template_status,

    /// New Params
    int? shift_type,
    String? date,
    int? same_or_different_time,
    String? multi_date,
    String? start_time,
    String? end_time,
    int? unpaid_break_id,
    String? total_payable_hour,
    int? commute_allowance_type,
    String? commute_allowance,
    int? accommodation_allowance_type,
    String? accommodation_allowance,
    int? individual_shift,
    String? shift_note,
    int? vacancie_type,
    int? number_of_vacancie,
    String? recurring_start_date,
    String? recurring_end_date,
  }) = _PostShiftDTO;

  factory PostShiftDTO.fromJson(Map<String, dynamic> json) =>
      _$PostShiftDTOFromJson(json);
}
