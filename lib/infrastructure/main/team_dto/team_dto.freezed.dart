// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamDTO _$TeamDTOFromJson(Map<String, dynamic> json) {
  return _TeamDTO.fromJson(json);
}

/// @nodoc
mixin _$TeamDTO {
  int? get id => throw _privateConstructorUsedError;
  int? get location_id => throw _privateConstructorUsedError;
  LocationDTO? get location => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get total_member => throw _privateConstructorUsedError;
  List<dynamic>? get members => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamDTOCopyWith<TeamDTO> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamDTOCopyWith<$Res> {
  factory $TeamDTOCopyWith(TeamDTO value, $Res Function(TeamDTO) then) =
      _$TeamDTOCopyWithImpl<$Res, TeamDTO>;
  @useResult
  $Res call(
      {int? id,
      int? location_id,
      LocationDTO? location,
      String? name,
      int? total_member,
      List<dynamic>? members});

  $LocationDTOCopyWith<$Res>? get location;
}

/// @nodoc
class _$TeamDTOCopyWithImpl<$Res, $Val extends TeamDTO>
    implements $TeamDTOCopyWith<$Res> {
  _$TeamDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? location_id = freezed,
    Object? location = freezed,
    Object? name = freezed,
    Object? total_member = freezed,
    Object? members = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      location_id: freezed == location_id
          ? _value.location_id
          : location_id // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationDTO?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      total_member: freezed == total_member
          ? _value.total_member
          : total_member // ignore: cast_nullable_to_non_nullable
              as int?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationDTOCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationDTOCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeamDTOImplCopyWith<$Res> implements $TeamDTOCopyWith<$Res> {
  factory _$$TeamDTOImplCopyWith(
          _$TeamDTOImpl value, $Res Function(_$TeamDTOImpl) then) =
      __$$TeamDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? location_id,
      LocationDTO? location,
      String? name,
      int? total_member,
      List<dynamic>? members});

  @override
  $LocationDTOCopyWith<$Res>? get location;
}

/// @nodoc
class __$$TeamDTOImplCopyWithImpl<$Res>
    extends _$TeamDTOCopyWithImpl<$Res, _$TeamDTOImpl>
    implements _$$TeamDTOImplCopyWith<$Res> {
  __$$TeamDTOImplCopyWithImpl(
      _$TeamDTOImpl _value, $Res Function(_$TeamDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? location_id = freezed,
    Object? location = freezed,
    Object? name = freezed,
    Object? total_member = freezed,
    Object? members = freezed,
  }) {
    return _then(_$TeamDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      location_id: freezed == location_id
          ? _value.location_id
          : location_id // ignore: cast_nullable_to_non_nullable
              as int?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationDTO?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      total_member: freezed == total_member
          ? _value.total_member
          : total_member // ignore: cast_nullable_to_non_nullable
              as int?,
      members: freezed == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamDTOImpl implements _TeamDTO {
  const _$TeamDTOImpl(
      {this.id,
      this.location_id,
      this.location,
      this.name,
      this.total_member,
      final List<dynamic>? members})
      : _members = members;

  factory _$TeamDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final int? location_id;
  @override
  final LocationDTO? location;
  @override
  final String? name;
  @override
  final int? total_member;
  final List<dynamic>? _members;
  @override
  List<dynamic>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TeamDTO(id: $id, location_id: $location_id, location: $location, name: $name, total_member: $total_member, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.location_id, location_id) ||
                other.location_id == location_id) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.total_member, total_member) ||
                other.total_member == total_member) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, location_id, location, name,
      total_member, const DeepCollectionEquality().hash(_members));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamDTOImplCopyWith<_$TeamDTOImpl> get copyWith =>
      __$$TeamDTOImplCopyWithImpl<_$TeamDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamDTOImplToJson(
      this,
    );
  }
}

abstract class _TeamDTO implements TeamDTO {
  const factory _TeamDTO(
      {final int? id,
      final int? location_id,
      final LocationDTO? location,
      final String? name,
      final int? total_member,
      final List<dynamic>? members}) = _$TeamDTOImpl;

