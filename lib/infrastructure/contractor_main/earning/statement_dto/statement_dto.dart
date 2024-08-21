// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'statement_dto.freezed.dart';
part 'statement_dto.g.dart';

@freezed
class StatementDTO with _$StatementDTO {
  const factory StatementDTO({
    List<StatementDetailDTO>? list,
    StatementAdditionalDetailDTO? additional_data,
  }) = _StatementDTO;

  factory StatementDTO.fromJson(Map<String, dynamic> json) =>
      _$StatementDTOFromJson(json);
}

@freezed
class StatementDetailDTO with _$StatementDetailDTO {
  const factory StatementDetailDTO({
    int? id,
    int? post_id,
    int? invoice_no,
    int? date,
    String? company_name,
    LocationDTO? location,
    String? hours_worked,
    double? hourly_rate,
    double? total_wage,
    double? total_allowance,
    double? total_earnings,
    double? amount,
    String? referred_contractor_name,
  }) = _StatementDetailDTO;

  factory StatementDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$StatementDetailDTOFromJson(json);
}

@freezed
class StatementAdditionalDetailDTO with _$StatementAdditionalDetailDTO {
  const factory StatementAdditionalDetailDTO({
    double? completed_total_earnings,
    double? total_cancellation_fee,
    double? total_bonus,
    double? total_withdraw,
  }) = _StatementAdditionalDetailDTO;

  factory StatementAdditionalDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$StatementAdditionalDetailDTOFromJson(json);
}
