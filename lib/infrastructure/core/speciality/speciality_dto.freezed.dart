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
  String? get specialityName => throw _privateConstructorUsedError;
  String? get specialityExperience => throw _privateConstructorUsedError;

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
  $Res call({String? specialityName, String? specialityExperience});
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
    Object? specialityName = freezed,
    Object? specialityExperience = freezed,
  }) {
    return _then(_value.copyWith(
      specialityName: freezed == specialityName
          ? _value.specialityName
          : specialityName // ignore: cast_nullable_to_non_nullable
              as String?,
      specialityExperience: freezed == specialityExperience
          ? _value.specialityExperience
          : specialityExperience // ignore: cast_nullable_to_non_nullable
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
  $Res call({String? specialityName, String? specialityExperience});
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
    Object? specialityName = freezed,
    Object? specialityExperience = freezed,
  }) {
    return _then(_$SpecialityDTOImpl(
      specialityName: freezed == specialityName
          ? _value.specialityName
          : specialityName // ignore: cast_nullable_to_non_nullable
              as String?,
      specialityExperience: freezed == specialityExperience
          ? _value.specialityExperience
          : specialityExperience // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpecialityDTOImpl implements _SpecialityDTO {
  _$SpecialityDTOImpl({this.specialityName, this.specialityExperience});

  factory _$SpecialityDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecialityDTOImplFromJson(json);

  @override
  final String? specialityName;
  @override
  final String? specialityExperience;

  @override
  String toString() {
    return 'SpecialityDTO(specialityName: $specialityName, specialityExperience: $specialityExperience)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecialityDTOImpl &&
            (identical(other.specialityName, specialityName) ||
                other.specialityName == specialityName) &&
            (identical(other.specialityExperience, specialityExperience) ||
                other.specialityExperience == specialityExperience));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, specialityName, specialityExperience);

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
  factory _SpecialityDTO(
      {final String? specialityName,
      final String? specialityExperience}) = _$SpecialityDTOImpl;

  factory _SpecialityDTO.fromJson(Map<String, dynamic> json) =
      _$SpecialityDTOImpl.fromJson;

  @override
  String? get specialityName;
  @override
  String? get specialityExperience;
  @override
  @JsonKey(ignore: true)
  _$$SpecialityDTOImplCopyWith<_$SpecialityDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
