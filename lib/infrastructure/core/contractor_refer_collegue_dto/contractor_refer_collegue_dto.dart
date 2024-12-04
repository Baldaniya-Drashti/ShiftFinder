import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'contractor_refer_collegue_dto.freezed.dart';
part 'contractor_refer_collegue_dto.g.dart';

@freezed
class ReferColleagueDTO with _$ReferColleagueDTO {
  const factory ReferColleagueDTO({
    int? id,
    int? user_id,
    String? first_name,
    String? last_name,
    String? email,
    String? profile,
  }) = _ReferColleagueDTO;

  factory ReferColleagueDTO.fromJson(Map<String, dynamic> json) =>
      _$ReferColleagueDTOFromJson(json);
}
