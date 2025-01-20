import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employer_long_term_add_detail_dto.freezed.dart';

part 'employer_long_term_add_detail_dto.g.dart';

@freezed
class EmployerLongTermAddDetailDto with _$EmployerLongTermAddDetailDto {
  const factory EmployerLongTermAddDetailDto({
    @DateTimeConverter() DateTime? start_date,
    @DateTimeConverter() DateTime? end_date,
    @DateTimeConverter() DateTime? applicationDeadline,
    int? shift_schedule_type,
    String? job_description,
    String? requirements,
    String? responsibilities,
    String? benefits,
    String? qualifications,
    String? onboarding_process,
    int? on_call_included,
    String? licenses_certifications,
    String? terms_document,
    @TimeConverter() TimeOfDay? estimated_weekly_hours,
    int? share_team_status,
    int? employer_payment_confirmation,
    int? save_template_status,
    int? vacancie_type,
  }) = _EmployerLongTermAddDetailDto;

  factory EmployerLongTermAddDetailDto.fromJson(Map<String, dynamic> json) => _$EmployerLongTermAddDetailDtoFromJson(json);
}

class DateTimeConverter extends JsonConverter<DateTime?, int?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(int? json) {
    if (json == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(json * 1000);
  }

  @override
  int? toJson(DateTime? object) {
    if (object == null) return null;
    return object.toUtc().millisecondsSinceEpoch ~/ 1000;
  }
}

class TimeConverter extends JsonConverter<TimeOfDay?, String?> {
  const TimeConverter();

  @override
  TimeOfDay? fromJson(String? json) {
    if (json == null) return null;
    return _convertStringToTimeOfDay(json);
  }

  @override
  String? toJson(TimeOfDay? object) {
    if (object == null) return null;
    return _formatTimeOfDay(object);
  }

  TimeOfDay _convertStringToTimeOfDay(String timeString) {
    final regex = RegExp(r'(\d{2})\s*h\s*(\d{2})\s*min');
    final match = regex.firstMatch(timeString);

    if (match != null) {
      int hours = int.parse(match.group(1)!);
      int minutes = int.parse(match.group(2)!);
      return TimeOfDay(hour: hours, minute: minutes);
    } else {
      throw FormatException("Invalid time format");
    }
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    String hours = timeOfDay.hour.toString().padLeft(2, '0');
    String minutes = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hours h $minutes min';
  }
}
