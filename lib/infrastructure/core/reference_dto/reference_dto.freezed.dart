// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReferenceDTO _$ReferenceDTOFromJson(Map<String, dynamic> json) {
  return _ReferenceDTO.fromJson(json);
}

/// @nodoc
mixin _$ReferenceDTO {
  int? get id => throw _privateConstructorUsedError;
  int? get type => throw _privateConstructorUsedError;
  String? get job_position => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get country_code => throw _privateConstructorUsedError;
  String? get country_name_code => throw _privateConstructorUsedError;
  int? get phone => throw _privateConstructorUsedError;
  String? get organization => throw _privateConstructorUsedError;
  String? get referrer => throw _privateConstructorUsedError;
  String? get job_latitude => throw _privateConstructorUsedError;
  String? get job_longitude => throw _privateConstructorUsedError;
  String? get job_location => throw _privateConstructorUsedError;
  String? get unit => throw _privateConstructorUsedError;
  int? get start_date => throw _privateConstructorUsedError;
  int? get end_date => throw _privateConstructorUsedError;
  String? get contact_person => throw _privateConstructorUsedError;
  String? get profession_referrer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferenceDTOCopyWith<ReferenceDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceDTOCopyWith<$Res> {
  factory $ReferenceDTOCopyWith(
          ReferenceDTO value, $Res Function(ReferenceDTO) then) =
      _$ReferenceDTOCopyWithImpl<$Res, ReferenceDTO>;
  @useResult
  $Res call(
      {int? id,
      int? type,
      String? job_position,
      String? email,
      String? country_code,
      String? country_name_code,
      int? phone,
      String? organization,
      String? referrer,
      String? job_latitude,
      String? job_longitude,
      String? job_location,
      String? unit,
      int? start_date,
      int? end_date,
      String? contact_person,
      String? profession_referrer});
}

/// @nodoc
class _$ReferenceDTOCopyWithImpl<$Res, $Val extends ReferenceDTO>
    implements $ReferenceDTOCopyWith<$Res> {
  _$ReferenceDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? job_position = freezed,
    Object? email = freezed,
    Object? country_code = freezed,
    Object? country_name_code = freezed,
    Object? phone = freezed,
    Object? organization = freezed,
    Object? referrer = freezed,
    Object? job_latitude = freezed,
    Object? job_longitude = freezed,
    Object? job_location = freezed,
    Object? unit = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? contact_person = freezed,
    Object? profession_referrer = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      job_position: freezed == job_position
          ? _value.job_position
          : job_position // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      country_code: freezed == country_code
          ? _value.country_code
          : country_code // ignore: cast_nullable_to_non_nullable
              as String?,
      country_name_code: freezed == country_name_code
          ? _value.country_name_code
          : country_name_code // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      referrer: freezed == referrer
          ? _value.referrer
          : referrer // ignore: cast_nullable_to_non_nullable
              as String?,
      job_latitude: freezed == job_latitude
          ? _value.job_latitude
          : job_latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      job_longitude: freezed == job_longitude
          ? _value.job_longitude
          : job_longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      job_location: freezed == job_location
          ? _value.job_location
          : job_location // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as int?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as int?,
      contact_person: freezed == contact_person
          ? _value.contact_person
          : contact_person // ignore: cast_nullable_to_non_nullable
              as String?,
      profession_referrer: freezed == profession_referrer
          ? _value.profession_referrer
          : profession_referrer // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferenceDTOImplCopyWith<$Res>
    implements $ReferenceDTOCopyWith<$Res> {
  factory _$$ReferenceDTOImplCopyWith(
          _$ReferenceDTOImpl value, $Res Function(_$ReferenceDTOImpl) then) =
      __$$ReferenceDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? type,
      String? job_position,
      String? email,
      String? country_code,
      String? country_name_code,
      int? phone,
      String? organization,
      String? referrer,
      String? job_latitude,
      String? job_longitude,
      String? job_location,
      String? unit,
      int? start_date,
      int? end_date,
      String? contact_person,
      String? profession_referrer});
}

