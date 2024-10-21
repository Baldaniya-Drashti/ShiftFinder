import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/account/current_user_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

part 'employer_shift_dto.freezed.dart';

part 'employer_shift_dto.g.dart';

@freezed
class EmployerShiftDto with _$EmployerShiftDto {
  const factory EmployerShiftDto({
    int? id,
    String? listing_id,
    String? roles_list_name,
    int? industry,
    int? shift_type,
    LocationDTO? location,
    int? start_time,
    int? start_date,
    int? end_date,
    int? end_time,
    double? estimated_payables,
    int? total_shifts,
    HiredContractorDTO? user,
    int? total_user,
    int? remaining_shift,
    bool? isdelete,
  }) = _EmployerShiftDto;

  factory EmployerShiftDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerShiftDtoFromJson(json);
}

@freezed
class HiredContractorDTO with _$HiredContractorDTO {
  const factory HiredContractorDTO({
    int? user_id,
    String? first_name,
    String? last_name,
    String? profile,
  }) = _HiredContractorDTO;

  factory HiredContractorDTO.fromJson(Map<String, dynamic> json) =>
      _$HiredContractorDTOFromJson(json);
}
