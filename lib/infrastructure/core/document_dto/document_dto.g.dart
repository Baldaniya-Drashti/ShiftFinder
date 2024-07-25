// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentDTOImpl _$$DocumentDTOImplFromJson(Map<String, dynamic> json) =>
    _$DocumentDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      document_type: (json['document_type'] as num?)?.toInt(),
      file: json['file'] as String?,
      expiry_date: (json['expiry_date'] as num?)?.toInt(),
      registration_number: json['registration_number'] as String?,
      province_of_registration: json['province_of_registration'] as String?,
      document_title: json['document_title'] as String?,
      name_of_vaccinations: json['name_of_vaccinations'] as String?,
      expiry_date_not_applicable:
          (json['expiry_date_not_applicable'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DocumentDTOImplToJson(_$DocumentDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_type': instance.document_type,
      'file': instance.file,
      'expiry_date': instance.expiry_date,
      'registration_number': instance.registration_number,
      'province_of_registration': instance.province_of_registration,
      'document_title': instance.document_title,
      'name_of_vaccinations': instance.name_of_vaccinations,
      'expiry_date_not_applicable': instance.expiry_date_not_applicable,
    };
