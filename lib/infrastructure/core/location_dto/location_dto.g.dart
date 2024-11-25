// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationDTOImpl _$$LocationDTOImplFromJson(Map<String, dynamic> json) =>
    _$LocationDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      location: json['location'] as String?,
      add_units: (json['add_units'] as List<dynamic>?)
          ?.map((e) => UnitDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      facility_type: json['facility_type'] == null
          ? null
          : FacilityTypeDto.fromJson(
              json['facility_type'] as Map<String, dynamic>),
      accreditation_number: json['accreditation_number'] as String?,
      location_note: json['location_note'] as String?,
      location_id: json['location_id'] as String?,
    );

Map<String, dynamic> _$$LocationDTOImplToJson(_$LocationDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'add_units': instance.add_units,
      'facility_type': instance.facility_type,
      'accreditation_number': instance.accreditation_number,
      'location_note': instance.location_note,
      'location_id': instance.location_id,
    };

_$UnitDTOImpl _$$UnitDTOImplFromJson(Map<String, dynamic> json) =>
    _$UnitDTOImpl(
      number_or_name: json['number_or_name'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$UnitDTOImplToJson(_$UnitDTOImpl instance) =>
    <String, dynamic>{
      'number_or_name': instance.number_or_name,
      'note': instance.note,
    };

_$FacilityTypeDtoImpl _$$FacilityTypeDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$FacilityTypeDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$FacilityTypeDtoImplToJson(
        _$FacilityTypeDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
