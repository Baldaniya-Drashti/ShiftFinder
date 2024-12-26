import 'package:freezed_annotation/freezed_annotation.dart';
part 'skill_dto.freezed.dart';
part 'skill_dto.g.dart';

@freezed
class SkillDTO with _$SkillDTO {
  const factory SkillDTO({
    int? id,
    String? name,
    String? short_name,
    int? answer,
    int? minute,
    bool? isMandatory,
    String? yearLimit,
  }) = _SkillDTO;

  factory SkillDTO.fromJson(Map<String, dynamic> json) =>
      _$SkillDTOFromJson(json);
}
