// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';
part 'contractor_complete_profile_dto.freezed.dart';
part 'contractor_complete_profile_dto.g.dart';

@freezed
class ContractorCompleteProfileDTO with _$ContractorCompleteProfileDTO {
  factory ContractorCompleteProfileDTO({
    int? id,
    List<ExperienceDTO>? roles_list,
    List<ExperienceDTO>? specialties_detail,
    List<ExperienceDTO>? softwares_skill_list,
    String? software_skill_other,
    String? specialties_other,
    List<ExperienceDTO>? languages_list,
    String? language_other,
  }) = _ContractorCompleteProfileDTO;

  factory ContractorCompleteProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$ContractorCompleteProfileDTOFromJson(json);
}
