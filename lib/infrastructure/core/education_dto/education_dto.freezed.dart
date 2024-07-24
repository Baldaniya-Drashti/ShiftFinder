// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EducationDTO _$EducationDTOFromJson(Map<String, dynamic> json) {
  return _EducationDTO.fromJson(json);
}

/// @nodoc
mixin _$EducationDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get program_completed => throw _privateConstructorUsedError;
  String? get year_of_completion => throw _privateConstructorUsedError;
  String? get graduating_institution => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EducationDTOCopyWith<EducationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationDTOCopyWith<$Res> {
  factory $EducationDTOCopyWith(
          EducationDTO value, $Res Function(EducationDTO) then) =
      _$EducationDTOCopyWithImpl<$Res, EducationDTO>;
  @useResult
  $Res call(
      {int? id,
      String? program_completed,
      String? year_of_completion,
      String? graduating_institution});
}

/// @nodoc
class _$EducationDTOCopyWithImpl<$Res, $Val extends EducationDTO>
    implements $EducationDTOCopyWith<$Res> {
  _$EducationDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? program_completed = freezed,
    Object? year_of_completion = freezed,
    Object? graduating_institution = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      program_completed: freezed == program_completed
          ? _value.program_completed
          : program_completed // ignore: cast_nullable_to_non_nullable
              as String?,
      year_of_completion: freezed == year_of_completion
          ? _value.year_of_completion
          : year_of_completion // ignore: cast_nullable_to_non_nullable
              as String?,
      graduating_institution: freezed == graduating_institution
          ? _value.graduating_institution
          : graduating_institution // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EducationDTOImplCopyWith<$Res>
    implements $EducationDTOCopyWith<$Res> {
  factory _$$EducationDTOImplCopyWith(
          _$EducationDTOImpl value, $Res Function(_$EducationDTOImpl) then) =
      __$$EducationDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? program_completed,
      String? year_of_completion,
      String? graduating_institution});
}

/// @nodoc
class __$$EducationDTOImplCopyWithImpl<$Res>
    extends _$EducationDTOCopyWithImpl<$Res, _$EducationDTOImpl>
    implements _$$EducationDTOImplCopyWith<$Res> {
  __$$EducationDTOImplCopyWithImpl(
      _$EducationDTOImpl _value, $Res Function(_$EducationDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? program_completed = freezed,
    Object? year_of_completion = freezed,
    Object? graduating_institution = freezed,
  }) {
    return _then(_$EducationDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      program_completed: freezed == program_completed
          ? _value.program_completed
          : program_completed // ignore: cast_nullable_to_non_nullable
              as String?,
      year_of_completion: freezed == year_of_completion
          ? _value.year_of_completion
          : year_of_completion // ignore: cast_nullable_to_non_nullable
              as String?,
      graduating_institution: freezed == graduating_institution
          ? _value.graduating_institution
          : graduating_institution // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EducationDTOImpl implements _EducationDTO {
  const _$EducationDTOImpl(
      {this.id,
      this.program_completed,
      this.year_of_completion,
      this.graduating_institution});

  factory _$EducationDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$EducationDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? program_completed;
  @override
  final String? year_of_completion;
  @override
  final String? graduating_institution;

  @override
  String toString() {
    return 'EducationDTO(id: $id, program_completed: $program_completed, year_of_completion: $year_of_completion, graduating_institution: $graduating_institution)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.program_completed, program_completed) ||
                other.program_completed == program_completed) &&
            (identical(other.year_of_completion, year_of_completion) ||
                other.year_of_completion == year_of_completion) &&
            (identical(other.graduating_institution, graduating_institution) ||
                other.graduating_institution == graduating_institution));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, program_completed,
      year_of_completion, graduating_institution);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationDTOImplCopyWith<_$EducationDTOImpl> get copyWith =>
      __$$EducationDTOImplCopyWithImpl<_$EducationDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EducationDTOImplToJson(
      this,
    );
  }
}

abstract class _EducationDTO implements EducationDTO {
  const factory _EducationDTO(
      {final int? id,
      final String? program_completed,
      final String? year_of_completion,
      final String? graduating_institution}) = _$EducationDTOImpl;

  factory _EducationDTO.fromJson(Map<String, dynamic> json) =
      _$EducationDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get program_completed;
  @override
  String? get year_of_completion;
  @override
  String? get graduating_institution;
  @override
  @JsonKey(ignore: true)
  _$$EducationDTOImplCopyWith<_$EducationDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
