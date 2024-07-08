import 'package:freezed_annotation/freezed_annotation.dart';

part 'speciality_dto.freezed.dart';
part 'speciality_dto.g.dart';

@freezed
class SpecialityDTO with _$SpecialityDTO {
  factory SpecialityDTO(
      {String? specialityName, String? specialityExperience}) = _SpecialityDTO;

  factory SpecialityDTO.fromJson(Map<String, dynamic> json) =>
      _$SpecialityDTOFromJson(json);
}
