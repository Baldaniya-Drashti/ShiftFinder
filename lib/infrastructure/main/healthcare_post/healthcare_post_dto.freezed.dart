// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'healthcare_post_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HealthcarePostDTO _$HealthcarePostDTOFromJson(Map<String, dynamic> json) {
  return _HealthcarePostDTO.fromJson(json);
}

/// @nodoc
mixin _$HealthcarePostDTO {
  int? get id => throw _privateConstructorUsedError;
  String? get listing_id => throw _privateConstructorUsedError;
  String? get last_ago => throw _privateConstructorUsedError;
  String? get company_name => throw _privateConstructorUsedError;
  String? get distance => throw _privateConstructorUsedError;
  List<SkillDTO>? get roles_list => throw _privateConstructorUsedError;
  String? get roles_list_name => throw _privateConstructorUsedError;
  List<SkillDTO>? get specialties_detail_list =>
      throw _privateConstructorUsedError;
  List<SkillDTO>? get softwares_skill_list =>
      throw _privateConstructorUsedError;
  String? get software_skill_other => throw _privateConstructorUsedError;
  String? get specialties_detail_other => throw _privateConstructorUsedError;
  List<SkillDTO>? get languages_list => throw _privateConstructorUsedError;
  String? get language_other => throw _privateConstructorUsedError;
  LocationDTO? get location => throw _privateConstructorUsedError;
  String? get location_unit => throw _privateConstructorUsedError;
  double? get rate_hour => throw _privateConstructorUsedError;
  ShiftDetailDTO? get shift_detail => throw _privateConstructorUsedError;
  String? get software_skill => throw _privateConstructorUsedError;
  String? get specialties_detail => throw _privateConstructorUsedError;

  /// Serializes this HealthcarePostDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HealthcarePostDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthcarePostDTOCopyWith<HealthcarePostDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthcarePostDTOCopyWith<$Res> {
  factory $HealthcarePostDTOCopyWith(
          HealthcarePostDTO value, $Res Function(HealthcarePostDTO) then) =
      _$HealthcarePostDTOCopyWithImpl<$Res, HealthcarePostDTO>;
  @useResult
  $Res call(
      {int? id,
      String? listing_id,
      String? last_ago,
      String? company_name,
      String? distance,
      List<SkillDTO>? roles_list,
      String? roles_list_name,
      List<SkillDTO>? specialties_detail_list,
      List<SkillDTO>? softwares_skill_list,
      String? software_skill_other,
      String? specialties_detail_other,
      List<SkillDTO>? languages_list,
      String? language_other,
      LocationDTO? location,
      String? location_unit,
      double? rate_hour,
      ShiftDetailDTO? shift_detail,
      String? software_skill,
      String? specialties_detail});

  $LocationDTOCopyWith<$Res>? get location;
  $ShiftDetailDTOCopyWith<$Res>? get shift_detail;
}

