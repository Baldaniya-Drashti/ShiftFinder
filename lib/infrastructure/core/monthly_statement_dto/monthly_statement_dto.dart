import 'package:freezed_annotation/freezed_annotation.dart';
part 'monthly_statement_dto.freezed.dart';
part 'monthly_statement_dto.g.dart';

@freezed
class MonthlyStatementDTO with _$MonthlyStatementDTO {
  const factory MonthlyStatementDTO({
    List<MonthlyStatementDetailDTO>? list,
    String? company_name,
    int? industry_id,
    String? total_wage,
    String? total_service_fee,
    String? total_cancellation_fee,
    String? listing_id,
    String? net_amount,
  }) = _MonthlyStatementDTO;

  factory MonthlyStatementDTO.fromJson(Map<String, dynamic> json) =>
      _$MonthlyStatementDTOFromJson(json);
}

@freezed
class MonthlyStatementDetailDTO with _$MonthlyStatementDetailDTO {
  const factory MonthlyStatementDetailDTO({
    int? id,
    int? date_of_transaction,
    String? contractor_first_name,
    String? contractor_last_name,
    String? shiftfinder_service_fee,
    int? type,
    String? total_wage,
  }) = _MonthlyStatementDetailDTO;

  factory MonthlyStatementDetailDTO.fromJson(Map<String, dynamic> json) =>
      _$MonthlyStatementDetailDTOFromJson(json);
}
