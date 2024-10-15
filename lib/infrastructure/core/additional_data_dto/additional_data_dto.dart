import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';

part 'additional_data_dto.freezed.dart';

part 'additional_data_dto.g.dart';

@freezed
class AdditionalDataDto with _$AdditionalDataDto {
  const factory AdditionalDataDto({
    int? id,
    bool? is_card_added,
    String? profile,
    String? role_lists_name,
    int? industry,
    String? listing_id,
    String? last_ago,
    LocationDTO? location,
    int? start_date,
    int? start_time,
    int? end_time,
  }) = _AdditionalDataDto;

  factory AdditionalDataDto.fromJson(Map<String, dynamic> json) => _$AdditionalDataDtoFromJson(json);
}
