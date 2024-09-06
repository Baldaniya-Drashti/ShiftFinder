// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShiftDetailDTO _$ShiftDetailDTOFromJson(Map<String, dynamic> json) {
  return _ShiftDetailDTO.fromJson(json);
}

/// @nodoc
mixin _$ShiftDetailDTO {
  int? get id => throw _privateConstructorUsedError;
  int? get shift_type => throw _privateConstructorUsedError;
  int? get same_or_different_time => throw _privateConstructorUsedError;
  SkillDTO? get unpaid_break => throw _privateConstructorUsedError;
  String? get total_payable_hour => throw _privateConstructorUsedError;
  int? get commute_allowance_type => throw _privateConstructorUsedError;
  int? get commute_allowance_type_details => throw _privateConstructorUsedError;
  int? get accommodation_allowance_type => throw _privateConstructorUsedError;
  int? get accommodation_allowance_type_details =>
      throw _privateConstructorUsedError;
  int? get individual_shift => throw _privateConstructorUsedError;
  String? get shift_note => throw _privateConstructorUsedError;
  int? get vacancie_type => throw _privateConstructorUsedError;
  int? get number_of_vacancie => throw _privateConstructorUsedError;
  int? get pending_vacancie => throw _privateConstructorUsedError;
  int? get recurring_status => throw _privateConstructorUsedError;
  int? get share_team_status => throw _privateConstructorUsedError;
  int? get save_template_status => throw _privateConstructorUsedError;
  String? get disclaimer => throw _privateConstructorUsedError;
  List<TeamDTO>? get teams => throw _privateConstructorUsedError;
  List<ShiftDateDetailDTO>? get detail => throw _privateConstructorUsedError;
  PayableDTO? get payables => throw _privateConstructorUsedError;
  int? get date => throw _privateConstructorUsedError;
  int? get start_time => throw _privateConstructorUsedError;
  int? get end_time => throw _privateConstructorUsedError;
  int? get recurring_start_date => throw _privateConstructorUsedError;
  int? get recurring_end_date => throw _privateConstructorUsedError;
  String? get recurrence_mode => throw _privateConstructorUsedError;
  String? get days => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShiftDetailDTOCopyWith<ShiftDetailDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftDetailDTOCopyWith<$Res> {
  factory $ShiftDetailDTOCopyWith(
          ShiftDetailDTO value, $Res Function(ShiftDetailDTO) then) =
      _$ShiftDetailDTOCopyWithImpl<$Res, ShiftDetailDTO>;
  @useResult
  $Res call(
      {int? id,
      int? shift_type,
      int? same_or_different_time,
      SkillDTO? unpaid_break,
      String? total_payable_hour,
      int? commute_allowance_type,
      int? commute_allowance_type_details,
      int? accommodation_allowance_type,
      int? accommodation_allowance_type_details,
      int? individual_shift,
      String? shift_note,
      int? vacancie_type,
      int? number_of_vacancie,
      int? pending_vacancie,
      int? recurring_status,
      int? share_team_status,
      int? save_template_status,
      String? disclaimer,
      List<TeamDTO>? teams,
      List<ShiftDateDetailDTO>? detail,
      PayableDTO? payables,
      int? date,
      int? start_time,
      int? end_time,
      int? recurring_start_date,
      int? recurring_end_date,
      String? recurrence_mode,
      String? days});

  $SkillDTOCopyWith<$Res>? get unpaid_break;
  $PayableDTOCopyWith<$Res>? get payables;
}

/// @nodoc
class _$ShiftDetailDTOCopyWithImpl<$Res, $Val extends ShiftDetailDTO>
    implements $ShiftDetailDTOCopyWith<$Res> {
  _$ShiftDetailDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? shift_type = freezed,
    Object? same_or_different_time = freezed,
    Object? unpaid_break = freezed,
    Object? total_payable_hour = freezed,
    Object? commute_allowance_type = freezed,
    Object? commute_allowance_type_details = freezed,
    Object? accommodation_allowance_type = freezed,
    Object? accommodation_allowance_type_details = freezed,
    Object? individual_shift = freezed,
    Object? shift_note = freezed,
    Object? vacancie_type = freezed,
    Object? number_of_vacancie = freezed,
    Object? pending_vacancie = freezed,
    Object? recurring_status = freezed,
    Object? share_team_status = freezed,
    Object? save_template_status = freezed,
    Object? disclaimer = freezed,
    Object? teams = freezed,
    Object? detail = freezed,
    Object? payables = freezed,
    Object? date = freezed,
    Object? start_time = freezed,
    Object? end_time = freezed,
    Object? recurring_start_date = freezed,
    Object? recurring_end_date = freezed,
    Object? recurrence_mode = freezed,
    Object? days = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      shift_type: freezed == shift_type
          ? _value.shift_type
          : shift_type // ignore: cast_nullable_to_non_nullable
              as int?,
      same_or_different_time: freezed == same_or_different_time
          ? _value.same_or_different_time
          : same_or_different_time // ignore: cast_nullable_to_non_nullable
              as int?,
      unpaid_break: freezed == unpaid_break
          ? _value.unpaid_break
          : unpaid_break // ignore: cast_nullable_to_non_nullable
              as SkillDTO?,
      total_payable_hour: freezed == total_payable_hour
          ? _value.total_payable_hour
          : total_payable_hour // ignore: cast_nullable_to_non_nullable
              as String?,
      commute_allowance_type: freezed == commute_allowance_type
          ? _value.commute_allowance_type
          : commute_allowance_type // ignore: cast_nullable_to_non_nullable
              as int?,
      commute_allowance_type_details: freezed == commute_allowance_type_details
          ? _value.commute_allowance_type_details
          : commute_allowance_type_details // ignore: cast_nullable_to_non_nullable
              as int?,
      accommodation_allowance_type: freezed == accommodation_allowance_type
          ? _value.accommodation_allowance_type
          : accommodation_allowance_type // ignore: cast_nullable_to_non_nullable
              as int?,
      accommodation_allowance_type_details: freezed ==
              accommodation_allowance_type_details
          ? _value.accommodation_allowance_type_details
          : accommodation_allowance_type_details // ignore: cast_nullable_to_non_nullable
              as int?,
      individual_shift: freezed == individual_shift
          ? _value.individual_shift
          : individual_shift // ignore: cast_nullable_to_non_nullable
              as int?,
      shift_note: freezed == shift_note
          ? _value.shift_note
          : shift_note // ignore: cast_nullable_to_non_nullable
              as String?,
      vacancie_type: freezed == vacancie_type
          ? _value.vacancie_type
          : vacancie_type // ignore: cast_nullable_to_non_nullable
              as int?,
      number_of_vacancie: freezed == number_of_vacancie
          ? _value.number_of_vacancie
          : number_of_vacancie // ignore: cast_nullable_to_non_nullable
              as int?,
      pending_vacancie: freezed == pending_vacancie
          ? _value.pending_vacancie
          : pending_vacancie // ignore: cast_nullable_to_non_nullable
              as int?,
      recurring_status: freezed == recurring_status
          ? _value.recurring_status
          : recurring_status // ignore: cast_nullable_to_non_nullable
              as int?,
      share_team_status: freezed == share_team_status
          ? _value.share_team_status
          : share_team_status // ignore: cast_nullable_to_non_nullable
              as int?,
      save_template_status: freezed == save_template_status
          ? _value.save_template_status
          : save_template_status // ignore: cast_nullable_to_non_nullable
              as int?,
      disclaimer: freezed == disclaimer
          ? _value.disclaimer
          : disclaimer // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamDTO>?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as List<ShiftDateDetailDTO>?,
      payables: freezed == payables
          ? _value.payables
          : payables // ignore: cast_nullable_to_non_nullable
              as PayableDTO?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as int?,
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as int?,
      end_time: freezed == end_time
          ? _value.end_time
          : end_time // ignore: cast_nullable_to_non_nullable
              as int?,
      recurring_start_date: freezed == recurring_start_date
          ? _value.recurring_start_date
          : recurring_start_date // ignore: cast_nullable_to_non_nullable
              as int?,
      recurring_end_date: freezed == recurring_end_date
          ? _value.recurring_end_date
          : recurring_end_date // ignore: cast_nullable_to_non_nullable
              as int?,
      recurrence_mode: freezed == recurrence_mode
          ? _value.recurrence_mode
          : recurrence_mode // ignore: cast_nullable_to_non_nullable
              as String?,
      days: freezed == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as String?,
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

  @override
  @pragma('vm:prefer-inline')
  $PayableDTOCopyWith<$Res>? get payables {
    if (_value.payables == null) {
      return null;
    }

    return $PayableDTOCopyWith<$Res>(_value.payables!, (value) {
      return _then(_value.copyWith(payables: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShiftDetailDTOImplCopyWith<$Res>
    implements $ShiftDetailDTOCopyWith<$Res> {
  factory _$$ShiftDetailDTOImplCopyWith(_$ShiftDetailDTOImpl value,
          $Res Function(_$ShiftDetailDTOImpl) then) =
      __$$ShiftDetailDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? shift_type,
      int? same_or_different_time,
      SkillDTO? unpaid_break,
      String? total_payable_hour,
      int? commute_allowance_type,
      int? commute_allowance_type_details,
      int? accommodation_allowance_type,
      int? accommodation_allowance_type_details,
      int? individual_shift,
      String? shift_note,
      int? vacancie_type,
      int? number_of_vacancie,
      int? pending_vacancie,
      int? recurring_status,
      int? share_team_status,
      int? save_template_status,
      String? disclaimer,
      List<TeamDTO>? teams,
      List<ShiftDateDetailDTO>? detail,
      PayableDTO? payables,
      int? date,
      int? start_time,
      int? end_time,
      int? recurring_start_date,
      int? recurring_end_date,
      String? recurrence_mode,
      String? days});

  @override
  $SkillDTOCopyWith<$Res>? get unpaid_break;
  @override
  $PayableDTOCopyWith<$Res>? get payables;
}

/// @nodoc
class __$$ShiftDetailDTOImplCopyWithImpl<$Res>
    extends _$ShiftDetailDTOCopyWithImpl<$Res, _$ShiftDetailDTOImpl>
    implements _$$ShiftDetailDTOImplCopyWith<$Res> {
  __$$ShiftDetailDTOImplCopyWithImpl(
      _$ShiftDetailDTOImpl _value, $Res Function(_$ShiftDetailDTOImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? shift_type = freezed,
    Object? same_or_different_time = freezed,
    Object? unpaid_break = freezed,
    Object? total_payable_hour = freezed,
    Object? commute_allowance_type = freezed,
    Object? commute_allowance_type_details = freezed,
    Object? accommodation_allowance_type = freezed,
    Object? accommodation_allowance_type_details = freezed,
    Object? individual_shift = freezed,
    Object? shift_note = freezed,
    Object? vacancie_type = freezed,
    Object? number_of_vacancie = freezed,
    Object? pending_vacancie = freezed,
    Object? recurring_status = freezed,
    Object? share_team_status = freezed,
    Object? save_template_status = freezed,
    Object? disclaimer = freezed,
    Object? teams = freezed,
    Object? detail = freezed,
    Object? payables = freezed,
    Object? date = freezed,
    Object? start_time = freezed,
    Object? end_time = freezed,
    Object? recurring_start_date = freezed,
    Object? recurring_end_date = freezed,
    Object? recurrence_mode = freezed,
    Object? days = freezed,
  }) {
    return _then(_$ShiftDetailDTOImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      shift_type: freezed == shift_type
          ? _value.shift_type
          : shift_type // ignore: cast_nullable_to_non_nullable
              as int?,
      same_or_different_time: freezed == same_or_different_time
          ? _value.same_or_different_time
          : same_or_different_time // ignore: cast_nullable_to_non_nullable
              as int?,
      unpaid_break: freezed == unpaid_break
          ? _value.unpaid_break
          : unpaid_break // ignore: cast_nullable_to_non_nullable
              as SkillDTO?,
      total_payable_hour: freezed == total_payable_hour
          ? _value.total_payable_hour
          : total_payable_hour // ignore: cast_nullable_to_non_nullable
              as String?,
      commute_allowance_type: freezed == commute_allowance_type
          ? _value.commute_allowance_type
          : commute_allowance_type // ignore: cast_nullable_to_non_nullable
              as int?,
      commute_allowance_type_details: freezed == commute_allowance_type_details
          ? _value.commute_allowance_type_details
          : commute_allowance_type_details // ignore: cast_nullable_to_non_nullable
              as int?,
      accommodation_allowance_type: freezed == accommodation_allowance_type
          ? _value.accommodation_allowance_type
          : accommodation_allowance_type // ignore: cast_nullable_to_non_nullable
              as int?,
      accommodation_allowance_type_details: freezed ==
              accommodation_allowance_type_details
          ? _value.accommodation_allowance_type_details
          : accommodation_allowance_type_details // ignore: cast_nullable_to_non_nullable
              as int?,
      individual_shift: freezed == individual_shift
          ? _value.individual_shift
          : individual_shift // ignore: cast_nullable_to_non_nullable
              as int?,
      shift_note: freezed == shift_note
          ? _value.shift_note
          : shift_note // ignore: cast_nullable_to_non_nullable
              as String?,
      vacancie_type: freezed == vacancie_type
          ? _value.vacancie_type
          : vacancie_type // ignore: cast_nullable_to_non_nullable
              as int?,
      number_of_vacancie: freezed == number_of_vacancie
          ? _value.number_of_vacancie
          : number_of_vacancie // ignore: cast_nullable_to_non_nullable
              as int?,
      pending_vacancie: freezed == pending_vacancie
          ? _value.pending_vacancie
          : pending_vacancie // ignore: cast_nullable_to_non_nullable
              as int?,
      recurring_status: freezed == recurring_status
          ? _value.recurring_status
          : recurring_status // ignore: cast_nullable_to_non_nullable
              as int?,
      share_team_status: freezed == share_team_status
          ? _value.share_team_status
          : share_team_status // ignore: cast_nullable_to_non_nullable
              as int?,
      save_template_status: freezed == save_template_status
          ? _value.save_template_status
          : save_template_status // ignore: cast_nullable_to_non_nullable
              as int?,
      disclaimer: freezed == disclaimer
          ? _value.disclaimer
          : disclaimer // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: freezed == teams
          ? _value._teams
          : teams // ignore: cast_nullable_to_non_nullable
              as List<TeamDTO>?,
      detail: freezed == detail
          ? _value._detail
          : detail // ignore: cast_nullable_to_non_nullable
              as List<ShiftDateDetailDTO>?,
      payables: freezed == payables
          ? _value.payables
          : payables // ignore: cast_nullable_to_non_nullable
              as PayableDTO?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as int?,
      start_time: freezed == start_time
          ? _value.start_time
          : start_time // ignore: cast_nullable_to_non_nullable
              as int?,
      end_time: freezed == end_time
          ? _value.end_time
          : end_time // ignore: cast_nullable_to_non_nullable
              as int?,
      recurring_start_date: freezed == recurring_start_date
          ? _value.recurring_start_date
          : recurring_start_date // ignore: cast_nullable_to_non_nullable
              as int?,
      recurring_end_date: freezed == recurring_end_date
          ? _value.recurring_end_date
          : recurring_end_date // ignore: cast_nullable_to_non_nullable
              as int?,
      recurrence_mode: freezed == recurrence_mode
          ? _value.recurrence_mode
          : recurrence_mode // ignore: cast_nullable_to_non_nullable
              as String?,
      days: freezed == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftDetailDTOImpl implements _ShiftDetailDTO {
  const _$ShiftDetailDTOImpl(
      {this.id,
      this.shift_type,
      this.same_or_different_time,
      this.unpaid_break,
      this.total_payable_hour,
      this.commute_allowance_type,
      this.commute_allowance_type_details,
      this.accommodation_allowance_type,
      this.accommodation_allowance_type_details,
      this.individual_shift,
      this.shift_note,
      this.vacancie_type,
      this.number_of_vacancie,
      this.pending_vacancie,
      this.recurring_status,
      this.share_team_status,
      this.save_template_status,
      this.disclaimer,
      final List<TeamDTO>? teams,
      final List<ShiftDateDetailDTO>? detail,
      this.payables,
      this.date,
      this.start_time,
      this.end_time,
      this.recurring_start_date,
      this.recurring_end_date,
      this.recurrence_mode,
      this.days})
      : _teams = teams,
        _detail = detail;

  factory _$ShiftDetailDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftDetailDTOImplFromJson(json);

  @override
  final int? id;
  @override
  final int? shift_type;
  @override
  final int? same_or_different_time;
  @override
  final SkillDTO? unpaid_break;
  @override
  final String? total_payable_hour;
  @override
  final int? commute_allowance_type;
  @override
  final int? commute_allowance_type_details;
  @override
  final int? accommodation_allowance_type;
  @override
  final int? accommodation_allowance_type_details;
  @override
  final int? individual_shift;
  @override
  final String? shift_note;
  @override
  final int? vacancie_type;
  @override
  final int? number_of_vacancie;
  @override
  final int? pending_vacancie;
  @override
  final int? recurring_status;
  @override
  final int? share_team_status;
  @override
  final int? save_template_status;
  @override
  final String? disclaimer;
  final List<TeamDTO>? _teams;
  @override
  List<TeamDTO>? get teams {
    final value = _teams;
    if (value == null) return null;
    if (_teams is EqualUnmodifiableListView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ShiftDateDetailDTO>? _detail;
  @override
  List<ShiftDateDetailDTO>? get detail {
    final value = _detail;
    if (value == null) return null;
    if (_detail is EqualUnmodifiableListView) return _detail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PayableDTO? payables;
  @override
  final int? date;
  @override
  final int? start_time;
  @override
  final int? end_time;
  @override
  final int? recurring_start_date;
  @override
  final int? recurring_end_date;
  @override
  final String? recurrence_mode;
  @override
  final String? days;

  @override
  String toString() {
    return 'ShiftDetailDTO(id: $id, shift_type: $shift_type, same_or_different_time: $same_or_different_time, unpaid_break: $unpaid_break, total_payable_hour: $total_payable_hour, commute_allowance_type: $commute_allowance_type, commute_allowance_type_details: $commute_allowance_type_details, accommodation_allowance_type: $accommodation_allowance_type, accommodation_allowance_type_details: $accommodation_allowance_type_details, individual_shift: $individual_shift, shift_note: $shift_note, vacancie_type: $vacancie_type, number_of_vacancie: $number_of_vacancie, pending_vacancie: $pending_vacancie, recurring_status: $recurring_status, share_team_status: $share_team_status, save_template_status: $save_template_status, disclaimer: $disclaimer, teams: $teams, detail: $detail, payables: $payables, date: $date, start_time: $start_time, end_time: $end_time, recurring_start_date: $recurring_start_date, recurring_end_date: $recurring_end_date, recurrence_mode: $recurrence_mode, days: $days)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftDetailDTOImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.shift_type, shift_type) ||
                other.shift_type == shift_type) &&
            (identical(other.same_or_different_time, same_or_different_time) ||
                other.same_or_different_time == same_or_different_time) &&
            (identical(other.unpaid_break, unpaid_break) ||
                other.unpaid_break == unpaid_break) &&
            (identical(other.total_payable_hour, total_payable_hour) ||
                other.total_payable_hour == total_payable_hour) &&
            (identical(other.commute_allowance_type, commute_allowance_type) ||
                other.commute_allowance_type == commute_allowance_type) &&
            (identical(other.commute_allowance_type_details, commute_allowance_type_details) ||
                other.commute_allowance_type_details ==
                    commute_allowance_type_details) &&
            (identical(other.accommodation_allowance_type, accommodation_allowance_type) ||
                other.accommodation_allowance_type ==
                    accommodation_allowance_type) &&
            (identical(other.accommodation_allowance_type_details, accommodation_allowance_type_details) ||
                other.accommodation_allowance_type_details ==
                    accommodation_allowance_type_details) &&
            (identical(other.individual_shift, individual_shift) ||
                other.individual_shift == individual_shift) &&
            (identical(other.shift_note, shift_note) ||
                other.shift_note == shift_note) &&
            (identical(other.vacancie_type, vacancie_type) ||
                other.vacancie_type == vacancie_type) &&
            (identical(other.number_of_vacancie, number_of_vacancie) ||
                other.number_of_vacancie == number_of_vacancie) &&
            (identical(other.pending_vacancie, pending_vacancie) ||
                other.pending_vacancie == pending_vacancie) &&
            (identical(other.recurring_status, recurring_status) ||
                other.recurring_status == recurring_status) &&
            (identical(other.share_team_status, share_team_status) ||
                other.share_team_status == share_team_status) &&
            (identical(other.save_template_status, save_template_status) ||
                other.save_template_status == save_template_status) &&
            (identical(other.disclaimer, disclaimer) ||
                other.disclaimer == disclaimer) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._detail, _detail) &&
            (identical(other.payables, payables) ||
                other.payables == payables) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.start_time, start_time) ||
                other.start_time == start_time) &&
            (identical(other.end_time, end_time) ||
                other.end_time == end_time) &&
            (identical(other.recurring_start_date, recurring_start_date) ||
                other.recurring_start_date == recurring_start_date) &&
            (identical(other.recurring_end_date, recurring_end_date) ||
                other.recurring_end_date == recurring_end_date) &&
            (identical(other.recurrence_mode, recurrence_mode) ||
                other.recurrence_mode == recurrence_mode) &&
            (identical(other.days, days) || other.days == days));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        shift_type,
        same_or_different_time,
        unpaid_break,
        total_payable_hour,
        commute_allowance_type,
        commute_allowance_type_details,
        accommodation_allowance_type,
        accommodation_allowance_type_details,
        individual_shift,
        shift_note,
        vacancie_type,
        number_of_vacancie,
        pending_vacancie,
        recurring_status,
        share_team_status,
        save_template_status,
        disclaimer,
        const DeepCollectionEquality().hash(_teams),
        const DeepCollectionEquality().hash(_detail),
        payables,
        date,
        start_time,
        end_time,
        recurring_start_date,
        recurring_end_date,
        recurrence_mode,
        days
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftDetailDTOImplCopyWith<_$ShiftDetailDTOImpl> get copyWith =>
      __$$ShiftDetailDTOImplCopyWithImpl<_$ShiftDetailDTOImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftDetailDTOImplToJson(
      this,
    );
  }
}

abstract class _ShiftDetailDTO implements ShiftDetailDTO {
  const factory _ShiftDetailDTO(
      {final int? id,
      final int? shift_type,
      final int? same_or_different_time,
      final SkillDTO? unpaid_break,
      final String? total_payable_hour,
      final int? commute_allowance_type,
      final int? commute_allowance_type_details,
      final int? accommodation_allowance_type,
      final int? accommodation_allowance_type_details,
      final int? individual_shift,
      final String? shift_note,
      final int? vacancie_type,
      final int? number_of_vacancie,
      final int? pending_vacancie,
      final int? recurring_status,
      final int? share_team_status,
      final int? save_template_status,
      final String? disclaimer,
      final List<TeamDTO>? teams,
      final List<ShiftDateDetailDTO>? detail,
      final PayableDTO? payables,
      final int? date,
      final int? start_time,
      final int? end_time,
      final int? recurring_start_date,
      final int? recurring_end_date,
      final String? recurrence_mode,
      final String? days}) = _$ShiftDetailDTOImpl;

  factory _ShiftDetailDTO.fromJson(Map<String, dynamic> json) =
      _$ShiftDetailDTOImpl.fromJson;

  @override
  int? get id;
  @override
  int? get shift_type;
  @override
  int? get same_or_different_time;
  @override
  SkillDTO? get unpaid_break;
  @override
  String? get total_payable_hour;
  @override
  int? get commute_allowance_type;
  @override
  int? get commute_allowance_type_details;
  @override
  int? get accommodation_allowance_type;
  @override
  int? get accommodation_allowance_type_details;
  @override
  int? get individual_shift;
  @override
  String? get shift_note;
  @override
  int? get vacancie_type;
  @override
  int? get number_of_vacancie;
  @override
  int? get pending_vacancie;
  @override
  int? get recurring_status;
  @override
  int? get share_team_status;
  @override
  int? get save_template_status;
  @override
  String? get disclaimer;
  @override
  List<TeamDTO>? get teams;
  @override
  List<ShiftDateDetailDTO>? get detail;
  @override
  PayableDTO? get payables;
  @override
  int? get date;
  @override
  int? get start_time;
  @override
  int? get end_time;
  @override
  int? get recurring_start_date;
  @override
  int? get recurring_end_date;
  @override
  String? get recurrence_mode;
  @override
  String? get days;
  @override
  @JsonKey(ignore: true)
  _$$ShiftDetailDTOImplCopyWith<_$ShiftDetailDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
