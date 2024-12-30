// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
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
    int? shift_type,
    int? shift_date,
    int? start_time,
    int? end_time,
    int? clock_in_time,
    int? clock_out_time,
    int? clock_in_out_status,
    String? reason,
    int? post_id,
    bool? shift_complete,
  }) = _HiredContractorListDTO;

  factory HiredContractorListDTO.fromJson(Map<String, dynamic> json) =>
      _$HiredContractorListDTOFromJson(json);
}
