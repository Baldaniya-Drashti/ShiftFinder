// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_refer_collegue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReferColleagueDTOImpl _$$ReferColleagueDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ReferColleagueDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$$ReferColleagueDTOImplToJson(
        _$ReferColleagueDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'profile': instance.profile,
    };
