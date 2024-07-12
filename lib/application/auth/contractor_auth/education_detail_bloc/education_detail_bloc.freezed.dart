// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'education_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EducationDetailEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String program) addProgramChanged,
    required TResult Function(String year) addCompletionYearChanged,
    required TResult Function(String institute) addInstituteChanged,
    required TResult Function() onAddBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String program)? addProgramChanged,
    TResult? Function(String year)? addCompletionYearChanged,
    TResult? Function(String institute)? addInstituteChanged,
    TResult? Function()? onAddBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String program)? addProgramChanged,
    TResult Function(String year)? addCompletionYearChanged,
    TResult Function(String institute)? addInstituteChanged,
    TResult Function()? onAddBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddProgramChanged value) addProgramChanged,
    required TResult Function(AddCompletionYearChanged value)
        addCompletionYearChanged,
    required TResult Function(AddInstituteChanged value) addInstituteChanged,
    required TResult Function(OnAddBtnPressed value) onAddBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddProgramChanged value)? addProgramChanged,
    TResult? Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult? Function(AddInstituteChanged value)? addInstituteChanged,
    TResult? Function(OnAddBtnPressed value)? onAddBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddProgramChanged value)? addProgramChanged,
    TResult Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult Function(AddInstituteChanged value)? addInstituteChanged,
    TResult Function(OnAddBtnPressed value)? onAddBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationDetailEventCopyWith<$Res> {
  factory $EducationDetailEventCopyWith(EducationDetailEvent value,
          $Res Function(EducationDetailEvent) then) =
      _$EducationDetailEventCopyWithImpl<$Res, EducationDetailEvent>;
}

/// @nodoc
class _$EducationDetailEventCopyWithImpl<$Res,
        $Val extends EducationDetailEvent>
    implements $EducationDetailEventCopyWith<$Res> {
  _$EducationDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AddProgramChangedImplCopyWith<$Res> {
  factory _$$AddProgramChangedImplCopyWith(_$AddProgramChangedImpl value,
          $Res Function(_$AddProgramChangedImpl) then) =
      __$$AddProgramChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String program});
}

/// @nodoc
class __$$AddProgramChangedImplCopyWithImpl<$Res>
    extends _$EducationDetailEventCopyWithImpl<$Res, _$AddProgramChangedImpl>
    implements _$$AddProgramChangedImplCopyWith<$Res> {
  __$$AddProgramChangedImplCopyWithImpl(_$AddProgramChangedImpl _value,
      $Res Function(_$AddProgramChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? program = null,
  }) {
    return _then(_$AddProgramChangedImpl(
      null == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddProgramChangedImpl implements AddProgramChanged {
  const _$AddProgramChangedImpl(this.program);

  @override
  final String program;

  @override
  String toString() {
    return 'EducationDetailEvent.addProgramChanged(program: $program)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddProgramChangedImpl &&
            (identical(other.program, program) || other.program == program));
  }

  @override
  int get hashCode => Object.hash(runtimeType, program);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddProgramChangedImplCopyWith<_$AddProgramChangedImpl> get copyWith =>
      __$$AddProgramChangedImplCopyWithImpl<_$AddProgramChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String program) addProgramChanged,
    required TResult Function(String year) addCompletionYearChanged,
    required TResult Function(String institute) addInstituteChanged,
    required TResult Function() onAddBtnPressed,
  }) {
    return addProgramChanged(program);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String program)? addProgramChanged,
    TResult? Function(String year)? addCompletionYearChanged,
    TResult? Function(String institute)? addInstituteChanged,
    TResult? Function()? onAddBtnPressed,
  }) {
    return addProgramChanged?.call(program);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String program)? addProgramChanged,
    TResult Function(String year)? addCompletionYearChanged,
    TResult Function(String institute)? addInstituteChanged,
    TResult Function()? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (addProgramChanged != null) {
      return addProgramChanged(program);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddProgramChanged value) addProgramChanged,
    required TResult Function(AddCompletionYearChanged value)
        addCompletionYearChanged,
    required TResult Function(AddInstituteChanged value) addInstituteChanged,
    required TResult Function(OnAddBtnPressed value) onAddBtnPressed,
  }) {
    return addProgramChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddProgramChanged value)? addProgramChanged,
    TResult? Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult? Function(AddInstituteChanged value)? addInstituteChanged,
    TResult? Function(OnAddBtnPressed value)? onAddBtnPressed,
  }) {
    return addProgramChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddProgramChanged value)? addProgramChanged,
    TResult Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult Function(AddInstituteChanged value)? addInstituteChanged,
    TResult Function(OnAddBtnPressed value)? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (addProgramChanged != null) {
      return addProgramChanged(this);
    }
    return orElse();
  }
}

