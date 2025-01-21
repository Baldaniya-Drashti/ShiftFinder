import 'package:freezed_annotation/freezed_annotation.dart';
part 'bank_dto.freezed.dart';
part 'bank_dto.g.dart';

@freezed
class BankDTO with _$BankDTO {
  const factory BankDTO({
    String? account_number,
    String? full_account_number,
    String? transit_number,
    String? institution_number,
    String? account_type,
    String? role_lists_name,
    String? first_name,
    String? last_name,
    int? dob,
    String? bank_address,
    String? city,
    String? state,
    String? postal_code,
    String? country,
    String? country_code,
    int? status,
    String? bank_name,
    String? job_title,
    String? phone,
    String? country_flag,
  }) = _BankDTO;

  factory BankDTO.fromJson(Map<String, dynamic> json) =>
      _$BankDTOFromJson(json);
}
