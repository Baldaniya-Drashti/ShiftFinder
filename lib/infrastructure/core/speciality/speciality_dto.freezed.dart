// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speciality_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpecialityDTO _$SpecialityDTOFromJson(Map<String, dynamic> json) {
  return _SpecialityDTO.fromJson(json);
}

/// @nodoc
mixin _$SpecialityDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get shortName => throw _privateConstructorUsedError;
  int? get experienceId => throw _privateConstructorUsedError;
  String? get specialityExperience => throw _privateConstructorUsedError;
  String? get specialityOther => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpecialityDTOCopyWith<SpecialityDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecialityDTOCopyWith<$Res> {
  factory $SpecialityDTOCopyWith(
          SpecialityDTO value, $Res Function(SpecialityDTO) then) =
      _$SpecialityDTOCopyWithImpl<$Res, SpecialityDTO>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? shortName,
      int? experienceId,
      String? specialityExperience,
      String? specialityOther});
}

/// @nodoc
class _$SpecialityDTOCopyWithImpl<$Res, $Val extends SpecialityDTO>
    implements $SpecialityDTOCopyWith<$Res> {
  _$SpecialityDTOCopyWithImpl(this._value, this._then);

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
    Object? experienceId = freezed,
    Object? specialityExperience = freezed,
    Object? specialityOther = freezed,
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
      experienceId: freezed == experienceId
          ? _value.experienceId
          : experienceId // ignore: cast_nullable_to_non_nullable
              as int?,
      specialityExperience: freezed == specialityExperience
          ? _value.specialityExperience
          : specialityExperience // ignore: cast_nullable_to_non_nullable
              as String?,
      specialityOther: freezed == specialityOther
          ? _value.specialityOther
          : specialityOther // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpecialityDTOImplCopyWith<$Res>
    implements $SpecialityDTOCopyWith<$Res> {
  factory _$$SpecialityDTOImplCopyWith(
          _$SpecialityDTOImpl value, $Res Function(_$SpecialityDTOImpl) then) =
      __$$SpecialityDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? shortName,
      int? experienceId,
      String? specialityExperience,
      String? specialityOther});
}

/// @nodoc
class __$$SpecialityDTOImplCopyWithImpl<$Res>
    extends _$SpecialityDTOCopyWithImpl<$Res, _$SpecialityDTOImpl>
    implements _$$SpecialityDTOImplCopyWith<$Res> {
  __$$SpecialityDTOImplCopyWithImpl(
      _$SpecialityDTOImpl _value, $Res Function(_$SpecialityDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? shortName = freezed,
    Object? experienceId = freezed,
    Object? specialityExperience = freezed,
    Object? specialityOther = freezed,
  }) {
    return _then(_$SpecialityDTOImpl(
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
      experienceId: freezed == experienceId
          ? _value.experienceId
          : experienceId // ignore: cast_nullable_to_non_nullable
              as int?,
      specialityExperience: freezed == specialityExperience
          ? _value.specialityExperience
          : specialityExperience // ignore: cast_nullable_to_non_nullable
              as String?,
      specialityOther: freezed == specialityOther
          ? _value.specialityOther
          : specialityOther // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpecialityDTOImpl implements _SpecialityDTO {
  const _$SpecialityDTOImpl(
      {this.id,
      this.name,
      this.shortName,
      this.experienceId,
      this.specialityExperience,
      this.specialityOther});

  factory _$SpecialityDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecialityDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? shortName;
  @override
  final int? experienceId;
  @override
  final String? specialityExperience;
  @override
  final String? specialityOther;

  @override
  String toString() {
    return 'SpecialityDTO(id: $id, name: $name, shortName: $shortName, experienceId: $experienceId, specialityExperience: $specialityExperience, specialityOther: $specialityOther)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecialityDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.experienceId, experienceId) ||
                other.experienceId == experienceId) &&
            (identical(other.specialityExperience, specialityExperience) ||
                other.specialityExperience == specialityExperience) &&
            (identical(other.specialityOther, specialityOther) ||
                other.specialityOther == specialityOther));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, shortName,
      experienceId, specialityExperience, specialityOther);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecialityDTOImplCopyWith<_$SpecialityDTOImpl> get copyWith =>
      __$$SpecialityDTOImplCopyWithImpl<_$SpecialityDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecialityDTOImplToJson(
      this,
    );
  }
}

abstract class _SpecialityDTO implements SpecialityDTO {
  const factory _SpecialityDTO(
      {final int? id,
      final String? name,
      final String? shortName,
      final int? experienceId,
      final String? specialityExperience,
      final String? specialityOther}) = _$SpecialityDTOImpl;

  factory _SpecialityDTO.fromJson(Map<String, dynamic> json) =
      _$SpecialityDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get shortName;
  @override
  int? get experienceId;
  @override
  String? get specialityExperience;
  @override
  String? get specialityOther;
  @override
  @JsonKey(ignore: true)
  _$$SpecialityDTOImplCopyWith<_$SpecialityDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
