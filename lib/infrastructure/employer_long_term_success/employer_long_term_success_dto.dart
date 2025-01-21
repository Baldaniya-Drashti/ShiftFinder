import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';

part 'employer_long_term_success_dto.freezed.dart';

part 'employer_long_term_success_dto.g.dart';

@freezed
class EmployerLongTermSuccessDto with _$EmployerLongTermSuccessDto {
  const factory EmployerLongTermSuccessDto({
    int? id,
    int? post_id,
    int? user_id,
    String? listing_id,
    String? last_ago,
    String? company_name,
    String? distance,
    List<SkillDTO>? roles_list,
    String? roles_list_name,
    List<SkillDTO>? specialties_detail_list,
    List<SkillDTO>? softwares_skill_list,
    String? software_skill_other,
    String? specialties_detail_other,
    List<SkillDTO>? languages_list,
    String? language_other,
    LocationDTO? location,
    String? location_unit,
    double? rate_hour,
    String? software_skill,
    String? specialties_detail,
    String? reason,
    String? monthly_service_fee,
    String? total_amount_payable,
    int? total_months,
    int? number_of_vacancie,
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
    @TimeConverter() TimeOfDay? estimated_weekly_hours,
    @Default(0) int? share_team_status,
    @Default(0) int? employer_payment_confirmation,
    @Default(0) int? save_template_status,
    @Default(0) int? vacancie_type,
    int? job_type,
    int? industry,
  }) = _EmployerLongTermSuccessDto;

  factory EmployerLongTermSuccessDto.fromJson(Map<String, dynamic> json) => _$EmployerLongTermSuccessDtoFromJson(json);
}
