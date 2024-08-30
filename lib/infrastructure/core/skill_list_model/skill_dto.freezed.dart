// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SkillDTO _$SkillDTOFromJson(Map<String, dynamic> json) {
  return _SkillDTO.fromJson(json);
}

/// @nodoc
mixin _$SkillDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get shortName => throw _privateConstructorUsedError;
  int? get answer => throw _privateConstructorUsedError;
  int? get minute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkillDTOCopyWith<SkillDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillDTOCopyWith<$Res> {
  factory $SkillDTOCopyWith(SkillDTO value, $Res Function(SkillDTO) then) =
      _$SkillDTOCopyWithImpl<$Res, SkillDTO>;
  @useResult
  $Res call(
      {int? id, String? name, String? shortName, int? answer, int? minute});
}

/// @nodoc
class _$SkillDTOCopyWithImpl<$Res, $Val extends SkillDTO>
    implements $SkillDTOCopyWith<$Res> {
  _$SkillDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? shortName = freezed,
    Object? answer = freezed,
    Object? minute = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
      minute: freezed == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SkillDTOImplCopyWith<$Res>
    implements $SkillDTOCopyWith<$Res> {
  factory _$$SkillDTOImplCopyWith(
          _$SkillDTOImpl value, $Res Function(_$SkillDTOImpl) then) =
      __$$SkillDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? name, String? shortName, int? answer, int? minute});
}

/// @nodoc
class __$$SkillDTOImplCopyWithImpl<$Res>
    extends _$SkillDTOCopyWithImpl<$Res, _$SkillDTOImpl>
    implements _$$SkillDTOImplCopyWith<$Res> {
  __$$SkillDTOImplCopyWithImpl(
      _$SkillDTOImpl _value, $Res Function(_$SkillDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? shortName = freezed,
    Object? answer = freezed,
    Object? minute = freezed,
  }) {
    return _then(_$SkillDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
      minute: freezed == minute
          ? _value.minute
          : minute // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SkillDTOImpl implements _SkillDTO {
  const _$SkillDTOImpl(
      {this.id, this.name, this.shortName, this.answer, this.minute});

  factory _$SkillDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$SkillDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? shortName;
  @override
  final int? answer;
  @override
  final int? minute;

  @override
  String toString() {
    return 'SkillDTO(id: $id, name: $name, shortName: $shortName, answer: $answer, minute: $minute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SkillDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.minute, minute) || other.minute == minute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, shortName, answer, minute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SkillDTOImplCopyWith<_$SkillDTOImpl> get copyWith =>
      __$$SkillDTOImplCopyWithImpl<_$SkillDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SkillDTOImplToJson(
      this,
    );
  }
}

abstract class _SkillDTO implements SkillDTO {
  const factory _SkillDTO(
      {final int? id,
      final String? name,
      final String? shortName,
      final int? answer,
      final int? minute}) = _$SkillDTOImpl;

  factory _SkillDTO.fromJson(Map<String, dynamic> json) =
      _$SkillDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get shortName;
  @override
  int? get answer;
  @override
  int? get minute;
  @override
  @JsonKey(ignore: true)
  _$$SkillDTOImplCopyWith<_$SkillDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
