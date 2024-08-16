import 'package:freezed_annotation/freezed_annotation.dart';
part 'skill_dto.freezed.dart';
part 'skill_dto.g.dart';

@freezed
class SkillDTO with _$SkillDTO {
  const factory SkillDTO({
    int? id,
    String? name,
    String? shortName,
    int? answer,
    int? minute,
  }) = _SkillDTO;

  factory SkillDTO.fromJson(Map<String, dynamic> json) =>
      _$SkillDTOFromJson(json);
}
