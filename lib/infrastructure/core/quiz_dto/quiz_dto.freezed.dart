// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QuizDTO _$QuizDTOFromJson(Map<String, dynamic> json) {
  return _QuizDTO.fromJson(json);
}

/// @nodoc
mixin _$QuizDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get question => throw _privateConstructorUsedError;
  List<QuizMcqDTO>? get answers => throw _privateConstructorUsedError;
  List<QuizMcqDTO>? get selectedAnswers => throw _privateConstructorUsedError;
  int? get answer => throw _privateConstructorUsedError;
  int? get total_correct_question => throw _privateConstructorUsedError;
  int? get total_wrong_question => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuizDTOCopyWith<QuizDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizDTOCopyWith<$Res> {
  factory $QuizDTOCopyWith(QuizDTO value, $Res Function(QuizDTO) then) =
      _$QuizDTOCopyWithImpl<$Res, QuizDTO>;
  @useResult
  $Res call(
      {int? id,
      String? question,
      List<QuizMcqDTO>? answers,
      List<QuizMcqDTO>? selectedAnswers,
      int? answer,
      int? total_correct_question,
      int? total_wrong_question});
}

/// @nodoc
class _$QuizDTOCopyWithImpl<$Res, $Val extends QuizDTO>
    implements $QuizDTOCopyWith<$Res> {
  _$QuizDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = freezed,
    Object? answers = freezed,
    Object? selectedAnswers = freezed,
    Object? answer = freezed,
    Object? total_correct_question = freezed,
    Object? total_wrong_question = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      answers: freezed == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuizMcqDTO>?,
      selectedAnswers: freezed == selectedAnswers
          ? _value.selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as List<QuizMcqDTO>?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
      total_correct_question: freezed == total_correct_question
          ? _value.total_correct_question
          : total_correct_question // ignore: cast_nullable_to_non_nullable
              as int?,
      total_wrong_question: freezed == total_wrong_question
          ? _value.total_wrong_question
          : total_wrong_question // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizDTOImplCopyWith<$Res> implements $QuizDTOCopyWith<$Res> {
  factory _$$QuizDTOImplCopyWith(
          _$QuizDTOImpl value, $Res Function(_$QuizDTOImpl) then) =
      __$$QuizDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? question,
      List<QuizMcqDTO>? answers,
      List<QuizMcqDTO>? selectedAnswers,
      int? answer,
      int? total_correct_question,
      int? total_wrong_question});
}