/// @nodoc
class _$HealthcarePostDTOCopyWithImpl<$Res, $Val extends HealthcarePostDTO>
    implements $HealthcarePostDTOCopyWith<$Res> {
  _$HealthcarePostDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthcarePostDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? listing_id = freezed,
    Object? last_ago = freezed,
    Object? company_name = freezed,
    Object? distance = freezed,
    Object? roles_list = freezed,
    Object? roles_list_name = freezed,
    Object? specialties_detail_list = freezed,
    Object? softwares_skill_list = freezed,
    Object? software_skill_other = freezed,
    Object? specialties_detail_other = freezed,
    Object? languages_list = freezed,
    Object? language_other = freezed,
    Object? location = freezed,
    Object? location_unit = freezed,
    Object? rate_hour = freezed,
    Object? shift_detail = freezed,
    Object? software_skill = freezed,
    Object? specialties_detail = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      listing_id: freezed == listing_id
          ? _value.listing_id
          : listing_id // ignore: cast_nullable_to_non_nullable
              as String?,
      last_ago: freezed == last_ago
          ? _value.last_ago
          : last_ago // ignore: cast_nullable_to_non_nullable
              as String?,
      company_name: freezed == company_name
          ? _value.company_name
          : company_name // ignore: cast_nullable_to_non_nullable
              as String?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String?,
      roles_list: freezed == roles_list
          ? _value.roles_list
          : roles_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      roles_list_name: freezed == roles_list_name
          ? _value.roles_list_name
          : roles_list_name // ignore: cast_nullable_to_non_nullable
              as String?,
      specialties_detail_list: freezed == specialties_detail_list
          ? _value.specialties_detail_list
          : specialties_detail_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      softwares_skill_list: freezed == softwares_skill_list
          ? _value.softwares_skill_list
          : softwares_skill_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      software_skill_other: freezed == software_skill_other
          ? _value.software_skill_other
          : software_skill_other // ignore: cast_nullable_to_non_nullable
              as String?,
      specialties_detail_other: freezed == specialties_detail_other
          ? _value.specialties_detail_other
          : specialties_detail_other // ignore: cast_nullable_to_non_nullable
              as String?,
      languages_list: freezed == languages_list
          ? _value.languages_list
          : languages_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      language_other: freezed == language_other
          ? _value.language_other
          : language_other // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationDTO?,
      location_unit: freezed == location_unit
          ? _value.location_unit
          : location_unit // ignore: cast_nullable_to_non_nullable
              as String?,
      rate_hour: freezed == rate_hour
          ? _value.rate_hour
          : rate_hour // ignore: cast_nullable_to_non_nullable
              as double?,
      shift_detail: freezed == shift_detail
          ? _value.shift_detail
          : shift_detail // ignore: cast_nullable_to_non_nullable
              as ShiftDetailDTO?,
      software_skill: freezed == software_skill
          ? _value.software_skill
          : software_skill // ignore: cast_nullable_to_non_nullable
              as String?,
      specialties_detail: freezed == specialties_detail
          ? _value.specialties_detail
          : specialties_detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of HealthcarePostDTO
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of HealthcarePostDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShiftDetailDTOCopyWith<$Res>? get shift_detail {
    if (_value.shift_detail == null) {
      return null;
    }

    return $ShiftDetailDTOCopyWith<$Res>(_value.shift_detail!, (value) {
      return _then(_value.copyWith(shift_detail: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HealthcarePostDTOImplCopyWith<$Res>
    implements $HealthcarePostDTOCopyWith<$Res> {
  factory _$$HealthcarePostDTOImplCopyWith(_$HealthcarePostDTOImpl value,
          $Res Function(_$HealthcarePostDTOImpl) then) =
      __$$HealthcarePostDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? listing_id,
      String? last_ago,
      String? company_name,
      String? distance,
      List<SkillDTO>? roles_list,
      String? roles_list_name,
      List<SkillDTO>? specialties_detail_list,
      List<SkillDTO>? softwares_skill_list,
      String? software_skill_other,
      String? specialties_detail_other,
      List<SkillDTO>? languages_list,
      String? language_other,
      LocationDTO? location,
      String? location_unit,
      double? rate_hour,
      ShiftDetailDTO? shift_detail,
      String? software_skill,
      String? specialties_detail});

  @override
  $LocationDTOCopyWith<$Res>? get location;
  @override
  $ShiftDetailDTOCopyWith<$Res>? get shift_detail;
}

/// @nodoc
class __$$HealthcarePostDTOImplCopyWithImpl<$Res>
    extends _$HealthcarePostDTOCopyWithImpl<$Res, _$HealthcarePostDTOImpl>
    implements _$$HealthcarePostDTOImplCopyWith<$Res> {
  __$$HealthcarePostDTOImplCopyWithImpl(_$HealthcarePostDTOImpl _value,
      $Res Function(_$HealthcarePostDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of HealthcarePostDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? listing_id = freezed,
    Object? last_ago = freezed,
    Object? company_name = freezed,
    Object? distance = freezed,
    Object? roles_list = freezed,
    Object? roles_list_name = freezed,
    Object? specialties_detail_list = freezed,
    Object? softwares_skill_list = freezed,
    Object? software_skill_other = freezed,
    Object? specialties_detail_other = freezed,
    Object? languages_list = freezed,
    Object? language_other = freezed,
    Object? location = freezed,
    Object? location_unit = freezed,
    Object? rate_hour = freezed,
    Object? shift_detail = freezed,
    Object? software_skill = freezed,
    Object? specialties_detail = freezed,
  }) {
    return _then(_$HealthcarePostDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      listing_id: freezed == listing_id
          ? _value.listing_id
          : listing_id // ignore: cast_nullable_to_non_nullable
              as String?,
      last_ago: freezed == last_ago
          ? _value.last_ago
          : last_ago // ignore: cast_nullable_to_non_nullable
              as String?,
      company_name: freezed == company_name
          ? _value.company_name
          : company_name // ignore: cast_nullable_to_non_nullable
              as String?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as String?,
      roles_list: freezed == roles_list
          ? _value._roles_list
          : roles_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      roles_list_name: freezed == roles_list_name
          ? _value.roles_list_name
          : roles_list_name // ignore: cast_nullable_to_non_nullable
              as String?,
      specialties_detail_list: freezed == specialties_detail_list
          ? _value._specialties_detail_list
          : specialties_detail_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      softwares_skill_list: freezed == softwares_skill_list
          ? _value._softwares_skill_list
          : softwares_skill_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      software_skill_other: freezed == software_skill_other
          ? _value.software_skill_other
          : software_skill_other // ignore: cast_nullable_to_non_nullable
              as String?,
      specialties_detail_other: freezed == specialties_detail_other
          ? _value.specialties_detail_other
          : specialties_detail_other // ignore: cast_nullable_to_non_nullable
              as String?,
      languages_list: freezed == languages_list
          ? _value._languages_list
          : languages_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      language_other: freezed == language_other
          ? _value.language_other
          : language_other // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationDTO?,
      location_unit: freezed == location_unit
          ? _value.location_unit
          : location_unit // ignore: cast_nullable_to_non_nullable
              as String?,
      rate_hour: freezed == rate_hour
          ? _value.rate_hour
          : rate_hour // ignore: cast_nullable_to_non_nullable
              as double?,
      shift_detail: freezed == shift_detail
          ? _value.shift_detail
          : shift_detail // ignore: cast_nullable_to_non_nullable
              as ShiftDetailDTO?,
      software_skill: freezed == software_skill
          ? _value.software_skill
          : software_skill // ignore: cast_nullable_to_non_nullable
              as String?,
      specialties_detail: freezed == specialties_detail
          ? _value.specialties_detail
          : specialties_detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HealthcarePostDTOImpl implements _HealthcarePostDTO {
  const _$HealthcarePostDTOImpl(
      {this.id,
      this.listing_id,
      this.last_ago,
      this.company_name,
      this.distance,
      final List<SkillDTO>? roles_list,
      this.roles_list_name,
      final List<SkillDTO>? specialties_detail_list,
      final List<SkillDTO>? softwares_skill_list,
      this.software_skill_other,
      this.specialties_detail_other,
      final List<SkillDTO>? languages_list,
      this.language_other,
      this.location,
      this.location_unit,
      this.rate_hour,
      this.shift_detail,
      this.software_skill,
      this.specialties_detail})
      : _roles_list = roles_list,
        _specialties_detail_list = specialties_detail_list,
        _softwares_skill_list = softwares_skill_list,
        _languages_list = languages_list;

  factory _$HealthcarePostDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$HealthcarePostDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final String? listing_id;
  @override
  final String? last_ago;
  @override
  final String? company_name;
  @override
  final String? distance;
  final List<SkillDTO>? _roles_list;
  @override
  List<SkillDTO>? get roles_list {
    final value = _roles_list;
    if (value == null) return null;
    if (_roles_list is EqualUnmodifiableListView) return _roles_list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? roles_list_name;
  final List<SkillDTO>? _specialties_detail_list;
  @override
  List<SkillDTO>? get specialties_detail_list {
    final value = _specialties_detail_list;
    if (value == null) return null;
    if (_specialties_detail_list is EqualUnmodifiableListView)
      return _specialties_detail_list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SkillDTO>? _softwares_skill_list;
  @override
  List<SkillDTO>? get softwares_skill_list {
    final value = _softwares_skill_list;
    if (value == null) return null;
    if (_softwares_skill_list is EqualUnmodifiableListView)
      return _softwares_skill_list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? software_skill_other;
  @override
  final String? specialties_detail_other;
  final List<SkillDTO>? _languages_list;
  @override
  List<SkillDTO>? get languages_list {
    final value = _languages_list;
    if (value == null) return null;
    if (_languages_list is EqualUnmodifiableListView) return _languages_list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? language_other;
  @override
  final LocationDTO? location;
  @override
  final String? location_unit;
  @override
  final double? rate_hour;
  @override
  final ShiftDetailDTO? shift_detail;
  @override
  final String? software_skill;
  @override
  final String? specialties_detail;

  @override
  String toString() {
    return 'HealthcarePostDTO(id: $id, listing_id: $listing_id, last_ago: $last_ago, company_name: $company_name, distance: $distance, roles_list: $roles_list, roles_list_name: $roles_list_name, specialties_detail_list: $specialties_detail_list, softwares_skill_list: $softwares_skill_list, software_skill_other: $software_skill_other, specialties_detail_other: $specialties_detail_other, languages_list: $languages_list, language_other: $language_other, location: $location, location_unit: $location_unit, rate_hour: $rate_hour, shift_detail: $shift_detail, software_skill: $software_skill, specialties_detail: $specialties_detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthcarePostDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listing_id, listing_id) ||
                other.listing_id == listing_id) &&
            (identical(other.last_ago, last_ago) ||
                other.last_ago == last_ago) &&
            (identical(other.company_name, company_name) ||
                other.company_name == company_name) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            const DeepCollectionEquality()
                .equals(other._roles_list, _roles_list) &&
            (identical(other.roles_list_name, roles_list_name) ||
                other.roles_list_name == roles_list_name) &&
            const DeepCollectionEquality().equals(
                other._specialties_detail_list, _specialties_detail_list) &&
            const DeepCollectionEquality()
                .equals(other._softwares_skill_list, _softwares_skill_list) &&
            (identical(other.software_skill_other, software_skill_other) ||
                other.software_skill_other == software_skill_other) &&
            (identical(
                    other.specialties_detail_other, specialties_detail_other) ||
                other.specialties_detail_other == specialties_detail_other) &&
            const DeepCollectionEquality()
                .equals(other._languages_list, _languages_list) &&
            (identical(other.language_other, language_other) ||
                other.language_other == language_other) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.location_unit, location_unit) ||
                other.location_unit == location_unit) &&
            (identical(other.rate_hour, rate_hour) ||
                other.rate_hour == rate_hour) &&
            (identical(other.shift_detail, shift_detail) ||
                other.shift_detail == shift_detail) &&
            (identical(other.software_skill, software_skill) ||
                other.software_skill == software_skill) &&
            (identical(other.specialties_detail, specialties_detail) ||
                other.specialties_detail == specialties_detail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        listing_id,
        last_ago,
        company_name,
        distance,
        const DeepCollectionEquality().hash(_roles_list),
        roles_list_name,
        const DeepCollectionEquality().hash(_specialties_detail_list),
        const DeepCollectionEquality().hash(_softwares_skill_list),
        software_skill_other,
        specialties_detail_other,
        const DeepCollectionEquality().hash(_languages_list),
        language_other,
        location,
        location_unit,
        rate_hour,
        shift_detail,
        software_skill,
        specialties_detail
      ]);

  /// Create a copy of HealthcarePostDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthcarePostDTOImplCopyWith<_$HealthcarePostDTOImpl> get copyWith =>
      __$$HealthcarePostDTOImplCopyWithImpl<_$HealthcarePostDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HealthcarePostDTOImplToJson(
      this,
    );
  }
}

abstract class _HealthcarePostDTO implements HealthcarePostDTO {
  const factory _HealthcarePostDTO(
      {final int? id,
      final String? listing_id,
      final String? last_ago,
      final String? company_name,
      final String? distance,
      final List<SkillDTO>? roles_list,
      final String? roles_list_name,
      final List<SkillDTO>? specialties_detail_list,
      final List<SkillDTO>? softwares_skill_list,
      final String? software_skill_other,
      final String? specialties_detail_other,
      final List<SkillDTO>? languages_list,
      final String? language_other,
      final LocationDTO? location,
      final String? location_unit,
      final double? rate_hour,
      final ShiftDetailDTO? shift_detail,
      final String? software_skill,
      final String? specialties_detail}) = _$HealthcarePostDTOImpl;

  factory _HealthcarePostDTO.fromJson(Map<String, dynamic> json) =
      _$HealthcarePostDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get listing_id;
  @override
  String? get last_ago;
  @override
  String? get company_name;
  @override
  String? get distance;
  @override
  List<SkillDTO>? get roles_list;
  @override
  String? get roles_list_name;
  @override
  List<SkillDTO>? get specialties_detail_list;
  @override
  List<SkillDTO>? get softwares_skill_list;
  @override
  String? get software_skill_other;
  @override
  String? get specialties_detail_other;
  @override
  List<SkillDTO>? get languages_list;
  @override
  String? get language_other;
  @override
  LocationDTO? get location;
  @override
  String? get location_unit;
  @override
  double? get rate_hour;
  @override
  ShiftDetailDTO? get shift_detail;
  @override
  String? get software_skill;
  @override
  String? get specialties_detail;

  /// Create a copy of HealthcarePostDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthcarePostDTOImplCopyWith<_$HealthcarePostDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
