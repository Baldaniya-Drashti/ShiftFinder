// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExperienceDTO _$ExperienceDTOFromJson(Map<String, dynamic> json) {
  return _ExperienceDTO.fromJson(json);
}

/// @nodoc
mixin _$ExperienceDTO {
  String? get name => throw _privateConstructorUsedError;
  String? get year => throw _privateConstructorUsedError;
  String? get month => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExperienceDTOCopyWith<ExperienceDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperienceDTOCopyWith<$Res> {
  factory $ExperienceDTOCopyWith(
          ExperienceDTO value, $Res Function(ExperienceDTO) then) =
      _$ExperienceDTOCopyWithImpl<$Res, ExperienceDTO>;
  @useResult
  $Res call({String? name, String? year, String? month});
}

/// @nodoc
class _$ExperienceDTOCopyWithImpl<$Res, $Val extends ExperienceDTO>
    implements $ExperienceDTOCopyWith<$Res> {
  _$ExperienceDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? year = freezed,
    Object? month = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExperienceDTOImplCopyWith<$Res>
    implements $ExperienceDTOCopyWith<$Res> {
  factory _$$ExperienceDTOImplCopyWith(
          _$ExperienceDTOImpl value, $Res Function(_$ExperienceDTOImpl) then) =
      __$$ExperienceDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? year, String? month});
}

/// @nodoc
class __$$ExperienceDTOImplCopyWithImpl<$Res>
    extends _$ExperienceDTOCopyWithImpl<$Res, _$ExperienceDTOImpl>
    implements _$$ExperienceDTOImplCopyWith<$Res> {
  __$$ExperienceDTOImplCopyWithImpl(
      _$ExperienceDTOImpl _value, $Res Function(_$ExperienceDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? year = freezed,
    Object? month = freezed,
  }) {
    return _then(_$ExperienceDTOImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceDTOImpl implements _ExperienceDTO {
  _$ExperienceDTOImpl({this.name, this.year, this.month});

  factory _$ExperienceDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceDTOImplFromJson(json);

  @override
  final String? name;
  @override
  final String? year;
  @override
  final String? month;

  @override
  String toString() {
    return 'ExperienceDTO(name: $name, year: $year, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceDTOImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.month, month) || other.month == month));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, year, month);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperienceDTOImplCopyWith<_$ExperienceDTOImpl> get copyWith =>
      __$$ExperienceDTOImplCopyWithImpl<_$ExperienceDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperienceDTOImplToJson(
      this,
    );
  }
}

abstract class _ExperienceDTO implements ExperienceDTO {
  factory _ExperienceDTO(
      {final String? name,
      final String? year,
      final String? month}) = _$ExperienceDTOImpl;

  factory _ExperienceDTO.fromJson(Map<String, dynamic> json) =
      _$ExperienceDTOImpl.fromJson;

  @override
  String? get name;
  @override
  String? get year;
  @override
  String? get month;
  @override
  @JsonKey(ignore: true)
  _$$ExperienceDTOImplCopyWith<_$ExperienceDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
