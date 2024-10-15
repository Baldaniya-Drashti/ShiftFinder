// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
part 'experience_dto.freezed.dart';
part 'experience_dto.g.dart';

@freezed
class ExperienceDTO with _$ExperienceDTO {
  factory ExperienceDTO({
    int? id,
    String? name,
    CompleteProfileDataDto? role,
    String? experience_year,
    String? experience_month,
  }) = _ExperienceDTO;

  factory ExperienceDTO.fromJson(Map<String, dynamic> json) =>
      _$ExperienceDTOFromJson(json);
}
