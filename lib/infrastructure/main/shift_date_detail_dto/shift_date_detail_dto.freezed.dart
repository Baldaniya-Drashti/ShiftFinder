// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_date_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShiftDateDetailDTO _$ShiftDateDetailDTOFromJson(Map<String, dynamic> json) {
  return _ShiftDateDetailDTO.fromJson(json);
}

/// @nodoc
mixin _$ShiftDateDetailDTO {
  int? get id => throw _privateConstructorUsedError;
  int? get recurrence_mode => throw _privateConstructorUsedError;
  int? get start_date => throw _privateConstructorUsedError;
  int? get start_time => throw _privateConstructorUsedError;
  int? get end_date => throw _privateConstructorUsedError;
  int? get end_time => throw _privateConstructorUsedError;
  String? get days => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftDateDetailDTOCopyWith<ShiftDateDetailDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftDateDetailDTOCopyWith<$Res> {
  factory $ShiftDateDetailDTOCopyWith(
          ShiftDateDetailDTO value, $Res Function(ShiftDateDetailDTO) then) =
      _$ShiftDateDetailDTOCopyWithImpl<$Res, ShiftDateDetailDTO>;
  @useResult
  $Res call(
      {int? id,
      int? recurrence_mode,
      int? start_date,
      int? start_time,
      int? end_date,
      int? end_time,
      String? days});
}

/// @nodoc
class _$ShiftDateDetailDTOCopyWithImpl<$Res, $Val extends ShiftDateDetailDTO>
    implements $ShiftDateDetailDTOCopyWith<$Res> {
  _$ShiftDateDetailDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? recurrence_mode = freezed,
    Object? start_date = freezed,
    Object? start_time = freezed,
    Object? end_date = freezed,
    Object? end_time = freezed,
    Object? days = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      recurrence_mode: freezed == recurrence_mode
          ? _value.recurrence_mode
          : recurrence_mode // ignore: cast_nullable_to_non_nullable
              as int?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as int?,
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as int?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as int?,
      end_time: freezed == end_time
          ? _value.end_time
          : end_time // ignore: cast_nullable_to_non_nullable
              as int?,
      days: freezed == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftDateDetailDTOImplCopyWith<$Res>
    implements $ShiftDateDetailDTOCopyWith<$Res> {
  factory _$$ShiftDateDetailDTOImplCopyWith(_$ShiftDateDetailDTOImpl value,
          $Res Function(_$ShiftDateDetailDTOImpl) then) =
      __$$ShiftDateDetailDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? recurrence_mode,
      int? start_date,
      int? start_time,
      int? end_date,
      int? end_time,
      String? days});
}

/// @nodoc
class __$$ShiftDateDetailDTOImplCopyWithImpl<$Res>
    extends _$ShiftDateDetailDTOCopyWithImpl<$Res, _$ShiftDateDetailDTOImpl>
    implements _$$ShiftDateDetailDTOImplCopyWith<$Res> {
  __$$ShiftDateDetailDTOImplCopyWithImpl(_$ShiftDateDetailDTOImpl _value,
      $Res Function(_$ShiftDateDetailDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? recurrence_mode = freezed,
    Object? start_date = freezed,
    Object? start_time = freezed,
    Object? end_date = freezed,
    Object? end_time = freezed,
    Object? days = freezed,
  }) {
    return _then(_$ShiftDateDetailDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      recurrence_mode: freezed == recurrence_mode
          ? _value.recurrence_mode
          : recurrence_mode // ignore: cast_nullable_to_non_nullable
              as int?,
      start_date: freezed == start_date
          ? _value.start_date
          : start_date // ignore: cast_nullable_to_non_nullable
              as int?,
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as int?,
      end_date: freezed == end_date
          ? _value.end_date
          : end_date // ignore: cast_nullable_to_non_nullable
              as int?,
      end_time: freezed == end_time
          ? _value.end_time
          : end_time // ignore: cast_nullable_to_non_nullable
              as int?,
      days: freezed == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftDateDetailDTOImpl implements _ShiftDateDetailDTO {
  const _$ShiftDateDetailDTOImpl(
      {this.id,
      this.recurrence_mode,
      this.start_date,
      this.start_time,
      this.end_date,
      this.end_time,
      this.days});

  factory _$ShiftDateDetailDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftDateDetailDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final int? recurrence_mode;
  @override
  final int? start_date;
  @override
  final int? start_time;
  @override
  final int? end_date;
  @override
  final int? end_time;
  @override
  final String? days;

  @override
  String toString() {
    return 'ShiftDateDetailDTO(id: $id, recurrence_mode: $recurrence_mode, start_date: $start_date, start_time: $start_time, end_date: $end_date, end_time: $end_time, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftDateDetailDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recurrence_mode, recurrence_mode) ||
                other.recurrence_mode == recurrence_mode) &&
            (identical(other.start_date, start_date) ||
                other.start_date == start_date) &&
            (identical(other.start_time, start_time) ||
                other.start_time == start_time) &&
            (identical(other.end_date, end_date) ||
                other.end_date == end_date) &&
            (identical(other.end_time, end_time) ||
                other.end_time == end_time) &&
            (identical(other.days, days) || other.days == days));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, recurrence_mode, start_date,
      start_time, end_date, end_time, days);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftDateDetailDTOImplCopyWith<_$ShiftDateDetailDTOImpl> get copyWith =>
      __$$ShiftDateDetailDTOImplCopyWithImpl<_$ShiftDateDetailDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftDateDetailDTOImplToJson(
      this,
    );
  }
}

abstract class _ShiftDateDetailDTO implements ShiftDateDetailDTO {
  const factory _ShiftDateDetailDTO(
      {final int? id,
      final int? recurrence_mode,
      final int? start_date,
      final int? start_time,
      final int? end_date,
      final int? end_time,
      final String? days}) = _$ShiftDateDetailDTOImpl;

  factory _ShiftDateDetailDTO.fromJson(Map<String, dynamic> json) =
      _$ShiftDateDetailDTOImpl.fromJson;

  @override
  int? get id;
  @override
  int? get recurrence_mode;
  @override
  int? get start_date;
  @override
  int? get start_time;
  @override
  int? get end_date;
  @override
  int? get end_time;
  @override
  String? get days;
  @override
  @JsonKey(ignore: true)
  _$$ShiftDateDetailDTOImplCopyWith<_$ShiftDateDetailDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
