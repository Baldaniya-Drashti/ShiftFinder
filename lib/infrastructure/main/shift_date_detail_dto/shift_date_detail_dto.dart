// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
part 'shift_date_detail_dto.freezed.dart';
part 'shift_date_detail_dto.g.dart';

@freezed
class ShiftDateDetailDTO with _$ShiftDateDetailDTO {
  const factory ShiftDateDetailDTO({
    int? id,
    int? recurrence_mode,
    int? start_time,
    int? date,
    int? end_time,
    String? days,
    int? objId,
    String? startHour,
    String? startMinute,
    String? endHour,
    String? endMinute,
    String? totalPaybleHours,
    SkillDTO? unpaid_break,
  }) = _ShiftDateDetailDTO;

  factory ShiftDateDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$ShiftDateDetailDTOFromJson(json);
}
