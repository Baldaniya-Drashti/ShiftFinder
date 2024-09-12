// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchLocationDTOImpl _$$SearchLocationDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchLocationDTOImpl(
      predictions: (json['predictions'] as List<dynamic>?)
          ?.map((e) => Predictions.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$SearchLocationDTOImplToJson(
        _$SearchLocationDTOImpl instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
      'status': instance.status,
    };

_$PredictionsImpl _$$PredictionsImplFromJson(Map<String, dynamic> json) =>
    _$PredictionsImpl(
      description: json['description'] as String?,
      matched_substrings: (json['matched_substrings'] as List<dynamic>?)
          ?.map((e) => MatchedSubstrings.fromJson(e as Map<String, dynamic>))
          .toList(),
      place_id: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structured_formatting: json['structured_formatting'] == null
          ? null
          : StructuredFormatting.fromJson(
              json['structured_formatting'] as Map<String, dynamic>),
      terms: (json['terms'] as List<dynamic>?)
          ?.map((e) => Terms.fromJson(e as Map<String, dynamic>))
          .toList(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PredictionsImplToJson(_$PredictionsImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'matched_substrings': instance.matched_substrings,
      'place_id': instance.place_id,
      'reference': instance.reference,
      'structured_formatting': instance.structured_formatting,
      'terms': instance.terms,
      'types': instance.types,
    };

_$MatchedSubstringsImpl _$$MatchedSubstringsImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchedSubstringsImpl(
      length: (json['length'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MatchedSubstringsImplToJson(
        _$MatchedSubstringsImpl instance) =>
    <String, dynamic>{
      'length': instance.length,
      'offset': instance.offset,
    };

_$StructuredFormattingImpl _$$StructuredFormattingImplFromJson(
        Map<String, dynamic> json) =>
    _$StructuredFormattingImpl(
      main_text: json['main_text'] as String?,
      main_text_matched_substrings:
          (json['main_text_matched_substrings'] as List<dynamic>?)
              ?.map((e) =>
                  MainTextMatchedSubstrings.fromJson(e as Map<String, dynamic>))
              .toList(),
      secondary_text: json['secondary_text'] as String?,
    );

Map<String, dynamic> _$$StructuredFormattingImplToJson(
        _$StructuredFormattingImpl instance) =>
    <String, dynamic>{
      'main_text': instance.main_text,
      'main_text_matched_substrings': instance.main_text_matched_substrings,
      'secondary_text': instance.secondary_text,
    };

_$MainTextMatchedSubstringsImpl _$$MainTextMatchedSubstringsImplFromJson(
        Map<String, dynamic> json) =>
    _$MainTextMatchedSubstringsImpl(
      length: (json['length'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MainTextMatchedSubstringsImplToJson(
        _$MainTextMatchedSubstringsImpl instance) =>
    <String, dynamic>{
      'length': instance.length,
      'offset': instance.offset,
    };

_$TermsImpl _$$TermsImplFromJson(Map<String, dynamic> json) => _$TermsImpl(
      offset: (json['offset'] as num?)?.toInt(),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$TermsImplToJson(_$TermsImpl instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'value': instance.value,
    };