/// @nodoc
class __$$QuizDTOImplCopyWithImpl<$Res>
    extends _$QuizDTOCopyWithImpl<$Res, _$QuizDTOImpl>
    implements _$$QuizDTOImplCopyWith<$Res> {
  __$$QuizDTOImplCopyWithImpl(
      _$QuizDTOImpl _value, $Res Function(_$QuizDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? question = freezed,
    Object? answers = freezed,
    Object? selectedAnswers = freezed,
    Object? answer = freezed,
    Object? total_correct_question = freezed,
    Object? total_wrong_question = freezed,
  }) {
    return _then(_$QuizDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      question: freezed == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String?,
      answers: freezed == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<QuizMcqDTO>?,
      selectedAnswers: freezed == selectedAnswers
          ? _value._selectedAnswers
          : selectedAnswers // ignore: cast_nullable_to_non_nullable
              as List<QuizMcqDTO>?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
      total_correct_question: freezed == total_correct_question
          ? _value.total_correct_question
          : total_correct_question // ignore: cast_nullable_to_non_nullable
              as int?,
      total_wrong_question: freezed == total_wrong_question
          ? _value.total_wrong_question
          : total_wrong_question // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizDTOImpl implements _QuizDTO {
  const _$QuizDTOImpl(
      {this.id,
      this.question,
      final List<QuizMcqDTO>? answers,
      final List<QuizMcqDTO>? selectedAnswers,
      this.answer,
      this.total_correct_question,
      this.total_wrong_question})
      : _answers = answers,
        _selectedAnswers = selectedAnswers;

  factory _$QuizDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? question;
  final List<QuizMcqDTO>? _answers;
  @override
  List<QuizMcqDTO>? get answers {
    final value = _answers;
    if (value == null) return null;
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<QuizMcqDTO>? _selectedAnswers;
  @override
  List<QuizMcqDTO>? get selectedAnswers {
    final value = _selectedAnswers;
    if (value == null) return null;
    if (_selectedAnswers is EqualUnmodifiableListView) return _selectedAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? answer;
  @override
  final int? total_correct_question;
  @override
  final int? total_wrong_question;

  @override
  String toString() {
    return 'QuizDTO(id: $id, question: $question, answers: $answers, selectedAnswers: $selectedAnswers, answer: $answer, total_correct_question: $total_correct_question, total_wrong_question: $total_wrong_question)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality()
                .equals(other._selectedAnswers, _selectedAnswers) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.total_correct_question, total_correct_question) ||
                other.total_correct_question == total_correct_question) &&
            (identical(other.total_wrong_question, total_wrong_question) ||
                other.total_wrong_question == total_wrong_question));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      question,
      const DeepCollectionEquality().hash(_answers),
      const DeepCollectionEquality().hash(_selectedAnswers),
      answer,
      total_correct_question,
      total_wrong_question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizDTOImplCopyWith<_$QuizDTOImpl> get copyWith =>
      __$$QuizDTOImplCopyWithImpl<_$QuizDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizDTOImplToJson(
      this,
    );
  }
}

abstract class _QuizDTO implements QuizDTO {
  const factory _QuizDTO(
      {final int? id,
      final String? question,
      final List<QuizMcqDTO>? answers,
      final List<QuizMcqDTO>? selectedAnswers,
      final int? answer,
      final int? total_correct_question,
      final int? total_wrong_question}) = _$QuizDTOImpl;

  factory _QuizDTO.fromJson(Map<String, dynamic> json) = _$QuizDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get question;
  @override
  List<QuizMcqDTO>? get answers;
  @override
  List<QuizMcqDTO>? get selectedAnswers;
  @override
  int? get answer;
  @override
  int? get total_correct_question;
  @override
  int? get total_wrong_question;
  @override
  @JsonKey(ignore: true)
  _$$QuizDTOImplCopyWith<_$QuizDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizMcqDTO _$QuizMcqDTOFromJson(Map<String, dynamic> json) {
  return _QuizMcqDTO.fromJson(json);
}

/// @nodoc
mixin _$QuizMcqDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;
  bool? get correct_answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuizMcqDTOCopyWith<QuizMcqDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizMcqDTOCopyWith<$Res> {
  factory $QuizMcqDTOCopyWith(
          QuizMcqDTO value, $Res Function(QuizMcqDTO) then) =
      _$QuizMcqDTOCopyWithImpl<$Res, QuizMcqDTO>;
  @useResult
  $Res call({int? id, String? answer, bool? correct_answer});
}

/// @nodoc
class _$QuizMcqDTOCopyWithImpl<$Res, $Val extends QuizMcqDTO>
    implements $QuizMcqDTOCopyWith<$Res> {
  _$QuizMcqDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? answer = freezed,
    Object? correct_answer = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      correct_answer: freezed == correct_answer
          ? _value.correct_answer
          : correct_answer // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizMcqDTOImplCopyWith<$Res>
    implements $QuizMcqDTOCopyWith<$Res> {
  factory _$$QuizMcqDTOImplCopyWith(
          _$QuizMcqDTOImpl value, $Res Function(_$QuizMcqDTOImpl) then) =
      __$$QuizMcqDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? answer, bool? correct_answer});
}

/// @nodoc
class __$$QuizMcqDTOImplCopyWithImpl<$Res>
    extends _$QuizMcqDTOCopyWithImpl<$Res, _$QuizMcqDTOImpl>
    implements _$$QuizMcqDTOImplCopyWith<$Res> {
  __$$QuizMcqDTOImplCopyWithImpl(
      _$QuizMcqDTOImpl _value, $Res Function(_$QuizMcqDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? answer = freezed,
    Object? correct_answer = freezed,
  }) {
    return _then(_$QuizMcqDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      correct_answer: freezed == correct_answer
          ? _value.correct_answer
          : correct_answer // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizMcqDTOImpl implements _QuizMcqDTO {
  const _$QuizMcqDTOImpl({this.id, this.answer, this.correct_answer});

  factory _$QuizMcqDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizMcqDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? answer;
  @override
  final bool? correct_answer;

  @override
  String toString() {
    return 'QuizMcqDTO(id: $id, answer: $answer, correct_answer: $correct_answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizMcqDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correct_answer, correct_answer) ||
                other.correct_answer == correct_answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, answer, correct_answer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizMcqDTOImplCopyWith<_$QuizMcqDTOImpl> get copyWith =>
      __$$QuizMcqDTOImplCopyWithImpl<_$QuizMcqDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizMcqDTOImplToJson(
      this,
    );
  }
}

abstract class _QuizMcqDTO implements QuizMcqDTO {
  const factory _QuizMcqDTO(
      {final int? id,
      final String? answer,
      final bool? correct_answer}) = _$QuizMcqDTOImpl;

  factory _QuizMcqDTO.fromJson(Map<String, dynamic> json) =
      _$QuizMcqDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get answer;
  @override
  bool? get correct_answer;
  @override
  @JsonKey(ignore: true)
  _$$QuizMcqDTOImplCopyWith<_$QuizMcqDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuizAnswerDTO _$QuizAnswerDTOFromJson(Map<String, dynamic> json) {
  return _QuizAnswerDTO.fromJson(json);
}

/// @nodoc
mixin _$QuizAnswerDTO {
  List<QuizDTO>? get list => throw _privateConstructorUsedError;
  int? get total_correct_question => throw _privateConstructorUsedError;
  int? get total_wrong_question => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuizAnswerDTOCopyWith<QuizAnswerDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizAnswerDTOCopyWith<$Res> {
  factory $QuizAnswerDTOCopyWith(
          QuizAnswerDTO value, $Res Function(QuizAnswerDTO) then) =
      _$QuizAnswerDTOCopyWithImpl<$Res, QuizAnswerDTO>;
  @useResult
  $Res call(
      {List<QuizDTO>? list,
      int? total_correct_question,
      int? total_wrong_question});
}

/// @nodoc
class _$QuizAnswerDTOCopyWithImpl<$Res, $Val extends QuizAnswerDTO>
    implements $QuizAnswerDTOCopyWith<$Res> {
  _$QuizAnswerDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = freezed,
    Object? total_correct_question = freezed,
    Object? total_wrong_question = freezed,
  }) {
    return _then(_value.copyWith(
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<QuizDTO>?,
      total_correct_question: freezed == total_correct_question
          ? _value.total_correct_question
          : total_correct_question // ignore: cast_nullable_to_non_nullable
              as int?,
      total_wrong_question: freezed == total_wrong_question
          ? _value.total_wrong_question
          : total_wrong_question // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuizAnswerDTOImplCopyWith<$Res>
    implements $QuizAnswerDTOCopyWith<$Res> {
  factory _$$QuizAnswerDTOImplCopyWith(
          _$QuizAnswerDTOImpl value, $Res Function(_$QuizAnswerDTOImpl) then) =
      __$$QuizAnswerDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<QuizDTO>? list,
      int? total_correct_question,
      int? total_wrong_question});
}

/// @nodoc
class __$$QuizAnswerDTOImplCopyWithImpl<$Res>
    extends _$QuizAnswerDTOCopyWithImpl<$Res, _$QuizAnswerDTOImpl>
    implements _$$QuizAnswerDTOImplCopyWith<$Res> {
  __$$QuizAnswerDTOImplCopyWithImpl(
      _$QuizAnswerDTOImpl _value, $Res Function(_$QuizAnswerDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = freezed,
    Object? total_correct_question = freezed,
    Object? total_wrong_question = freezed,
  }) {
    return _then(_$QuizAnswerDTOImpl(
      list: freezed == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<QuizDTO>?,
      total_correct_question: freezed == total_correct_question
          ? _value.total_correct_question
          : total_correct_question // ignore: cast_nullable_to_non_nullable
              as int?,
      total_wrong_question: freezed == total_wrong_question
          ? _value.total_wrong_question
          : total_wrong_question // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizAnswerDTOImpl implements _QuizAnswerDTO {
  const _$QuizAnswerDTOImpl(
      {final List<QuizDTO>? list,
      this.total_correct_question,
      this.total_wrong_question})
      : _list = list;

  factory _$QuizAnswerDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizAnswerDTOImplFromJson(json);

  final List<QuizDTO>? _list;
  @override
  List<QuizDTO>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? total_correct_question;
  @override
  final int? total_wrong_question;

  @override
  String toString() {
    return 'QuizAnswerDTO(list: $list, total_correct_question: $total_correct_question, total_wrong_question: $total_wrong_question)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizAnswerDTOImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.total_correct_question, total_correct_question) ||
                other.total_correct_question == total_correct_question) &&
            (identical(other.total_wrong_question, total_wrong_question) ||
                other.total_wrong_question == total_wrong_question));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      total_correct_question,
      total_wrong_question);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizAnswerDTOImplCopyWith<_$QuizAnswerDTOImpl> get copyWith =>
      __$$QuizAnswerDTOImplCopyWithImpl<_$QuizAnswerDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizAnswerDTOImplToJson(
      this,
    );
  }
}

abstract class _QuizAnswerDTO implements QuizAnswerDTO {
  const factory _QuizAnswerDTO(
      {final List<QuizDTO>? list,
      final int? total_correct_question,
      final int? total_wrong_question}) = _$QuizAnswerDTOImpl;

  factory _QuizAnswerDTO.fromJson(Map<String, dynamic> json) =
      _$QuizAnswerDTOImpl.fromJson;

  @override
  List<QuizDTO>? get list;
  @override
  int? get total_correct_question;
  @override
  int? get total_wrong_question;
  @override
  @JsonKey(ignore: true)
  _$$QuizAnswerDTOImplCopyWith<_$QuizAnswerDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
