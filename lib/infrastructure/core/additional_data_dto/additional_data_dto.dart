import 'package:freezed_annotation/freezed_annotation.dart';
part 'additional_data_dto.freezed.dart';
part 'additional_data_dto.g.dart';

@freezed
class AdditionalDataDto with _$AdditionalDataDto {
  const factory AdditionalDataDto({
    int? id,
    String? name,
    bool? is_card_added,
    String? profile,
    String? role_lists_name,
    int? industry,
    String? listing_id,
    String? last_ago,
    String? role_list_name,
    String? location,
    int? start_date,
    int? start_time,
    int? end_time,
    int? complete_shift,
    int? total_shift,
    bool? status,
    String? service_roles,
  }) = _AdditionalDataDto;

  factory AdditionalDataDto.fromJson(Map<String, dynamic> json) =>
      _$AdditionalDataDtoFromJson(json);
}
