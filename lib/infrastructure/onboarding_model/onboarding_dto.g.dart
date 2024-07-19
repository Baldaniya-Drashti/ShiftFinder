// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnBoardingDTOImpl _$$OnBoardingDTOImplFromJson(Map<String, dynamic> json) =>
    _$OnBoardingDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      backgroundImage: json['backgroundImage'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$OnBoardingDTOImplToJson(_$OnBoardingDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'backgroundImage': instance.backgroundImage,
      'description': instance.description,
    };
