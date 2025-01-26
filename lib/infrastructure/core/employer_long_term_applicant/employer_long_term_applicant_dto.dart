import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer_long_term_applicant_dto.freezed.dart';

part 'employer_long_term_applicant_dto.g.dart';

@freezed
class EmployerLongTermApplicantDto with _$EmployerLongTermApplicantDto {
  const factory EmployerLongTermApplicantDto({
    int? id,
    int? user_id,
    int? post_id,
    String? profile,
    String? first_name,
    String? last_name,
    String? last_ago,
    String? distance,
    String? location,
    double? latitude,
    double? longitude,
    int? request,
    int? urgent_action,
    int? revoke_status,
    int? revoke_start,
    bool? occupied,
    bool? accept_btn_toggle,
    String? total_months,
    String? monthly_service_fee,
    String? total_amount_payable,
    int? deleteAt,
  }) = _EmployerLongTermApplicantDto;

  factory EmployerLongTermApplicantDto.fromJson(Map<String, dynamic> json) => _$EmployerLongTermApplicantDtoFromJson(json);
}
