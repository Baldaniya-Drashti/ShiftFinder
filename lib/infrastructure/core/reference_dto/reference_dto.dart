// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'reference_dto.freezed.dart';
part 'reference_dto.g.dart';

@freezed
class ReferenceDTO with _$ReferenceDTO {
  const factory ReferenceDTO({
    int? id,
    int? type,
    String? job_position,
    String? email,
    String? country_code,
    String? country_name_code,
    int? phone,
    String? organization,
    String? referrer,
    String? job_latitude,
    String? job_longitude,
    String? job_location,
    String? unit,
    int? start_date,
    int? end_date,
    String? contact_person,
    String? profession_referrer,
  }) = _ReferenceDTO;

  factory ReferenceDTO.fromJson(Map<String, dynamic> json) =>
      _$ReferenceDTOFromJson(json);
}
