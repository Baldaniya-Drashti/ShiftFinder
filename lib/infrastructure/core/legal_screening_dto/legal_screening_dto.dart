import 'package:freezed_annotation/freezed_annotation.dart';
part 'legal_screening_dto.freezed.dart';
part 'legal_screening_dto.g.dart';

@freezed
class LegalScreeningDTO with _$LegalScreeningDTO {
  const factory LegalScreeningDTO({
    int? id,
    String? name,
    int? isNa,
    int? answer,
  }) = _LegalScreeningDTO;

  factory LegalScreeningDTO.fromJson(Map<String, dynamic> json) =>
      _$LegalScreeningDTOFromJson(json);
}

@freezed
class LegalScreeningAnswerDTO with _$LegalScreeningAnswerDTO {
  const factory LegalScreeningAnswerDTO({
    int? user_id,
    int? answer,
    int? question_list_id,
  }) = _LegalScreeningAnswerDTO;

  factory LegalScreeningAnswerDTO.fromJson(Map<String, dynamic> json) =>
      _$LegalScreeningAnswerDTOFromJson(json);
}