abstract class AddProgramChanged implements EducationDetailEvent {
  const factory AddProgramChanged(final String program) =
      _$AddProgramChangedImpl;

  String get program;
  @JsonKey(ignore: true)
  _$$AddProgramChangedImplCopyWith<_$AddProgramChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCompletionYearChangedImplCopyWith<$Res> {
  factory _$$AddCompletionYearChangedImplCopyWith(
          _$AddCompletionYearChangedImpl value,
          $Res Function(_$AddCompletionYearChangedImpl) then) =
      __$$AddCompletionYearChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String year});
}

/// @nodoc
class __$$AddCompletionYearChangedImplCopyWithImpl<$Res>
    extends _$EducationDetailEventCopyWithImpl<$Res,
        _$AddCompletionYearChangedImpl>
    implements _$$AddCompletionYearChangedImplCopyWith<$Res> {
  __$$AddCompletionYearChangedImplCopyWithImpl(
      _$AddCompletionYearChangedImpl _value,
      $Res Function(_$AddCompletionYearChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
  }) {
    return _then(_$AddCompletionYearChangedImpl(
      null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddCompletionYearChangedImpl implements AddCompletionYearChanged {
  const _$AddCompletionYearChangedImpl(this.year);

  @override
  final String year;

  @override
  String toString() {
    return 'EducationDetailEvent.addCompletionYearChanged(year: $year)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCompletionYearChangedImpl &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(runtimeType, year);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCompletionYearChangedImplCopyWith<_$AddCompletionYearChangedImpl>
      get copyWith => __$$AddCompletionYearChangedImplCopyWithImpl<
          _$AddCompletionYearChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String program) addProgramChanged,
    required TResult Function(String year) addCompletionYearChanged,
    required TResult Function(String institute) addInstituteChanged,
    required TResult Function() onAddBtnPressed,
  }) {
    return addCompletionYearChanged(year);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String program)? addProgramChanged,
    TResult? Function(String year)? addCompletionYearChanged,
    TResult? Function(String institute)? addInstituteChanged,
    TResult? Function()? onAddBtnPressed,
  }) {
    return addCompletionYearChanged?.call(year);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String program)? addProgramChanged,
    TResult Function(String year)? addCompletionYearChanged,
    TResult Function(String institute)? addInstituteChanged,
    TResult Function()? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (addCompletionYearChanged != null) {
      return addCompletionYearChanged(year);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddProgramChanged value) addProgramChanged,
    required TResult Function(AddCompletionYearChanged value)
        addCompletionYearChanged,
    required TResult Function(AddInstituteChanged value) addInstituteChanged,
    required TResult Function(OnAddBtnPressed value) onAddBtnPressed,
  }) {
    return addCompletionYearChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddProgramChanged value)? addProgramChanged,
    TResult? Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult? Function(AddInstituteChanged value)? addInstituteChanged,
    TResult? Function(OnAddBtnPressed value)? onAddBtnPressed,
  }) {
    return addCompletionYearChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddProgramChanged value)? addProgramChanged,
    TResult Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult Function(AddInstituteChanged value)? addInstituteChanged,
    TResult Function(OnAddBtnPressed value)? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (addCompletionYearChanged != null) {
      return addCompletionYearChanged(this);
    }
    return orElse();
  }
}

abstract class AddCompletionYearChanged implements EducationDetailEvent {
  const factory AddCompletionYearChanged(final String year) =
      _$AddCompletionYearChangedImpl;