/// @nodoc
class __$$ReferenceDTOImplCopyWithImpl<$Res>
    extends _$ReferenceDTOCopyWithImpl<$Res, _$ReferenceDTOImpl>
    implements _$$ReferenceDTOImplCopyWith<$Res> {
  __$$ReferenceDTOImplCopyWithImpl(
      _$ReferenceDTOImpl _value, $Res Function(_$ReferenceDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? job_position = freezed,
    Object? email = freezed,
    Object? country_code = freezed,
    Object? country_name_code = freezed,
    Object? phone = freezed,
    Object? organization = freezed,
    Object? referrer = freezed,
    Object? job_latitude = freezed,
    Object? job_longitude = freezed,
    Object? job_location = freezed,
    Object? unit = freezed,
    Object? start_date = freezed,
    Object? end_date = freezed,
    Object? contact_person = freezed,
    Object? profession_referrer = freezed,
  }) {
    return _then(_$ReferenceDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int?,
      job_position: freezed == job_position
          ? _value.job_position
          : job_position // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      country_code: freezed == country_code
          ? _value.country_code
          : country_code // ignore: cast_nullable_to_non_nullable
              as String?,
      country_name_code: freezed == country_name_code
          ? _value.country_name_code
          : country_name_code // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      referrer: freezed == referrer
          ? _value.referrer
          : referrer // ignore: cast_nullable_to_non_nullable
              as String?,
      job_latitude: freezed == job_latitude
          ? _value.job_latitude
          : job_latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      job_longitude: freezed == job_longitude
          ? _value.job_longitude
          : job_longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      job_location: freezed == job_location
          ? _value.job_location
          : job_location // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as int?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as int?,
      contact_person: freezed == contact_person
          ? _value.contact_person
          : contact_person // ignore: cast_nullable_to_non_nullable
              as String?,
      profession_referrer: freezed == profession_referrer
          ? _value.profession_referrer
          : profession_referrer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferenceDTOImpl implements _ReferenceDTO {
  const _$ReferenceDTOImpl(
      {this.id,
      this.type,
      this.job_position,
      this.email,
      this.country_code,
      this.country_name_code,
      this.phone,
      this.organization,
      this.referrer,
      this.job_latitude,
      this.job_longitude,
      this.job_location,
      this.unit,
      this.start_date,
      this.end_date,
      this.contact_person,
      this.profession_referrer});

  factory _$ReferenceDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferenceDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final int? type;
  @override
  final String? job_position;
  @override
  final String? email;
  @override
  final String? country_code;
  @override
  final String? country_name_code;
  @override
  final int? phone;
  @override
  final String? organization;
  @override
  final String? referrer;
  @override
  final String? job_latitude;
  @override
  final String? job_longitude;
  @override
  final String? job_location;
  @override
  final String? unit;
  @override
  final int? start_date;
  @override
  final int? end_date;
  @override
  final String? contact_person;
  @override
  final String? profession_referrer;

  @override
  String toString() {
    return 'ReferenceDTO(id: $id, type: $type, job_position: $job_position, email: $email, country_code: $country_code, country_name_code: $country_name_code, phone: $phone, organization: $organization, referrer: $referrer, job_latitude: $job_latitude, job_longitude: $job_longitude, job_location: $job_location, unit: $unit, start_date: $start_date, end_date: $end_date, contact_person: $contact_person, profession_referrer: $profession_referrer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferenceDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.job_position, job_position) ||
                other.job_position == job_position) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.country_code, country_code) ||
                other.country_code == country_code) &&
            (identical(other.country_name_code, country_name_code) ||
                other.country_name_code == country_name_code) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.organization, organization) ||
                other.organization == organization) &&
            (identical(other.referrer, referrer) ||
                other.referrer == referrer) &&
            (identical(other.job_latitude, job_latitude) ||
                other.job_latitude == job_latitude) &&
            (identical(other.job_longitude, job_longitude) ||
                other.job_longitude == job_longitude) &&
            (identical(other.job_location, job_location) ||
                other.job_location == job_location) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.start_date, start_date) ||
                other.start_date == start_date) &&
            (identical(other.end_date, end_date) ||
                other.end_date == end_date) &&
            (identical(other.contact_person, contact_person) ||
                other.contact_person == contact_person) &&
            (identical(other.profession_referrer, profession_referrer) ||
                other.profession_referrer == profession_referrer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      job_position,
      email,
      country_code,
      country_name_code,
      phone,
      organization,
      referrer,
      job_latitude,
      job_longitude,
      job_location,
      unit,
      start_date,
      end_date,
      contact_person,
      profession_referrer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferenceDTOImplCopyWith<_$ReferenceDTOImpl> get copyWith =>
      __$$ReferenceDTOImplCopyWithImpl<_$ReferenceDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferenceDTOImplToJson(
      this,
    );
  }
}

abstract class _ReferenceDTO implements ReferenceDTO {
  const factory _ReferenceDTO(
      {final int? id,
      final int? type,
      final String? job_position,
      final String? email,
      final String? country_code,
      final String? country_name_code,
      final int? phone,
      final String? organization,
      final String? referrer,
      final String? job_latitude,
      final String? job_longitude,
      final String? job_location,
      final String? unit,
      final int? start_date,
      final int? end_date,
      final String? contact_person,
      final String? profession_referrer}) = _$ReferenceDTOImpl;

  factory _ReferenceDTO.fromJson(Map<String, dynamic> json) =
      _$ReferenceDTOImpl.fromJson;

  @override
  int? get id;
  @override
  int? get type;
  @override
  String? get job_position;
  @override
  String? get email;
  @override
  String? get country_code;
  @override
  String? get country_name_code;
  @override
  int? get phone;
  @override
  String? get organization;
  @override
  String? get referrer;
  @override
  String? get job_latitude;
  @override
  String? get job_longitude;
  @override
  String? get job_location;
  @override
  String? get unit;
  @override
  int? get start_date;
  @override
  int? get end_date;
  @override
  String? get contact_person;
  @override
  String? get profession_referrer;
  @override
  @JsonKey(ignore: true)
  _$$ReferenceDTOImplCopyWith<_$ReferenceDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
