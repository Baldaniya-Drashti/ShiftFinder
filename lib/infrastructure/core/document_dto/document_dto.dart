// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'document_dto.freezed.dart';
part 'document_dto.g.dart';

@freezed
class DocumentDTO with _$DocumentDTO {
  const factory DocumentDTO({
    int? id,
    int? document_type,
    String? file,
    int? expiry_date,
    String? registration_number,
    String? province_of_registration,
    String? document_title,
    String? name_of_vaccinations,
    int? expiry_date_not_applicable,
  }) = _DocumentDTO;

  factory DocumentDTO.fromJson(Map<String, dynamic> json) =>
      _$DocumentDTOFromJson(json);
}
