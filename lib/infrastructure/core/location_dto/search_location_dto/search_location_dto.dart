import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_location_dto.freezed.dart';
part 'search_location_dto.g.dart';

@freezed
class SearchLocationDTO with _$SearchLocationDTO {
  const factory SearchLocationDTO({
    List<dynamic>? html_attributions,
    List<Results>? results,
    String? status,
  }) = _SearchLocationDTO;

  factory SearchLocationDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationDTOFromJson(json);
}

@freezed
class Results with _$Results {
  const factory Results({
    String? formatted_address,
    Geometry? geometry,
    String? icon,
    String? icon_background_color,
    String? icon_mask_base_uri,
    String? name,
    String? place_id,
    PlusCode? plus_code,
    String? reference,
    List<String>? types,
  }) = _Results;

  factory Results.fromJson(Map<String, dynamic> json) =>
      _$ResultsFromJson(json);
}

@freezed
class Geometry with _$Geometry {
  const factory Geometry({
    Location? location,
    Viewport? viewport,
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    double? lat,
    double? lng,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class Viewport with _$Viewport {
  const factory Viewport({
    Northeast? northeast,
    Southwest? southwest,
  }) = _Viewport;

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);
}

@freezed
class Northeast with _$Northeast {
  const factory Northeast({
    double? lat,
    double? lng,
  }) = _Northeast;

  factory Northeast.fromJson(Map<String, dynamic> json) =>
      _$NortheastFromJson(json);
}

@freezed
class Southwest with _$Southwest {
  const factory Southwest({
    double? lat,
    double? lng,
  }) = _Southwest;

  factory Southwest.fromJson(Map<String, dynamic> json) =>
      _$SouthwestFromJson(json);
}

@freezed
class PlusCode with _$PlusCode {
  const factory PlusCode({
    String? compound_code,
    String? global_code,
  }) = _PlusCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) =>
      _$PlusCodeFromJson(json);
}
