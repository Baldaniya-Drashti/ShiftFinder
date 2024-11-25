import 'package:freezed_annotation/freezed_annotation.dart';
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
    String? unpaid_break,
    double? estimated_payables,
    int? total_shifts,
    int? total_shift,
    HiredContractorDTO? user,
    List<HiredContractorDTO>? users,
    int? total_user,
    int? hired_user,
    int? remaining_shift,
    bool? isdelete,
    int? compassion,
    int? cancel_shift,
    int? total_contractor,
    bool? isCad,
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
    String? reason,
  }) = _HiredContractorDTO;

  factory HiredContractorDTO.fromJson(Map<String, dynamic> json) =>
      _$HiredContractorDTOFromJson(json);
}
