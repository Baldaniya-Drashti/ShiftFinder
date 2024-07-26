// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'legal_screening_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LegalScreeningDTO _$LegalScreeningDTOFromJson(Map<String, dynamic> json) {
  return _LegalScreeningDTO.fromJson(json);
}

/// @nodoc
mixin _$LegalScreeningDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get isNa => throw _privateConstructorUsedError;
  int? get answer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LegalScreeningDTOCopyWith<LegalScreeningDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LegalScreeningDTOCopyWith<$Res> {
  factory $LegalScreeningDTOCopyWith(
          LegalScreeningDTO value, $Res Function(LegalScreeningDTO) then) =
      _$LegalScreeningDTOCopyWithImpl<$Res, LegalScreeningDTO>;
  @useResult
  $Res call({int? id, String? name, int? isNa, int? answer});
}

/// @nodoc
class _$LegalScreeningDTOCopyWithImpl<$Res, $Val extends LegalScreeningDTO>
    implements $LegalScreeningDTOCopyWith<$Res> {
  _$LegalScreeningDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isNa = freezed,
    Object? answer = freezed,
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
      isNa: freezed == isNa
          ? _value.isNa
          : isNa // ignore: cast_nullable_to_non_nullable
              as int?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LegalScreeningDTOImplCopyWith<$Res>
    implements $LegalScreeningDTOCopyWith<$Res> {
  factory _$$LegalScreeningDTOImplCopyWith(_$LegalScreeningDTOImpl value,
          $Res Function(_$LegalScreeningDTOImpl) then) =
      __$$LegalScreeningDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, int? isNa, int? answer});
}

/// @nodoc
class __$$LegalScreeningDTOImplCopyWithImpl<$Res>
    extends _$LegalScreeningDTOCopyWithImpl<$Res, _$LegalScreeningDTOImpl>
    implements _$$LegalScreeningDTOImplCopyWith<$Res> {
  __$$LegalScreeningDTOImplCopyWithImpl(_$LegalScreeningDTOImpl _value,
      $Res Function(_$LegalScreeningDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isNa = freezed,
    Object? answer = freezed,
  }) {
    return _then(_$LegalScreeningDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isNa: freezed == isNa
          ? _value.isNa
          : isNa // ignore: cast_nullable_to_non_nullable
              as int?,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LegalScreeningDTOImpl implements _LegalScreeningDTO {
  const _$LegalScreeningDTOImpl({this.id, this.name, this.isNa, this.answer});

  factory _$LegalScreeningDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$LegalScreeningDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? isNa;
  @override
  final int? answer;

  @override
  String toString() {
    return 'LegalScreeningDTO(id: $id, name: $name, isNa: $isNa, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LegalScreeningDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isNa, isNa) || other.isNa == isNa) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, isNa, answer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LegalScreeningDTOImplCopyWith<_$LegalScreeningDTOImpl> get copyWith =>
      __$$LegalScreeningDTOImplCopyWithImpl<_$LegalScreeningDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LegalScreeningDTOImplToJson(
      this,
    );
  }
}

abstract class _LegalScreeningDTO implements LegalScreeningDTO {
  const factory _LegalScreeningDTO(
      {final int? id,
      final String? name,
      final int? isNa,
      final int? answer}) = _$LegalScreeningDTOImpl;

  factory _LegalScreeningDTO.fromJson(Map<String, dynamic> json) =
      _$LegalScreeningDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  int? get isNa;
  @override
  int? get answer;
  @override
  @JsonKey(ignore: true)
  _$$LegalScreeningDTOImplCopyWith<_$LegalScreeningDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
