// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
class LocationDTO with _$LocationDTO {
  const factory LocationDTO({
    final int? id,
    final String? location,
    final double? latitude,
    final double? longitude,
    final List<UnitDTO>? add_units,
    final FacilityTypeDto? facility_type,
    final FacilityTypeDto? location_brand,
    final String? accreditation_number,
    final String? location_note,
    final String? location_id,
  }) = _LocationDTO;

  factory LocationDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationDTOFromJson(json);
}

@freezed
class UnitDTO with _$UnitDTO {
  const factory UnitDTO({
    final String? number_or_name,
    final String? note,
  }) = _UnitDTO;

  factory UnitDTO.fromJson(Map<String, dynamic> json) =>
      _$UnitDTOFromJson(json);
}

@freezed
class FacilityTypeDto with _$FacilityTypeDto {
  const factory FacilityTypeDto({
    final int? id,
    final String? name,
  }) = _FacilityTypeDto;

  factory FacilityTypeDto.fromJson(Map<String, dynamic> json) =>
      _$FacilityTypeDtoFromJson(json);
}
