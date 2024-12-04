// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'faq_dto.freezed.dart';
part 'faq_dto.g.dart';

@freezed
class FaqDTO with _$FaqDTO {
  const factory FaqDTO({
    int? id,
    String? question,
    String? answer,
  }) = _FaqDTO;

  factory FaqDTO.fromJson(Map<String, dynamic> json) => _$FaqDTOFromJson(json);
}
