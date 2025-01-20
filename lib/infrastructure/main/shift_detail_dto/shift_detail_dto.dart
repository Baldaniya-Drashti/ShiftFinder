// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/payable_dto.dart/payable_dto.dart';
import 'package:shift/infrastructure/main/shift_date_detail_dto/shift_date_detail_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';
part 'shift_detail_dto.freezed.dart';
part 'shift_detail_dto.g.dart';

@freezed
class ShiftDetailDTO with _$ShiftDetailDTO {
  const factory ShiftDetailDTO({
    int? id,
    int? shift_type,
    int? same_or_different_time,
    SkillDTO? unpaid_break,
    String? total_payable_hour,
    int? commute_allowance_type,
    double? commute_allowance_type_details,
    int? accommodation_allowance_type,
    double? accommodation_allowance_type_details,
    int? individual_shift,
    String? shift_note,
    int? vacancie_type,
    int? number_of_vacancie,
    int? pending_vacancie,
    int? recurring_status,
    int? share_team_status,
    int? save_template_status,
    String? disclaimer,
    List<TeamDTO>? teams,
    List<ShiftDateDetailDTO>? detail,
    PayableDTO? payables,
    int? date,
    int? start_time,
    int? end_time,
    int? recurring_start_date,
    int? recurring_end_date,
    String? recurrence_mode,
    int? recurrence_id,
    String? days,
    int? script_volume,
    int? assistant_on_site,
    int? technician_on_site,
  }) = _ShiftDetailDTO;

  factory ShiftDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$ShiftDetailDTOFromJson(json);
}
