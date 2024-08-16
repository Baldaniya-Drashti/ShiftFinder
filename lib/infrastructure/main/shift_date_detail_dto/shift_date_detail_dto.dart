// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'shift_date_detail_dto.freezed.dart';
part 'shift_date_detail_dto.g.dart';

@freezed
class ShiftDateDetailDTO with _$ShiftDateDetailDTO {
  const factory ShiftDateDetailDTO({
    int? id,
    int? recurrence_mode,
    int? start_date,
    int? start_time,
    int? end_date,
    int? end_time,
    int? days,
  }) = _ShiftDateDetailDTO;

  factory ShiftDateDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$ShiftDateDetailDTOFromJson(json);
}
