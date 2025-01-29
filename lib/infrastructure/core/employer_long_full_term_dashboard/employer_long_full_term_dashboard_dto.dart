import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/employer_long_term_add_detail_dto/employer_long_term_add_detail_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

import '../contractor_home/contractor_dashboard_dto.dart';

part 'employer_long_full_term_dashboard_dto.freezed.dart';

part 'employer_long_full_term_dashboard_dto.g.dart';

@freezed
class EmployerLongFullTermDashboardDto with _$EmployerLongFullTermDashboardDto {
  const factory EmployerLongFullTermDashboardDto({
    int? id,
    String? listing_id,
    String? roles_list_name,
    String? last_ago,
    String? position,
    String? shift_schedule_type,
    int? industry,
    int? job_type,
    LocationDTO? location,
    @DateTimeConverter() DateTime? start_date,
    @DateTimeConverter() DateTime? end_date,
    @DateTimeConverter() DateTime? application_deadline,
    @TimeConverter() TimeOfDay? estimated_weekly_hours,
    int? number_of_vacancie,
    int? pending_vacancie,
    int? total_application_counts,
    List<ApplicationProfile>? total_application_profiles,
    bool? isEditable,
  }) = _EmployerLongTermOpenPositionDto;

  factory EmployerLongFullTermDashboardDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerLongFullTermDashboardDtoFromJson(json);
}
