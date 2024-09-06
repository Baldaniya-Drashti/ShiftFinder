// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchLocationDTOImpl _$$SearchLocationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchLocationDTOImpl(
      html_attributions: json['html_attributions'] as List<dynamic>?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Results.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$SearchLocationDTOImplToJson(
        _$SearchLocationDTOImpl instance) =>
    <String, dynamic>{
      'html_attributions': instance.html_attributions,
      'results': instance.results,
      'status': instance.status,
    };

_$ResultsImpl _$$ResultsImplFromJson(Map<String, dynamic> json) =>
    _$ResultsImpl(
      formatted_address: json['formatted_address'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      icon: json['icon'] as String?,
      icon_background_color: json['icon_background_color'] as String?,
      icon_mask_base_uri: json['icon_mask_base_uri'] as String?,
      name: json['name'] as String?,
      place_id: json['place_id'] as String?,
      plus_code: json['plus_code'] == null
          ? null
          : PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>),
      reference: json['reference'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ResultsImplToJson(_$ResultsImpl instance) =>
    <String, dynamic>{
      'formatted_address': instance.formatted_address,
      'geometry': instance.geometry,
      'icon': instance.icon,
      'icon_background_color': instance.icon_background_color,
      'icon_mask_base_uri': instance.icon_mask_base_uri,
      'name': instance.name,
      'place_id': instance.place_id,
      'plus_code': instance.plus_code,
      'reference': instance.reference,
      'types': instance.types,
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
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
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

_$PlusCodeImpl _$$PlusCodeImplFromJson(Map<String, dynamic> json) =>
    _$PlusCodeImpl(
      compound_code: json['compound_code'] as String?,
      global_code: json['global_code'] as String?,
    );

Map<String, dynamic> _$$PlusCodeImplToJson(_$PlusCodeImpl instance) =>
    <String, dynamic>{
      'compound_code': instance.compound_code,
      'global_code': instance.global_code,
    };
