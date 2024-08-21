// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'payable_dto.freezed.dart';
part 'payable_dto.g.dart';

@freezed
class PayableDTO with _$PayableDTO {
  const factory PayableDTO({
    String? total_payable_hour,
    String? rate_hour,
    String? total_wage,
    String? commute_allowance,
    String? accommodation_allowance,
    String? total_allowance,
    String? service_fee,
    String? total_one_shift,
    int? number_of_vacancie,
    String? total_amount_payable,
    String? total_one_allowance,
    int? number_of_shift,
    String? service_one_fee,
    String? third_party_fee,
    String? third_party_tax_fee,
    String? total_amount_payable_contractor,
  }) = _PayableDTO;

  factory PayableDTO.fromJson(Map<String, dynamic> json) =>
      _$PayableDTOFromJson(json);
}
