
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer_applicant_dto.freezed.dart';
part 'employer_applicant_dto.g.dart';
@freezed
class EmployerApplicantsDto with _$EmployerApplicantsDto{
  const factory EmployerApplicantsDto({
    int? id,
    int? user_id,
    String? profile,
    String? first_name,
    String? last_name,
    String? last_ago,
    String? distance,
    String? location,
    double? latitude,
    double? longitude,
    int? request,
    int? revoke_status,
    dynamic revoke_start,

  }) = _EmployerApplicantsDto;

  factory EmployerApplicantsDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerApplicantsDtoFromJson(json);
}