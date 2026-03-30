// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlaceDetailDTOImpl _$$PlaceDetailDTOImplFromJson(Map<String, dynamic> json) =>
    _$PlaceDetailDTOImpl(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$PlaceDetailDTOImplToJson(
        _$PlaceDetailDTOImpl instance) =>
    <String, dynamic>{
      'result': instance.result,
      'status': instance.status,
    };

_$ResultImpl _$$ResultImplFromJson(Map<String, dynamic> json) => _$ResultImpl(
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ResultImplToJson(_$ResultImpl instance) =>
    <String, dynamic>{
      'geometry': instance.geometry,
    };

_$GeometryImpl _$$GeometryImplFromJson(Map<String, dynamic> json) =>
    _$GeometryImpl(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      viewport: json['viewport'] == null
          ? null
          : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GeometryImplToJson(_$GeometryImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'viewport': instance.viewport,
    };

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
    };

_$ViewportImpl _$$ViewportImplFromJson(Map<String, dynamic> json) =>
    _$ViewportImpl(
      northeast: json['northeast'] == null
          ? null
          : Northeast.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: json['southwest'] == null
          ? null
          : Southwest.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ViewportImplToJson(_$ViewportImpl instance) =>
    <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

_$NortheastImpl _$$NortheastImplFromJson(Map<String, dynamic> json) =>
    _$NortheastImpl(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$NortheastImplToJson(_$NortheastImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

_$SouthwestImpl _$$SouthwestImplFromJson(Map<String, dynamic> json) =>
    _$SouthwestImpl(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$SouthwestImplToJson(_$SouthwestImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
