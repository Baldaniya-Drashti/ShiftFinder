// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_rating_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorRatingDTOImpl _$$ContractorRatingDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$ContractorRatingDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: (json['user_id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      profile: json['profile'] as String?,
      company_name: json['company_name'] as String?,
      post_rating: (json['post_rating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ContractorRatingDTOImplToJson(
        _$ContractorRatingDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'profile': instance.profile,
      'company_name': instance.company_name,
      'post_rating': instance.post_rating,
    };
