// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reference_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReferenceDTOImpl _$$ReferenceDTOImplFromJson(Map<String, dynamic> json) =>
    _$ReferenceDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      job_position: json['job_position'] as String?,
      email: json['email'] as String?,
      country_code: json['country_code'] as String?,
      country_name_code: json['country_name_code'] as String?,
      phone: (json['phone'] as num?)?.toInt(),
      organization: json['organization'] as String?,
      referrer: json['referrer'] as String?,
      job_latitude: json['job_latitude'] as String?,
      job_longitude: json['job_longitude'] as String?,
      job_location: json['job_location'] as String?,
      unit: json['unit'] as String?,
      start_date: (json['start_date'] as num?)?.toInt(),
      end_date: (json['end_date'] as num?)?.toInt(),
      contact_person: json['contact_person'] as String?,
      profession_referrer: json['profession_referrer'] as String?,
    );

Map<String, dynamic> _$$ReferenceDTOImplToJson(_$ReferenceDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'job_position': instance.job_position,
      'email': instance.email,
      'country_code': instance.country_code,
      'country_name_code': instance.country_name_code,
      'phone': instance.phone,
      'organization': instance.organization,
      'referrer': instance.referrer,
      'job_latitude': instance.job_latitude,
      'job_longitude': instance.job_longitude,
      'job_location': instance.job_location,
      'unit': instance.unit,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'contact_person': instance.contact_person,
      'profession_referrer': instance.profession_referrer,
    };
