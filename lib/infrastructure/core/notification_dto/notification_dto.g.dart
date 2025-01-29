// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationDTOImpl _$$NotificationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationDTOImpl(
      notification_id: (json['notification_id'] as num?)?.toInt(),
      post_id: (json['post_id'] as num?)?.toInt(),
      sender: json['sender'] == null
          ? null
          : SenderDTO.fromJson(json['sender'] as Map<String, dynamic>),
      roles_list_name: json['roles_list_name'] as String?,
      distance: json['distance'] as String?,
      message: json['message'] as String?,
      title: json['title'] as String?,
      last_ago: json['last_ago'] as String?,
      company_name: json['company_name'] as String?,
      type: (json['type'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NotificationDTOImplToJson(
        _$NotificationDTOImpl instance) =>
    <String, dynamic>{
      'notification_id': instance.notification_id,
      'post_id': instance.post_id,
      'sender': instance.sender,
      'roles_list_name': instance.roles_list_name,
      'distance': instance.distance,
      'message': instance.message,
      'title': instance.title,
      'last_ago': instance.last_ago,
      'company_name': instance.company_name,
      'type': instance.type,
    };

_$SenderDTOImpl _$$SenderDTOImplFromJson(Map<String, dynamic> json) =>
    _$SenderDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$$SenderDTOImplToJson(_$SenderDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
    };
