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
  }) = _EmployerLongTermAddDetailDto;

  factory EmployerLongTermAddDetailDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerLongTermAddDetailDtoFromJson(json);
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
    return 0;
  }
}