  String get year;
  @JsonKey(ignore: true)
  _$$AddCompletionYearChangedImplCopyWith<_$AddCompletionYearChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddInstituteChangedImplCopyWith<$Res> {
  factory _$$AddInstituteChangedImplCopyWith(_$AddInstituteChangedImpl value,
          $Res Function(_$AddInstituteChangedImpl) then) =
      __$$AddInstituteChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String institute});
}

/// @nodoc
class __$$AddInstituteChangedImplCopyWithImpl<$Res>
    extends _$EducationDetailEventCopyWithImpl<$Res, _$AddInstituteChangedImpl>
    implements _$$AddInstituteChangedImplCopyWith<$Res> {
  __$$AddInstituteChangedImplCopyWithImpl(_$AddInstituteChangedImpl _value,
      $Res Function(_$AddInstituteChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? institute = null,
  }) {
    return _then(_$AddInstituteChangedImpl(
      null == institute
          ? _value.institute
          : institute // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AddInstituteChangedImpl implements AddInstituteChanged {
  const _$AddInstituteChangedImpl(this.institute);

  @override
  final String institute;

  @override
  String toString() {
    return 'EducationDetailEvent.addInstituteChanged(institute: $institute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddInstituteChangedImpl &&
            (identical(other.institute, institute) ||
                other.institute == institute));
  }

  @override
  int get hashCode => Object.hash(runtimeType, institute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddInstituteChangedImplCopyWith<_$AddInstituteChangedImpl> get copyWith =>
      __$$AddInstituteChangedImplCopyWithImpl<_$AddInstituteChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String program) addProgramChanged,
    required TResult Function(String year) addCompletionYearChanged,
    required TResult Function(String institute) addInstituteChanged,
    required TResult Function() onAddBtnPressed,
  }) {
    return addInstituteChanged(institute);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String program)? addProgramChanged,
    TResult? Function(String year)? addCompletionYearChanged,
    TResult? Function(String institute)? addInstituteChanged,
    TResult? Function()? onAddBtnPressed,
  }) {
    return addInstituteChanged?.call(institute);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String program)? addProgramChanged,
    TResult Function(String year)? addCompletionYearChanged,
    TResult Function(String institute)? addInstituteChanged,
    TResult Function()? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (addInstituteChanged != null) {
      return addInstituteChanged(institute);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddProgramChanged value) addProgramChanged,
    required TResult Function(AddCompletionYearChanged value)
        addCompletionYearChanged,
    required TResult Function(AddInstituteChanged value) addInstituteChanged,
    required TResult Function(OnAddBtnPressed value) onAddBtnPressed,
  }) {
    return addInstituteChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddProgramChanged value)? addProgramChanged,
    TResult? Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult? Function(AddInstituteChanged value)? addInstituteChanged,
    TResult? Function(OnAddBtnPressed value)? onAddBtnPressed,
  }) {
    return addInstituteChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddProgramChanged value)? addProgramChanged,
    TResult Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult Function(AddInstituteChanged value)? addInstituteChanged,
    TResult Function(OnAddBtnPressed value)? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (addInstituteChanged != null) {
      return addInstituteChanged(this);
    }
    return orElse();
  }
}

abstract class AddInstituteChanged implements EducationDetailEvent {
  const factory AddInstituteChanged(final String institute) =
      _$AddInstituteChangedImpl;

