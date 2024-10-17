// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
part 'hired_contractor_list_dto.freezed.dart';
part 'hired_contractor_list_dto.g.dart';

@freezed
class HiredContractorListDTO with _$HiredContractorListDTO {
  const factory HiredContractorListDTO({
    int? id,
    int? user_id,
    String? first_name,
    String? last_name,
    String? profile,
    int? contractor_shift_type,
  }) = _HiredContractorListDTO;

  factory HiredContractorListDTO.fromJson(Map<String, dynamic> json) =>
      _$HiredContractorListDTOFromJson(json);
}
