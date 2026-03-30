// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';

part 'multi_shift_dto.freezed.dart';
part 'multi_shift_dto.g.dart';

@freezed
class MultiShiftDTO with _$MultiShiftDTO {
  const factory MultiShiftDTO({
    int? post_id,
    int? shift_type,
    String? date,
    int? same_or_different_time,
    List<DateTimeDTO>? multi_date,
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
    int? script_volume,
    int? assistant_on_site,
    int? technician_on_site,
  }) = _MultiShiftDTO;

  factory MultiShiftDTO.fromJson(Map<String, dynamic> json) =>
      _$MultiShiftDTOFromJson(json);
}
