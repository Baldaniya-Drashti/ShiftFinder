import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
part 'employer_long_term_add_detail_dto.freezed.dart';
part 'employer_long_term_add_detail_dto.g.dart';

@freezed
class EmployerLongTermAddDetailDto with _$EmployerLongTermAddDetailDto {
  const factory EmployerLongTermAddDetailDto({
    @DateTimeConverter() DateTime? start_date,
    @DateTimeConverter() DateTime? end_date,
    @DateTimeConverter() DateTime? application_deadline,
    String? shift_schedule_type,
    String? job_description,
    String? requirements,
    String? responsibilities,
    String? benefits,
    String? qualifications,
    String? onboarding_process,
    @Default(0) int? on_call_included,
    String? licenses_certifications,
    String? terms_document,
    String? terms,
    @TimeConverter() TimeOfDay? estimated_weekly_hours,
    @Default(0) int? share_team_status,
    @Default(0) int? employer_payment_confirmation,
    @Default(0) int? save_template_status,
    @Default(0) int? vacancie_type,
    int? number_of_vacancie,
    int? job_type,
  }) = _EmployerLongTermAddDetailDto;

  factory EmployerLongTermAddDetailDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerLongTermAddDetailDtoFromJson(json);
}

class DateTimeConverter extends JsonConverter<DateTime?, int?> {
  const DateTimeConverter();

  @override
  DateTime? fromJson(int? json) {
    if (json == null) return null;
    return CustomDateTimeFormat.timeStampToDateTime(json);
  }

  @override
  int? toJson(DateTime? object) {
    if (object == null) return null;
    return CustomDateTimeFormat.dateTimeToUtcTimestamp(object, isInt: true);
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
    final regex = RegExp(r'(\d{1,2})\s*h\s*(\d{1,2})\s*min');
    final match = regex.firstMatch(timeString);

    if (match != null) {
      int hours = int.parse(match.group(1)!);
      int minutes = int.parse(match.group(2)!);

      // Ensure valid TimeOfDay range (0-23 hours, 0-59 minutes)
      if (hours >= 0 && hours < 24 && minutes >= 0 && minutes < 60) {
        return TimeOfDay(hour: hours, minute: minutes);
      }
    }

    throw FormatException("Invalid time format: $timeString");
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    String hours = timeOfDay.hour.toString().padLeft(2, '0');
    String minutes = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hours h $minutes min';
  }
}
