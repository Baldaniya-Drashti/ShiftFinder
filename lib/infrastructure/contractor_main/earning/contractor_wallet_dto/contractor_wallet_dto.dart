// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'contractor_wallet_dto.freezed.dart';
part 'contractor_wallet_dto.g.dart';

@freezed
class ContractorWalletDTO with _$ContractorWalletDTO {
  const factory ContractorWalletDTO({
    int? id,
    double? amount,
    int? type,
    String? company_name,
    String? filter_name,
    int? created,
  }) = _ContractorWalletDTO;

  factory ContractorWalletDTO.fromJson(Map<String, dynamic> json) =>
      _$ContractorWalletDTOFromJson(json);
}
