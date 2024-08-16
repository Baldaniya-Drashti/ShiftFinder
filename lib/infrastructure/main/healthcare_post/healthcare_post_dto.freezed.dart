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
  List<SkillDTO>? get roles_list => throw _privateConstructorUsedError;
  List<SpecialityDTO>? get specialties_detail_list =>
      throw _privateConstructorUsedError;
  List<SkillDTO>? get softwares_skill_list =>
      throw _privateConstructorUsedError;
  String? get software_skill_other => throw _privateConstructorUsedError;
  List<SkillDTO>? get languages_list => throw _privateConstructorUsedError;
  String? get language_other => throw _privateConstructorUsedError;
  LocationDTO? get location => throw _privateConstructorUsedError;
  String? get location_unit => throw _privateConstructorUsedError;
  double? get rate_hour => throw _privateConstructorUsedError;
  ShiftDetailDTO? get shift_detail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      List<SkillDTO>? roles_list,
      List<SpecialityDTO>? specialties_detail_list,
      List<SkillDTO>? softwares_skill_list,
      String? software_skill_other,
      List<SkillDTO>? languages_list,
      String? language_other,
      LocationDTO? location,
      String? location_unit,
      double? rate_hour,
      ShiftDetailDTO? shift_detail});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? listing_id = freezed,
    Object? last_ago = freezed,
    Object? roles_list = freezed,
    Object? specialties_detail_list = freezed,
    Object? softwares_skill_list = freezed,
    Object? software_skill_other = freezed,
    Object? languages_list = freezed,
    Object? language_other = freezed,
    Object? location = freezed,
    Object? location_unit = freezed,
    Object? rate_hour = freezed,
    Object? shift_detail = freezed,
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
      roles_list: freezed == roles_list
          ? _value.roles_list
          : roles_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      specialties_detail_list: freezed == specialties_detail_list
          ? _value.specialties_detail_list
          : specialties_detail_list // ignore: cast_nullable_to_non_nullable
              as List<SpecialityDTO>?,
      softwares_skill_list: freezed == softwares_skill_list
          ? _value.softwares_skill_list
          : softwares_skill_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      software_skill_other: freezed == software_skill_other
          ? _value.software_skill_other
          : software_skill_other // ignore: cast_nullable_to_non_nullable
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
      List<SkillDTO>? roles_list,
      List<SpecialityDTO>? specialties_detail_list,
      List<SkillDTO>? softwares_skill_list,
      String? software_skill_other,
      List<SkillDTO>? languages_list,
      String? language_other,
      LocationDTO? location,
      String? location_unit,
      double? rate_hour,
      ShiftDetailDTO? shift_detail});

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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? listing_id = freezed,
    Object? last_ago = freezed,
    Object? roles_list = freezed,
    Object? specialties_detail_list = freezed,
    Object? softwares_skill_list = freezed,
    Object? software_skill_other = freezed,
    Object? languages_list = freezed,
    Object? language_other = freezed,
    Object? location = freezed,
    Object? location_unit = freezed,
    Object? rate_hour = freezed,
    Object? shift_detail = freezed,
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
      roles_list: freezed == roles_list
          ? _value._roles_list
          : roles_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      specialties_detail_list: freezed == specialties_detail_list
          ? _value._specialties_detail_list
          : specialties_detail_list // ignore: cast_nullable_to_non_nullable
              as List<SpecialityDTO>?,
      softwares_skill_list: freezed == softwares_skill_list
          ? _value._softwares_skill_list
          : softwares_skill_list // ignore: cast_nullable_to_non_nullable
              as List<SkillDTO>?,
      software_skill_other: freezed == software_skill_other
          ? _value.software_skill_other
          : software_skill_other // ignore: cast_nullable_to_non_nullable
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
      final List<SkillDTO>? roles_list,
      final List<SpecialityDTO>? specialties_detail_list,
      final List<SkillDTO>? softwares_skill_list,
      this.software_skill_other,
      final List<SkillDTO>? languages_list,
      this.language_other,
      this.location,
      this.location_unit,
      this.rate_hour,
      this.shift_detail})
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
  final List<SkillDTO>? _roles_list;
  @override
  List<SkillDTO>? get roles_list {
    final value = _roles_list;
    if (value == null) return null;
    if (_roles_list is EqualUnmodifiableListView) return _roles_list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<SpecialityDTO>? _specialties_detail_list;
  @override
  List<SpecialityDTO>? get specialties_detail_list {
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
  String toString() {
    return 'HealthcarePostDTO(id: $id, listing_id: $listing_id, last_ago: $last_ago, roles_list: $roles_list, specialties_detail_list: $specialties_detail_list, softwares_skill_list: $softwares_skill_list, software_skill_other: $software_skill_other, languages_list: $languages_list, language_other: $language_other, location: $location, location_unit: $location_unit, rate_hour: $rate_hour, shift_detail: $shift_detail)';
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
            const DeepCollectionEquality()
                .equals(other._roles_list, _roles_list) &&
            const DeepCollectionEquality().equals(
                other._specialties_detail_list, _specialties_detail_list) &&
            const DeepCollectionEquality()
                .equals(other._softwares_skill_list, _softwares_skill_list) &&
            (identical(other.software_skill_other, software_skill_other) ||
                other.software_skill_other == software_skill_other) &&
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
                other.shift_detail == shift_detail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      listing_id,
      last_ago,
      const DeepCollectionEquality().hash(_roles_list),
      const DeepCollectionEquality().hash(_specialties_detail_list),
      const DeepCollectionEquality().hash(_softwares_skill_list),
      software_skill_other,
      const DeepCollectionEquality().hash(_languages_list),
      language_other,
      location,
      location_unit,
      rate_hour,
      shift_detail);

  @JsonKey(ignore: true)
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
      final List<SkillDTO>? roles_list,
      final List<SpecialityDTO>? specialties_detail_list,
      final List<SkillDTO>? softwares_skill_list,
      final String? software_skill_other,
      final List<SkillDTO>? languages_list,
      final String? language_other,
      final LocationDTO? location,
      final String? location_unit,
      final double? rate_hour,
      final ShiftDetailDTO? shift_detail}) = _$HealthcarePostDTOImpl;

  factory _HealthcarePostDTO.fromJson(Map<String, dynamic> json) =
      _$HealthcarePostDTOImpl.fromJson;

  @override
  int? get id;
  @override
  String? get listing_id;
  @override
  String? get last_ago;
  @override
  List<SkillDTO>? get roles_list;
  @override
  List<SpecialityDTO>? get specialties_detail_list;
  @override
  List<SkillDTO>? get softwares_skill_list;
  @override
  String? get software_skill_other;
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
  @JsonKey(ignore: true)
  _$$HealthcarePostDTOImplCopyWith<_$HealthcarePostDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
