// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_time_dto.freezed.dart';
part 'date_time_dto.g.dart';

@freezed
class DateTimeDTO with _$DateTimeDTO {
  const factory DateTimeDTO({
    int? id,
    String? start_time,
    String? end_time,
    int? objId,
    String? date,
    String? startHour,
    String? startMinute,
    String? endHour,
    String? endMinute,
    String? totalPaybleHours,
    String? unpaidBreak,
    int? unpaidBreakId,
    @Default(false) bool isUnAvailable,
    String? colorText,
  }) = _DateTimeDTO;

  factory DateTimeDTO.fromJson(Map<String, dynamic> json) =>
      _$DateTimeDTOFromJson(json);
}
