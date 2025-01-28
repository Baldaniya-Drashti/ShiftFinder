// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'get_balance_dto.freezed.dart';
part 'get_balance_dto.g.dart';

@freezed
class GetBalanceDTO with _$GetBalanceDTO {
  const factory GetBalanceDTO({
    double? available_balance,
    double? pending_balance,
    String? currency,
    double? total_balance,
    double? available_withdrawable_balance,
  }) = _GetBalanceDTO;

  factory GetBalanceDTO.fromJson(Map<String, dynamic> json) =>
      _$GetBalanceDTOFromJson(json);
}
