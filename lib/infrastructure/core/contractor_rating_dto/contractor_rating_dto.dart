// ignore_for_file: non_constant_identifier_names

  import 'package:freezed_annotation/freezed_annotation.dart';
  part 'contractor_rating_dto.freezed.dart';
  part 'contractor_rating_dto.g.dart';

  @freezed
  class ContractorRatingDTO with _$ContractorRatingDTO {
    const factory ContractorRatingDTO({
      int? id,
      int? user_id,
      String? first_name,
      String? last_name,
      String? profile,
      String? company_name,
      int? post_rating,
    }) = _ContractorRatingDTO;

    factory ContractorRatingDTO.fromJson(Map<String, dynamic> json) =>
        _$ContractorRatingDTOFromJson(json);
  }