  factory _TeamDTO.fromJson(Map<String, dynamic> json) = _$TeamDTOImpl.fromJson;

  @override
  int? get id;
  @override
  int? get location_id;
  @override
  LocationDTO? get location;
  @override
  String? get name;
  @override
  int? get total_member;
  @override
  List<dynamic>? get members;
  @override
  @JsonKey(ignore: true)
  _$$TeamDTOImplCopyWith<_$TeamDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamAvailableDTO _$TeamAvailableDTOFromJson(Map<String, dynamic> json) {
  return _TeamAvailableDTO.fromJson(json);
}

/// @nodoc
mixin _$TeamAvailableDTO {
  int? get isTeamAvailable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamAvailableDTOCopyWith<TeamAvailableDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamAvailableDTOCopyWith<$Res> {
  factory $TeamAvailableDTOCopyWith(
          TeamAvailableDTO value, $Res Function(TeamAvailableDTO) then) =
      _$TeamAvailableDTOCopyWithImpl<$Res, TeamAvailableDTO>;
  @useResult
  $Res call({int? isTeamAvailable});
}

/// @nodoc
class _$TeamAvailableDTOCopyWithImpl<$Res, $Val extends TeamAvailableDTO>
    implements $TeamAvailableDTOCopyWith<$Res> {
  _$TeamAvailableDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTeamAvailable = freezed,
  }) {
    return _then(_value.copyWith(
      isTeamAvailable: freezed == isTeamAvailable
          ? _value.isTeamAvailable
          : isTeamAvailable // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamAvailableDTOImplCopyWith<$Res>
    implements $TeamAvailableDTOCopyWith<$Res> {
  factory _$$TeamAvailableDTOImplCopyWith(_$TeamAvailableDTOImpl value,
          $Res Function(_$TeamAvailableDTOImpl) then) =
      __$$TeamAvailableDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? isTeamAvailable});
}

/// @nodoc
class __$$TeamAvailableDTOImplCopyWithImpl<$Res>
    extends _$TeamAvailableDTOCopyWithImpl<$Res, _$TeamAvailableDTOImpl>
    implements _$$TeamAvailableDTOImplCopyWith<$Res> {
  __$$TeamAvailableDTOImplCopyWithImpl(_$TeamAvailableDTOImpl _value,
      $Res Function(_$TeamAvailableDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTeamAvailable = freezed,
  }) {
    return _then(_$TeamAvailableDTOImpl(
      isTeamAvailable: freezed == isTeamAvailable
          ? _value.isTeamAvailable
          : isTeamAvailable // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamAvailableDTOImpl implements _TeamAvailableDTO {
  const _$TeamAvailableDTOImpl({this.isTeamAvailable});

  factory _$TeamAvailableDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamAvailableDTOImplFromJson(json);

  @override
  final int? isTeamAvailable;

  @override
  String toString() {
    return 'TeamAvailableDTO(isTeamAvailable: $isTeamAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamAvailableDTOImpl &&
            (identical(other.isTeamAvailable, isTeamAvailable) ||
                other.isTeamAvailable == isTeamAvailable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isTeamAvailable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamAvailableDTOImplCopyWith<_$TeamAvailableDTOImpl> get copyWith =>
      __$$TeamAvailableDTOImplCopyWithImpl<_$TeamAvailableDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamAvailableDTOImplToJson(
      this,
    );
  }
}

abstract class _TeamAvailableDTO implements TeamAvailableDTO {
  const factory _TeamAvailableDTO({final int? isTeamAvailable}) =
      _$TeamAvailableDTOImpl;

  factory _TeamAvailableDTO.fromJson(Map<String, dynamic> json) =
      _$TeamAvailableDTOImpl.fromJson;

  @override
  int? get isTeamAvailable;
  @override
  @JsonKey(ignore: true)
  _$$TeamAvailableDTOImplCopyWith<_$TeamAvailableDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
