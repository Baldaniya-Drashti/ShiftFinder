import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
part 'notification_dto.freezed.dart';
part 'notification_dto.g.dart';

@freezed
class NotificationDTO with _$NotificationDTO {
  const factory NotificationDTO({
    int? notification_id,
    int? post_id,
    SenderDTO? sender,
    String? roles_list_name,
    String? distance,
    String? message,
    String? title,
    String? last_ago,
    String? company_name,
    int? type,
  }) = _NotificationDTO;

  factory NotificationDTO.fromJson(Map<String, dynamic> json) =>
      _$NotificationDTOFromJson(json);
}

@freezed
class SenderDTO with _$SenderDTO {
  const factory SenderDTO({
    int? id,
    String? first_name,
    String? last_name,
    String? profile,
  }) = _SenderDTO;

  factory SenderDTO.fromJson(Map<String, dynamic> json) =>
      _$SenderDTOFromJson(json);
}