  String get institute;
  @JsonKey(ignore: true)
  _$$AddInstituteChangedImplCopyWith<_$AddInstituteChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnAddBtnPressedImplCopyWith<$Res> {
  factory _$$OnAddBtnPressedImplCopyWith(_$OnAddBtnPressedImpl value,
          $Res Function(_$OnAddBtnPressedImpl) then) =
      __$$OnAddBtnPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnAddBtnPressedImplCopyWithImpl<$Res>
    extends _$EducationDetailEventCopyWithImpl<$Res, _$OnAddBtnPressedImpl>
    implements _$$OnAddBtnPressedImplCopyWith<$Res> {
  __$$OnAddBtnPressedImplCopyWithImpl(
      _$OnAddBtnPressedImpl _value, $Res Function(_$OnAddBtnPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OnAddBtnPressedImpl implements OnAddBtnPressed {
  const _$OnAddBtnPressedImpl();

  @override
  String toString() {
    return 'EducationDetailEvent.onAddBtnPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$OnAddBtnPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String program) addProgramChanged,
    required TResult Function(String year) addCompletionYearChanged,
    required TResult Function(String institute) addInstituteChanged,
    required TResult Function() onAddBtnPressed,
  }) {
    return onAddBtnPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String program)? addProgramChanged,
    TResult? Function(String year)? addCompletionYearChanged,
    TResult? Function(String institute)? addInstituteChanged,
    TResult? Function()? onAddBtnPressed,
  }) {
    return onAddBtnPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String program)? addProgramChanged,
    TResult Function(String year)? addCompletionYearChanged,
    TResult Function(String institute)? addInstituteChanged,
    TResult Function()? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (onAddBtnPressed != null) {
      return onAddBtnPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddProgramChanged value) addProgramChanged,
    required TResult Function(AddCompletionYearChanged value)
        addCompletionYearChanged,
    required TResult Function(AddInstituteChanged value) addInstituteChanged,
    required TResult Function(OnAddBtnPressed value) onAddBtnPressed,
  }) {
    return onAddBtnPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddProgramChanged value)? addProgramChanged,
    TResult? Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult? Function(AddInstituteChanged value)? addInstituteChanged,
    TResult? Function(OnAddBtnPressed value)? onAddBtnPressed,
  }) {
    return onAddBtnPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddProgramChanged value)? addProgramChanged,
    TResult Function(AddCompletionYearChanged value)? addCompletionYearChanged,
    TResult Function(AddInstituteChanged value)? addInstituteChanged,
    TResult Function(OnAddBtnPressed value)? onAddBtnPressed,
    required TResult orElse(),
  }) {
    if (onAddBtnPressed != null) {
      return onAddBtnPressed(this);
    }
    return orElse();
  }
}

abstract class OnAddBtnPressed implements EducationDetailEvent {
  const factory OnAddBtnPressed() = _$OnAddBtnPressedImpl;
}

