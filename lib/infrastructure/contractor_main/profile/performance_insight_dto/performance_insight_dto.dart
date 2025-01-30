import 'package:freezed_annotation/freezed_annotation.dart';
part 'performance_insight_dto.freezed.dart';
part 'performance_insight_dto.g.dart';

@freezed
class PerformanceInsightDTO with _$PerformanceInsightDTO {
  const factory PerformanceInsightDTO({
    int? date,
    double? total_earnings,
    String? total_hours,
    int? completed_shifts,
    EarningOverTimeDTO? earning_over_time,
    HourWorkedDTO? hours_worked,
    CompletedShiftMapDTO? completed_shift_map,
  }) = _PerformanceInsightDTO;

  factory PerformanceInsightDTO.fromJson(Map<String, dynamic> json) =>
      _$PerformanceInsightDTOFromJson(json);
}

@freezed
class EarningOverTimeDTO with _$EarningOverTimeDTO {
  const factory EarningOverTimeDTO({
    // List<String>? week_lists,
    List<InsightListDTO>? list,
    // List<double>? amounts,
    List<String>? heights,
  }) = _EarningOverTimeDTO;

  factory EarningOverTimeDTO.fromJson(Map<String, dynamic> json) =>
      _$EarningOverTimeDTOFromJson(json);
}

@freezed
class InsightListDTO with _$InsightListDTO {
  const factory InsightListDTO({
    String? name,
    double? value,
  }) = _InsightListDTO;

  factory InsightListDTO.fromJson(Map<String, dynamic> json) =>
      _$InsightListDTOFromJson(json);
}

@freezed
class HourWorkedDTO with _$HourWorkedDTO {
  const factory HourWorkedDTO({
    // List<String>? hours_list,
    // List<String>? hours,
    List<InsightListDTO>? list,
    List<String>? heights,
  }) = _HourWorkedDTO;

  factory HourWorkedDTO.fromJson(Map<String, dynamic> json) =>
      _$HourWorkedDTOFromJson(json);
}

@freezed
class CompletedShiftMapDTO with _$CompletedShiftMapDTO {
  const factory CompletedShiftMapDTO({
    // List<String>? shifts_lists,
    // List<int>? shifts,
    List<InsightListDTO>? list,
    List<int>? heights,
  }) = _CompletedShiftMapDTO;

  factory CompletedShiftMapDTO.fromJson(Map<String, dynamic> json) =>
      _$CompletedShiftMapDTOFromJson(json);
}
