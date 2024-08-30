// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationDTO _$LocationDTOFromJson(Map<String, dynamic> json) {
  return _LocationDTO.fromJson(json);
}

/// @nodoc
mixin _$LocationDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<UnitDTO>? get add_units => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationDTOCopyWith<LocationDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDTOCopyWith<$Res> {
  factory $LocationDTOCopyWith(
          LocationDTO value, $Res Function(LocationDTO) then) =
      _$LocationDTOCopyWithImpl<$Res, LocationDTO>;
  @useResult
  $Res call({int? id, String? location, List<UnitDTO>? add_units});
}

/// @nodoc
class _$LocationDTOCopyWithImpl<$Res, $Val extends LocationDTO>
    implements $LocationDTOCopyWith<$Res> {
  _$LocationDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? location = freezed,
    Object? add_units = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      add_units: freezed == add_units
          ? _value.add_units
          : add_units // ignore: cast_nullable_to_non_nullable
              as List<UnitDTO>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationDTOImplCopyWith<$Res>
    implements $LocationDTOCopyWith<$Res> {
  factory _$$LocationDTOImplCopyWith(
          _$LocationDTOImpl value, $Res Function(_$LocationDTOImpl) then) =
      __$$LocationDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? location, List<UnitDTO>? add_units});
}

/// @nodoc
class __$$LocationDTOImplCopyWithImpl<$Res>
    extends _$LocationDTOCopyWithImpl<$Res, _$LocationDTOImpl>
    implements _$$LocationDTOImplCopyWith<$Res> {
  __$$LocationDTOImplCopyWithImpl(
      _$LocationDTOImpl _value, $Res Function(_$LocationDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? location = freezed,
    Object? add_units = freezed,
  }) {
    return _then(_$LocationDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      add_units: freezed == add_units
          ? _value._add_units
          : add_units // ignore: cast_nullable_to_non_nullable
              as List<UnitDTO>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDTOImpl implements _LocationDTO {
  const _$LocationDTOImpl(
      {this.id, this.location, final List<UnitDTO>? add_units})
      : _add_units = add_units;

  factory _$LocationDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? location;
  final List<UnitDTO>? _add_units;
  @override
  List<UnitDTO>? get add_units {
    final value = _add_units;
    if (value == null) return null;
    if (_add_units is EqualUnmodifiableListView) return _add_units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LocationDTO(id: $id, location: $location, add_units: $add_units)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality()
                .equals(other._add_units, _add_units));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, location,
      const DeepCollectionEquality().hash(_add_units));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDTOImplCopyWith<_$LocationDTOImpl> get copyWith =>
      __$$LocationDTOImplCopyWithImpl<_$LocationDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDTOImplToJson(
      this,
    );
  }
}

abstract class _LocationDTO implements LocationDTO {
  const factory _LocationDTO(
      {final int? id,
      final String? location,
      final List<UnitDTO>? add_units}) = _$LocationDTOImpl;

  factory _LocationDTO.fromJson(Map<String, dynamic> json) =
      _$LocationDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get location;
  @override
  List<UnitDTO>? get add_units;
  @override
  @JsonKey(ignore: true)
  _$$LocationDTOImplCopyWith<_$LocationDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnitDTO _$UnitDTOFromJson(Map<String, dynamic> json) {
  return _UnitDTO.fromJson(json);
}

/// @nodoc
mixin _$UnitDTO {
  String? get number_or_name => throw _privateConstructorUsedError;
  String? get units_note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitDTOCopyWith<UnitDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitDTOCopyWith<$Res> {
  factory $UnitDTOCopyWith(UnitDTO value, $Res Function(UnitDTO) then) =
      _$UnitDTOCopyWithImpl<$Res, UnitDTO>;
  @useResult
  $Res call({String? number_or_name, String? units_note});
}

/// @nodoc
class _$UnitDTOCopyWithImpl<$Res, $Val extends UnitDTO>
    implements $UnitDTOCopyWith<$Res> {
  _$UnitDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number_or_name = freezed,
    Object? units_note = freezed,
  }) {
    return _then(_value.copyWith(
      number_or_name: freezed == number_or_name
          ? _value.number_or_name
          : number_or_name // ignore: cast_nullable_to_non_nullable
              as String?,
      units_note: freezed == units_note
          ? _value.units_note
          : units_note // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnitDTOImplCopyWith<$Res> implements $UnitDTOCopyWith<$Res> {
  factory _$$UnitDTOImplCopyWith(
          _$UnitDTOImpl value, $Res Function(_$UnitDTOImpl) then) =
      __$$UnitDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? number_or_name, String? units_note});
}

/// @nodoc
class __$$UnitDTOImplCopyWithImpl<$Res>
    extends _$UnitDTOCopyWithImpl<$Res, _$UnitDTOImpl>
    implements _$$UnitDTOImplCopyWith<$Res> {
  __$$UnitDTOImplCopyWithImpl(
      _$UnitDTOImpl _value, $Res Function(_$UnitDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number_or_name = freezed,
    Object? units_note = freezed,
  }) {
    return _then(_$UnitDTOImpl(
      number_or_name: freezed == number_or_name
          ? _value.number_or_name
          : number_or_name // ignore: cast_nullable_to_non_nullable
              as String?,
      units_note: freezed == units_note
          ? _value.units_note
          : units_note // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnitDTOImpl implements _UnitDTO {
  const _$UnitDTOImpl({this.number_or_name, this.units_note});

  factory _$UnitDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnitDTOImplFromJson(json);

  @override
  final String? number_or_name;
  @override
  final String? units_note;

  @override
  String toString() {
    return 'UnitDTO(number_or_name: $number_or_name, units_note: $units_note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnitDTOImpl &&
            (identical(other.number_or_name, number_or_name) ||
                other.number_or_name == number_or_name) &&
            (identical(other.units_note, units_note) ||
                other.units_note == units_note));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, number_or_name, units_note);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnitDTOImplCopyWith<_$UnitDTOImpl> get copyWith =>
      __$$UnitDTOImplCopyWithImpl<_$UnitDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnitDTOImplToJson(
      this,
    );
  }
}

abstract class _UnitDTO implements UnitDTO {
  const factory _UnitDTO(
      {final String? number_or_name, final String? units_note}) = _$UnitDTOImpl;

  factory _UnitDTO.fromJson(Map<String, dynamic> json) = _$UnitDTOImpl.fromJson;

  @override
  String? get number_or_name;
  @override
  String? get units_note;
  @override
  @JsonKey(ignore: true)
  _$$UnitDTOImplCopyWith<_$UnitDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
