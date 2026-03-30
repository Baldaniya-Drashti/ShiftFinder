// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'education_dto.freezed.dart';
part 'education_dto.g.dart';

@freezed
class EducationDTO with _$EducationDTO {
  const factory EducationDTO({
    int? id,
    String? program_completed,
    String? year_of_completion,
    String? graduating_institution,
  }) = _EducationDTO;

  factory EducationDTO.fromJson(Map<String, dynamic> json) =>
      _$EducationDTOFromJson(json);
}
