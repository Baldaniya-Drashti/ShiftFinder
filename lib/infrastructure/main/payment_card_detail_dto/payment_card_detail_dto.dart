// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_card_detail_dto.freezed.dart';
part 'payment_card_detail_dto.g.dart';

@freezed
class PaymentCardDTO with _$PaymentCardDTO {
  const factory PaymentCardDTO({
    int? id,
    String? number,
    int? exp_month,
    int? exp_year,
    String? user_name,
    String? brand,
    int? is_default,
    String? icon,
  }) = _PaymentCardDTO;

  factory PaymentCardDTO.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardDTOFromJson(json);
}