/// @nodoc
mixin _$EducationDetailState {
  /// Add Education
  InputEmptyOrNot get selectedProgram => throw _privateConstructorUsedError;
  InputEmptyOrNot get yearOfCompletion => throw _privateConstructorUsedError;
  InputEmptyOrNot get selectedGraduation => throw _privateConstructorUsedError;

  /// SUBMIT
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get showAddEducationErrorMessages => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EducationDetailStateCopyWith<EducationDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EducationDetailStateCopyWith<$Res> {
  factory $EducationDetailStateCopyWith(EducationDetailState value,
          $Res Function(EducationDetailState) then) =
      _$EducationDetailStateCopyWithImpl<$Res, EducationDetailState>;
  @useResult
  $Res call(
      {InputEmptyOrNot selectedProgram,
      InputEmptyOrNot yearOfCompletion,
      InputEmptyOrNot selectedGraduation,
      bool isSubmitting,
      bool showAddEducationErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class _$EducationDetailStateCopyWithImpl<$Res,
        $Val extends EducationDetailState>
    implements $EducationDetailStateCopyWith<$Res> {
  _$EducationDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedProgram = null,
    Object? yearOfCompletion = null,
    Object? selectedGraduation = null,
    Object? isSubmitting = null,
    Object? showAddEducationErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      selectedProgram: null == selectedProgram
          ? _value.selectedProgram
          : selectedProgram // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      yearOfCompletion: null == yearOfCompletion
          ? _value.yearOfCompletion
          : yearOfCompletion // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      selectedGraduation: null == selectedGraduation
          ? _value.selectedGraduation
          : selectedGraduation // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showAddEducationErrorMessages: null == showAddEducationErrorMessages
          ? _value.showAddEducationErrorMessages
          : showAddEducationErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EducationDetailStateImplCopyWith<$Res>
    implements $EducationDetailStateCopyWith<$Res> {
  factory _$$EducationDetailStateImplCopyWith(_$EducationDetailStateImpl value,
          $Res Function(_$EducationDetailStateImpl) then) =
      __$$EducationDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InputEmptyOrNot selectedProgram,
      InputEmptyOrNot yearOfCompletion,
      InputEmptyOrNot selectedGraduation,
      bool isSubmitting,
      bool showAddEducationErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$EducationDetailStateImplCopyWithImpl<$Res>
    extends _$EducationDetailStateCopyWithImpl<$Res, _$EducationDetailStateImpl>
    implements _$$EducationDetailStateImplCopyWith<$Res> {
  __$$EducationDetailStateImplCopyWithImpl(_$EducationDetailStateImpl _value,
      $Res Function(_$EducationDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedProgram = null,
    Object? yearOfCompletion = null,
    Object? selectedGraduation = null,
    Object? isSubmitting = null,
    Object? showAddEducationErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$EducationDetailStateImpl(
      selectedProgram: null == selectedProgram
          ? _value.selectedProgram
          : selectedProgram // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      yearOfCompletion: null == yearOfCompletion
          ? _value.yearOfCompletion
          : yearOfCompletion // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      selectedGraduation: null == selectedGraduation
          ? _value.selectedGraduation
          : selectedGraduation // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      showAddEducationErrorMessages: null == showAddEducationErrorMessages
          ? _value.showAddEducationErrorMessages
          : showAddEducationErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ));
  }
}

/// @nodoc

class _$EducationDetailStateImpl implements _EducationDetailState {
  const _$EducationDetailStateImpl(
      {required this.selectedProgram,
      required this.yearOfCompletion,
      required this.selectedGraduation,
      required this.isSubmitting,
      required this.showAddEducationErrorMessages,
      required this.authFailureOrSuccessOption});

  /// Add Education
  @override
  final InputEmptyOrNot selectedProgram;
  @override
  final InputEmptyOrNot yearOfCompletion;
  @override
  final InputEmptyOrNot selectedGraduation;

  /// SUBMIT
  @override
  final bool isSubmitting;
  @override
  final bool showAddEducationErrorMessages;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'EducationDetailState(selectedProgram: $selectedProgram, yearOfCompletion: $yearOfCompletion, selectedGraduation: $selectedGraduation, isSubmitting: $isSubmitting, showAddEducationErrorMessages: $showAddEducationErrorMessages, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EducationDetailStateImpl &&
            (identical(other.selectedProgram, selectedProgram) ||
                other.selectedProgram == selectedProgram) &&
            (identical(other.yearOfCompletion, yearOfCompletion) ||
                other.yearOfCompletion == yearOfCompletion) &&
            (identical(other.selectedGraduation, selectedGraduation) ||
                other.selectedGraduation == selectedGraduation) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.showAddEducationErrorMessages,
                    showAddEducationErrorMessages) ||
                other.showAddEducationErrorMessages ==
                    showAddEducationErrorMessages) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedProgram,
      yearOfCompletion,
      selectedGraduation,
      isSubmitting,
      showAddEducationErrorMessages,
      authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EducationDetailStateImplCopyWith<_$EducationDetailStateImpl>
      get copyWith =>
          __$$EducationDetailStateImplCopyWithImpl<_$EducationDetailStateImpl>(
              this, _$identity);
}

abstract class _EducationDetailState implements EducationDetailState {
  const factory _EducationDetailState(
      {required final InputEmptyOrNot selectedProgram,
      required final InputEmptyOrNot yearOfCompletion,
      required final InputEmptyOrNot selectedGraduation,
      required final bool isSubmitting,
      required final bool showAddEducationErrorMessages,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$EducationDetailStateImpl;

  @override

  /// Add Education
  InputEmptyOrNot get selectedProgram;
  @override
  InputEmptyOrNot get yearOfCompletion;
  @override
  InputEmptyOrNot get selectedGraduation;
  @override

  /// SUBMIT
  bool get isSubmitting;
  @override
  bool get showAddEducationErrorMessages;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$EducationDetailStateImplCopyWith<_$EducationDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
