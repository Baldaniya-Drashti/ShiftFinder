// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';

part 'speciality_dto.freezed.dart';
part 'speciality_dto.g.dart';

// @freezed
// class SpecialityDTO with _$SpecialityDTO {
//   factory SpecialityDTO({
//     String? specialityName,
//     String? specialityExperience,
//   }) = _SpecialityDTO;

//   factory SpecialityDTO.fromJson(Map<String, dynamic> json) =>
//       _$SpecialityDTOFromJson(json);
// }

@freezed
class SpecialityDTO with _$SpecialityDTO {
  const factory SpecialityDTO({
    int? id,
    String? name,
    String? shortName,
    int? experienceId,
    String? specialityExperience,
    String? specialityOther,
    SkillDTO? specialtie_lists,
    SkillDTO? experience_lists,
    String? specialtie_lists_other,
    String? experience_other,
  }) = _SpecialityDTO;

  factory SpecialityDTO.fromJson(Map<String, dynamic> json) =>
      _$SpecialityDTOFromJson(json);
}
