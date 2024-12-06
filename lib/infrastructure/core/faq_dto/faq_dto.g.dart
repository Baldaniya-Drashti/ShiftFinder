// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaqDTOImpl _$$FaqDTOImplFromJson(Map<String, dynamic> json) => _$FaqDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$$FaqDTOImplToJson(_$FaqDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
    };
