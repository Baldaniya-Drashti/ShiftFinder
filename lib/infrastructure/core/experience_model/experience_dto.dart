import 'package:freezed_annotation/freezed_annotation.dart';
part 'experience_dto.freezed.dart';
part 'experience_dto.g.dart';

@freezed
class ExperienceDTO with _$ExperienceDTO {
  factory ExperienceDTO({
    String? name,
    String? year,
    String? month,
  }) = _ExperienceDTO;

  factory ExperienceDTO.fromJson(Map<String, dynamic> json) =>
      _$ExperienceDTOFromJson(json);
}
