// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
class LocationDTO with _$LocationDTO {
  const factory LocationDTO({
    int? id,
    String? location,
    List<UnitDTO>? add_units,
  }) = _LocationDTO;

  factory LocationDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationDTOFromJson(json);
}

@freezed
class UnitDTO with _$UnitDTO {
  const factory UnitDTO({
    String? number_or_name,
    String? note,
  }) = _UnitDTO;

  factory UnitDTO.fromJson(Map<String, dynamic> json) =>
      _$UnitDTOFromJson(json);
}
