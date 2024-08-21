// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
part 'healthcare_post_dto.freezed.dart';
part 'healthcare_post_dto.g.dart';

@freezed
class HealthcarePostDTO with _$HealthcarePostDTO {
  const factory HealthcarePostDTO({
    int? id,
    String? listing_id,
    String? last_ago,
    List<SkillDTO>? roles_list,
    String? roles_list_name,
    List<SpecialityDTO>? specialties_detail_list,
    List<SkillDTO>? softwares_skill_list,
    String? software_skill_other,
    List<SkillDTO>? languages_list,
    String? language_other,
    LocationDTO? location,
    String? location_unit,
    double? rate_hour,
    ShiftDetailDTO? shift_detail,
    String? software_skill,
    String? specialties_detail,
  }) = _HealthcarePostDTO;

  factory HealthcarePostDTO.fromJson(Map<String, dynamic> json) =>
      _$HealthcarePostDTOFromJson(json);
}
