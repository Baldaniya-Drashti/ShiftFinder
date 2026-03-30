import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_location_dto.freezed.dart';
part 'search_location_dto.g.dart';

@freezed
class SearchLocationDTO with _$SearchLocationDTO {
  const factory SearchLocationDTO({
    List<Predictions>? predictions,
    String? status,
  }) = _SearchLocationDTO;

  factory SearchLocationDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationDTOFromJson(json);
}

@freezed
class Predictions with _$Predictions {
  const factory Predictions({
    String? description,
    List<MatchedSubstrings>? matched_substrings,
    String? place_id,
    String? reference,
    StructuredFormatting? structured_formatting,
    List<Terms>? terms,
    List<String>? types,
  }) = _Predictions;

  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);
}

@freezed
class MatchedSubstrings with _$MatchedSubstrings {
  const factory MatchedSubstrings({
    int? length,
    int? offset,
  }) = _MatchedSubstrings;

  factory MatchedSubstrings.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringsFromJson(json);
}

@freezed
class StructuredFormatting with _$StructuredFormatting {
  const factory StructuredFormatting({
    String? main_text,
    List<MainTextMatchedSubstrings>? main_text_matched_substrings,
    String? secondary_text,
  }) = _StructuredFormatting;

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);
}

@freezed
class MainTextMatchedSubstrings with _$MainTextMatchedSubstrings {
  const factory MainTextMatchedSubstrings({
    int? length,
    int? offset,
  }) = _MainTextMatchedSubstrings;

  factory MainTextMatchedSubstrings.fromJson(Map<String, dynamic> json) =>
      _$MainTextMatchedSubstringsFromJson(json);
}

@freezed
class Terms with _$Terms {
  const factory Terms({
    int? offset,
    String? value,
  }) = _Terms;

  factory Terms.fromJson(Map<String, dynamic> json) => _$TermsFromJson(json);
}
