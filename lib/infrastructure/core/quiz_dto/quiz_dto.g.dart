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
      total_correct_question: (json['total_correct_question'] as num?)?.toInt(),
      total_wrong_question: (json['total_wrong_question'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuizDTOImplToJson(_$QuizDTOImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'selectedAnswers': instance.selectedAnswers,
      'answer': instance.answer,
      'total_correct_question': instance.total_correct_question,
      'total_wrong_question': instance.total_wrong_question,
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

_$QuizAnswerDTOImpl _$$QuizAnswerDTOImplFromJson(Map<String, dynamic> json) =>
    _$QuizAnswerDTOImpl(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => QuizDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_correct_question: (json['total_correct_question'] as num?)?.toInt(),
      total_wrong_question: (json['total_wrong_question'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$QuizAnswerDTOImplToJson(_$QuizAnswerDTOImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total_correct_question': instance.total_correct_question,
      'total_wrong_question': instance.total_wrong_question,
    };
