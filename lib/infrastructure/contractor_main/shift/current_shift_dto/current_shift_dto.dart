// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
part 'current_shift_dto.freezed.dart';
part 'current_shift_dto.g.dart';

@freezed
class CurrentShiftDTO with _$CurrentShiftDTO {
  const factory CurrentShiftDTO({
    int? id,
    int? post_id,
    int? employer_post_user_id,
    String? listing_id,
    String? last_ago,
    int? industry_id,
    String? distance,
    List<SkillDTO>? roles_list,
    String? company_name,
    String? roles_list_name,
    List<SkillDTO>? specialties_detail_list,
    List<SkillDTO>? softwares_skill_list,
    String? software_skill_other,
    String? specialties_detail_other,
    List<SkillDTO>? languages_list,
    String? language_other,
    LocationDTO? location,
    String? location_unit,
    int? remaining_shifts,
    double? rate_hour,
    ShiftDetailDTO? shift_detail,
    String? software_skill,
    String? specialties_detail,
    int? clock_in,
    int? clock_out,
    int? selectedClockInTime,
    int? selectedClockOutTime,
  }) = _CurrentShiftDTO;

  factory CurrentShiftDTO.fromJson(Map<String, dynamic> json) =>
      _$CurrentShiftDTOFromJson(json);
}
