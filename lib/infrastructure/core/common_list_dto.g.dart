// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListDTOImpl _$$ListDTOImplFromJson(Map<String, dynamic> json) =>
    _$ListDTOImpl(
      title: json['title'] as String?,
      id: (json['id'] as num?)?.toInt(),
      isSelected: (json['isSelected'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ListDTOImplToJson(_$ListDTOImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'isSelected': instance.isSelected,
    };
