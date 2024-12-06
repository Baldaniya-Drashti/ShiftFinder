import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'payment_history_dto.freezed.dart';
part 'payment_history_dto.g.dart';

@freezed
class PaymentHistoryDTO with _$PaymentHistoryDTO {
  const factory PaymentHistoryDTO({
    int? id,
    int? post_id,
    String? listing_id,
    String? roles_list_name,
    int? industry,
    String? shift_type,
    int? end_date,
    int? date,
    LocationDTO? location,
    String? first_name,
    String? last_name,
    String? profile,
    String? total_amount_payble,
    String? total_wage,
    String? total_allowance,
  }) = _PaymentHistoryDTO;

  factory PaymentHistoryDTO.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryDTOFromJson(json);
}
