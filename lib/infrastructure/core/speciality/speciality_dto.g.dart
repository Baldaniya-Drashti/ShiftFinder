// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpecialityDTOImpl _$$SpecialityDTOImplFromJson(Map<String, dynamic> json) =>
    _$SpecialityDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      shortName: json['shortName'] as String?,
      experienceId: (json['experienceId'] as num?)?.toInt(),
      specialityExperience: json['specialityExperience'] as String?,
      specialityOther: json['specialityOther'] as String?,
    );

Map<String, dynamic> _$$SpecialityDTOImplToJson(_$SpecialityDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'experienceId': instance.experienceId,
      'specialityExperience': instance.specialityExperience,
      'specialityOther': instance.specialityOther,
    };
