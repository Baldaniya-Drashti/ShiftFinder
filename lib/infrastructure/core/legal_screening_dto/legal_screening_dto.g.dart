// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_screening_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LegalScreeningDTOImpl _$$LegalScreeningDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$LegalScreeningDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isNa: (json['isNa'] as num?)?.toInt(),
      answer: (json['answer'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LegalScreeningDTOImplToJson(
        _$LegalScreeningDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isNa': instance.isNa,
      'answer': instance.answer,
    };

_$LegalScreeningAnswerDTOImpl _$$LegalScreeningAnswerDTOImplFromJson(
        Map<String, dynamic> json) =>
    _$LegalScreeningAnswerDTOImpl(
      user_id: (json['user_id'] as num?)?.toInt(),
      answer: (json['answer'] as num?)?.toInt(),
      question_list_id: (json['question_list_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LegalScreeningAnswerDTOImplToJson(
        _$LegalScreeningAnswerDTOImpl instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'answer': instance.answer,
      'question_list_id': instance.question_list_id,
    };
