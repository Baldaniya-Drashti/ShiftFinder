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
  int? get start_time => throw _privateConstructorUsedError;
  int? get date => throw _privateConstructorUsedError;
  int? get end_time => throw _privateConstructorUsedError;
  String? get days => throw _privateConstructorUsedError;
  int? get objId => throw _privateConstructorUsedError;
  String? get startHour => throw _privateConstructorUsedError;
  String? get startMinute => throw _privateConstructorUsedError;
  String? get endHour => throw _privateConstructorUsedError;
  String? get endMinute => throw _privateConstructorUsedError;
  String? get totalPaybleHours => throw _privateConstructorUsedError;
  SkillDTO? get unpaid_break => throw _privateConstructorUsedError;

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
      int? start_time,
      int? date,
      int? end_time,
      String? days,
      int? objId,
      String? startHour,
      String? startMinute,
      String? endHour,
      String? endMinute,
      String? totalPaybleHours,
      SkillDTO? unpaid_break});

  $SkillDTOCopyWith<$Res>? get unpaid_break;
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
    Object? start_time = freezed,
    Object? date = freezed,
    Object? end_time = freezed,
    Object? days = freezed,
    Object? objId = freezed,
    Object? startHour = freezed,
    Object? startMinute = freezed,
    Object? endHour = freezed,
    Object? endMinute = freezed,
    Object? totalPaybleHours = freezed,
    Object? unpaid_break = freezed,
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
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as int?,
      end_time: freezed == end_time
          ? _value.end_time
          : end_time // ignore: cast_nullable_to_non_nullable
              as int?,
      days: freezed == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as String?,
      objId: freezed == objId
          ? _value.objId
          : objId // ignore: cast_nullable_to_non_nullable
              as int?,
      startHour: freezed == startHour
          ? _value.startHour
          : startHour // ignore: cast_nullable_to_non_nullable
              as String?,
      startMinute: freezed == startMinute
          ? _value.startMinute
          : startMinute // ignore: cast_nullable_to_non_nullable
              as String?,
      endHour: freezed == endHour
          ? _value.endHour
          : endHour // ignore: cast_nullable_to_non_nullable
              as String?,
      endMinute: freezed == endMinute
          ? _value.endMinute
          : endMinute // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPaybleHours: freezed == totalPaybleHours
          ? _value.totalPaybleHours
          : totalPaybleHours // ignore: cast_nullable_to_non_nullable
              as String?,
      unpaid_break: freezed == unpaid_break
          ? _value.unpaid_break
          : unpaid_break // ignore: cast_nullable_to_non_nullable
              as SkillDTO?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SkillDTOCopyWith<$Res>? get unpaid_break {
    if (_value.unpaid_break == null) {
      return null;
    }

    return $SkillDTOCopyWith<$Res>(_value.unpaid_break!, (value) {
      return _then(_value.copyWith(unpaid_break: value) as $Val);
    });
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
      int? start_time,
      int? date,
      int? end_time,
      String? days,
      int? objId,
      String? startHour,
      String? startMinute,
      String? endHour,
      String? endMinute,
      String? totalPaybleHours,
      SkillDTO? unpaid_break});

  @override
  $SkillDTOCopyWith<$Res>? get unpaid_break;
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
    Object? start_time = freezed,
    Object? date = freezed,
    Object? end_time = freezed,
    Object? days = freezed,
    Object? objId = freezed,
    Object? startHour = freezed,
    Object? startMinute = freezed,
    Object? endHour = freezed,
    Object? endMinute = freezed,
    Object? totalPaybleHours = freezed,
    Object? unpaid_break = freezed,
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
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as int?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as int?,
      end_time: freezed == end_time
          ? _value.end_time
          : end_time // ignore: cast_nullable_to_non_nullable
              as int?,
      days: freezed == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as String?,
      objId: freezed == objId
          ? _value.objId
          : objId // ignore: cast_nullable_to_non_nullable
              as int?,
      startHour: freezed == startHour
          ? _value.startHour
          : startHour // ignore: cast_nullable_to_non_nullable
              as String?,
      startMinute: freezed == startMinute
          ? _value.startMinute
          : startMinute // ignore: cast_nullable_to_non_nullable
              as String?,
      endHour: freezed == endHour
          ? _value.endHour
          : endHour // ignore: cast_nullable_to_non_nullable
              as String?,
      endMinute: freezed == endMinute
          ? _value.endMinute
          : endMinute // ignore: cast_nullable_to_non_nullable
              as String?,
      totalPaybleHours: freezed == totalPaybleHours
          ? _value.totalPaybleHours
          : totalPaybleHours // ignore: cast_nullable_to_non_nullable
              as String?,
      unpaid_break: freezed == unpaid_break
          ? _value.unpaid_break
          : unpaid_break // ignore: cast_nullable_to_non_nullable
              as SkillDTO?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftDateDetailDTOImpl implements _ShiftDateDetailDTO {
  const _$ShiftDateDetailDTOImpl(
      {this.id,
      this.recurrence_mode,
      this.start_time,
      this.date,
      this.end_time,
      this.days,
      this.objId,
      this.startHour,
      this.startMinute,
      this.endHour,
      this.endMinute,
      this.totalPaybleHours,
      this.unpaid_break});

  factory _$ShiftDateDetailDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftDateDetailDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final int? recurrence_mode;
  @override
  final int? start_time;
  @override
  final int? date;
  @override
  final int? end_time;
  @override
  final String? days;
  @override
  final int? objId;
  @override
  final String? startHour;
  @override
  final String? startMinute;
  @override
  final String? endHour;
  @override
  final String? endMinute;
  @override
  final String? totalPaybleHours;
  @override
  final SkillDTO? unpaid_break;

  @override
  String toString() {
    return 'ShiftDateDetailDTO(id: $id, recurrence_mode: $recurrence_mode, start_time: $start_time, date: $date, end_time: $end_time, days: $days, objId: $objId, startHour: $startHour, startMinute: $startMinute, endHour: $endHour, endMinute: $endMinute, totalPaybleHours: $totalPaybleHours, unpaid_break: $unpaid_break)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftDateDetailDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recurrence_mode, recurrence_mode) ||
                other.recurrence_mode == recurrence_mode) &&
            (identical(other.start_time, start_time) ||
                other.start_time == start_time) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.end_time, end_time) ||
                other.end_time == end_time) &&
            (identical(other.days, days) || other.days == days) &&
            (identical(other.objId, objId) || other.objId == objId) &&
            (identical(other.startHour, startHour) ||
                other.startHour == startHour) &&
            (identical(other.startMinute, startMinute) ||
                other.startMinute == startMinute) &&
            (identical(other.endHour, endHour) || other.endHour == endHour) &&
            (identical(other.endMinute, endMinute) ||
                other.endMinute == endMinute) &&
            (identical(other.totalPaybleHours, totalPaybleHours) ||
                other.totalPaybleHours == totalPaybleHours) &&
            (identical(other.unpaid_break, unpaid_break) ||
                other.unpaid_break == unpaid_break));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      recurrence_mode,
      start_time,
      date,
      end_time,
      days,
      objId,
      startHour,
      startMinute,
      endHour,
      endMinute,
      totalPaybleHours,
      unpaid_break);

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
      final int? start_time,
      final int? date,
      final int? end_time,
      final String? days,
      final int? objId,
      final String? startHour,
      final String? startMinute,
      final String? endHour,
      final String? endMinute,
      final String? totalPaybleHours,
      final SkillDTO? unpaid_break}) = _$ShiftDateDetailDTOImpl;

  factory _ShiftDateDetailDTO.fromJson(Map<String, dynamic> json) =
      _$ShiftDateDetailDTOImpl.fromJson;

  @override
  int? get id;
  @override
  int? get recurrence_mode;
  @override
  int? get start_time;
  @override
  int? get date;
  @override
  int? get end_time;
  @override
  String? get days;
  @override
  int? get objId;
  @override
  String? get startHour;
  @override
  String? get startMinute;
  @override
  String? get endHour;
  @override
  String? get endMinute;
  @override
  String? get totalPaybleHours;
  @override
  SkillDTO? get unpaid_break;
  @override
  @JsonKey(ignore: true)
  _$$ShiftDateDetailDTOImplCopyWith<_$ShiftDateDetailDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
