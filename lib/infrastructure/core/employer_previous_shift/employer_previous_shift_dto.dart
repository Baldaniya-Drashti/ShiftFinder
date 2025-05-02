import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer_previous_shift_dto.freezed.dart';

part 'employer_previous_shift_dto.g.dart';

@freezed
class EmployerPreviousShiftDto with _$EmployerPreviousShiftDto {
  const factory EmployerPreviousShiftDto({
    int? post_id,
    int? id,
    int? user_id,
    String? first_name,
    String? last_name,
    String? profile,
    String? role_lists_name,
    int? rating,
    double? all_over_rating,
    double? latitude,
    double? longitude,
    String? location,
    String? remarks,
    String? distance,
    int? last_worked_date,
    int? last_worked_start_time,
    int? last_worked_end_time,
    bool? isRating,
    bool? isFavourite,
    bool? isRemark,
    bool? isBlock,
    String? email,
    String? remark,
    String? total_amount,
    int? is_payment,
  }) = _EmployerPreviousShiftDto;

  factory EmployerPreviousShiftDto.fromJson(Map<String, dynamic> json) =>
      _$EmployerPreviousShiftDtoFromJson(json);
}
