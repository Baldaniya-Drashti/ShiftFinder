// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
part 'quiz_dto.freezed.dart';
part 'quiz_dto.g.dart';

@freezed
class QuizDTO with _$QuizDTO {
  const factory QuizDTO({
    int? id,
    String? question,
    List<QuizMcqDTO>? answers,
    List<QuizMcqDTO>? selectedAnswers,
    int? answer,
  }) = _QuizDTO;

  factory QuizDTO.fromJson(Map<String, dynamic> json) =>
      _$QuizDTOFromJson(json);
}

@freezed
class QuizMcqDTO with _$QuizMcqDTO {
  const factory QuizMcqDTO({
    int? id,
    String? answer,
    bool? correct_answer,
  }) = _QuizMcqDTO;

  factory QuizMcqDTO.fromJson(Map<String, dynamic> json) =>
      _$QuizMcqDTOFromJson(json);
}
