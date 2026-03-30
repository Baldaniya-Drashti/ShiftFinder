// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'my_calendar_dto.freezed.dart';
part 'my_calendar_dto.g.dart';

@freezed
class MyCalendarDTO with _$MyCalendarDTO {
  const factory MyCalendarDTO({
    String? employer_post_id,
    int? date,
    @Default(false) bool isUnAvailable,
    String? colorText,
  }) = _MyCalendarDTO;

  factory MyCalendarDTO.fromJson(Map<String, dynamic> json) =>
      _$MyCalendarDTOFromJson(json);
}

@freezed
class ContractorMyCalendarListDTO with _$ContractorMyCalendarListDTO {
  const factory ContractorMyCalendarListDTO({
    int? id,
    int? employer_user_id,
    int? shift_type,
    int? application_id,
    String? roles_list_name,
    String? company_name,
    int? industry_id,
    String? listing_id,
    LocationDTO? location,
    String? distance,
    int? date,
    int? start_time,
    int? end_time,
    int? total_shift,
    int? count,
  }) = _ContractorMyCalendarListDTO;

  factory ContractorMyCalendarListDTO.fromJson(Map<String, dynamic> json) =>
      _$ContractorMyCalendarListDTOFromJson(json);
}

@freezed
class ContractorMyCalendarDTO with _$ContractorMyCalendarDTO {
  const factory ContractorMyCalendarDTO({
    List<ContractorMyCalendarListDTO>? list,
    int? current_date,
  }) = _ContractorMyCalendarDTO;

  factory ContractorMyCalendarDTO.fromJson(Map<String, dynamic> json) =>
      _$ContractorMyCalendarDTOFromJson(json);
}
