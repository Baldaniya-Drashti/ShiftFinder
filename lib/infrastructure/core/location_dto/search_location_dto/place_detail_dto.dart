import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_detail_dto.freezed.dart';
part 'place_detail_dto.g.dart';

@freezed
class PlaceDetailDTO with _$PlaceDetailDTO {
  const factory PlaceDetailDTO({
    Result? result,
    String? status,
  }) = _PlaceDetailDTO;

  factory PlaceDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailDTOFromJson(json);
}

@freezed
class Result with _$Result {
  const factory Result({
    Geometry? geometry,
  }) = _Result;

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
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
    String? city,
    String? state,
    String? postalCode,
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
