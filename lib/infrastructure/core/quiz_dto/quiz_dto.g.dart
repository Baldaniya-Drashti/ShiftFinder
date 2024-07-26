// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizDTOImpl _$$QuizDTOImplFromJson(Map<String, dynamic> json) =>
    _$QuizDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => QuizMcqDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedAnswers: (json['selectedAnswers'] as List<dynamic>?)
          ?.map((e) => QuizMcqDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      answer: (json['answer'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuizDTOImplToJson(_$QuizDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'selectedAnswers': instance.selectedAnswers,
      'answer': instance.answer,
    };

_$QuizMcqDTOImpl _$$QuizMcqDTOImplFromJson(Map<String, dynamic> json) =>
    _$QuizMcqDTOImpl(
      id: (json['id'] as num?)?.toInt(),
      answer: json['answer'] as String?,
      correct_answer: json['correct_answer'] as bool?,
    );

Map<String, dynamic> _$$QuizMcqDTOImplToJson(_$QuizMcqDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
      'correct_answer': instance.correct_answer,
    };
