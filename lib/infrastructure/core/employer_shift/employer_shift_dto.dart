import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/account/current_user_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

part 'employer_shift_dto.freezed.dart';

part 'employer_shift_dto.g.dart';

@freezed
class EmployerShiftDto with _$EmployerShiftDto {
  const factory EmployerShiftDto({
    int? id,
    int? post_id,
    int? shift_type,
    int? industry,
    int? start_time,
    int? start_date,
    int? end_date,
    int? end_time,
    String? estimated_payables,
    String? roles_list_name,
    CurrentUserDto? user,
    LocationDTO? location,
    String? remaining_shift,
    String? listing_id,
    bool? isdelete

  }) = _EmployerShiftDto;

  factory EmployerShiftDto.fromJson(Map<String, dynamic> json) => _$EmployerShiftDtoFromJson(json);
}
