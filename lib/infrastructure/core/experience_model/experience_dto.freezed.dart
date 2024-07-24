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
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get experience_year => throw _privateConstructorUsedError;
  String? get experience_month => throw _privateConstructorUsedError;

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
  $Res call(
      {int? id,
      String? name,
      String? experience_year,
      String? experience_month});
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
    Object? id = freezed,
    Object? name = freezed,
    Object? experience_year = freezed,
    Object? experience_month = freezed,
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
      experience_year: freezed == experience_year
          ? _value.experience_year
          : experience_year // ignore: cast_nullable_to_non_nullable
              as String?,
      experience_month: freezed == experience_month
          ? _value.experience_month
          : experience_month // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {int? id,
      String? name,
      String? experience_year,
      String? experience_month});
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
    Object? id = freezed,
    Object? name = freezed,
    Object? experience_year = freezed,
    Object? experience_month = freezed,
  }) {
    return _then(_$ExperienceDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      experience_year: freezed == experience_year
          ? _value.experience_year
          : experience_year // ignore: cast_nullable_to_non_nullable
              as String?,
      experience_month: freezed == experience_month
          ? _value.experience_month
          : experience_month // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperienceDTOImpl implements _ExperienceDTO {
  _$ExperienceDTOImpl(
      {this.id, this.name, this.experience_year, this.experience_month});

  factory _$ExperienceDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperienceDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? experience_year;
  @override
  final String? experience_month;

  @override
  String toString() {
    return 'ExperienceDTO(id: $id, name: $name, experience_year: $experience_year, experience_month: $experience_month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperienceDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.experience_year, experience_year) ||
                other.experience_year == experience_year) &&
            (identical(other.experience_month, experience_month) ||
                other.experience_month == experience_month));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, experience_year, experience_month);

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
      {final int? id,
      final String? name,
      final String? experience_year,
      final String? experience_month}) = _$ExperienceDTOImpl;

  factory _ExperienceDTO.fromJson(Map<String, dynamic> json) =
      _$ExperienceDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get experience_year;
  @override
  String? get experience_month;
  @override
  @JsonKey(ignore: true)
  _$$ExperienceDTOImplCopyWith<_$ExperienceDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
