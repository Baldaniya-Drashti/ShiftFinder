// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_shift_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostShiftEvent {
  String get shiftType => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String shiftType) changeShiftType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String shiftType)? changeShiftType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String shiftType)? changeShiftType,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeShiftType value) changeShiftType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeShiftType value)? changeShiftType,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeShiftType value)? changeShiftType,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostShiftEventCopyWith<PostShiftEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostShiftEventCopyWith<$Res> {
  factory $PostShiftEventCopyWith(
          PostShiftEvent value, $Res Function(PostShiftEvent) then) =
      _$PostShiftEventCopyWithImpl<$Res, PostShiftEvent>;
  @useResult
  $Res call({String shiftType});
}

/// @nodoc
class _$PostShiftEventCopyWithImpl<$Res, $Val extends PostShiftEvent>
    implements $PostShiftEventCopyWith<$Res> {
  _$PostShiftEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftType = null,
  }) {
    return _then(_value.copyWith(
      shiftType: null == shiftType
          ? _value.shiftType
          : shiftType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeShiftTypeImplCopyWith<$Res>
    implements $PostShiftEventCopyWith<$Res> {
  factory _$$ChangeShiftTypeImplCopyWith(_$ChangeShiftTypeImpl value,
          $Res Function(_$ChangeShiftTypeImpl) then) =
      __$$ChangeShiftTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String shiftType});
}

/// @nodoc
class __$$ChangeShiftTypeImplCopyWithImpl<$Res>
    extends _$PostShiftEventCopyWithImpl<$Res, _$ChangeShiftTypeImpl>
    implements _$$ChangeShiftTypeImplCopyWith<$Res> {
  __$$ChangeShiftTypeImplCopyWithImpl(
      _$ChangeShiftTypeImpl _value, $Res Function(_$ChangeShiftTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftType = null,
  }) {
    return _then(_$ChangeShiftTypeImpl(
      null == shiftType
          ? _value.shiftType
          : shiftType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangeShiftTypeImpl implements ChangeShiftType {
  const _$ChangeShiftTypeImpl(this.shiftType);

  @override
  final String shiftType;

  @override
  String toString() {
    return 'PostShiftEvent.changeShiftType(shiftType: $shiftType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeShiftTypeImpl &&
            (identical(other.shiftType, shiftType) ||
                other.shiftType == shiftType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shiftType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeShiftTypeImplCopyWith<_$ChangeShiftTypeImpl> get copyWith =>
      __$$ChangeShiftTypeImplCopyWithImpl<_$ChangeShiftTypeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String shiftType) changeShiftType,
  }) {
    return changeShiftType(shiftType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String shiftType)? changeShiftType,
  }) {
    return changeShiftType?.call(shiftType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String shiftType)? changeShiftType,
    required TResult orElse(),
  }) {
    if (changeShiftType != null) {
      return changeShiftType(shiftType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChangeShiftType value) changeShiftType,
  }) {
    return changeShiftType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChangeShiftType value)? changeShiftType,
  }) {
    return changeShiftType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChangeShiftType value)? changeShiftType,
    required TResult orElse(),
  }) {
    if (changeShiftType != null) {
      return changeShiftType(this);
    }
    return orElse();
  }
}

abstract class ChangeShiftType implements PostShiftEvent {
  const factory ChangeShiftType(final String shiftType) = _$ChangeShiftTypeImpl;

  @override
  String get shiftType;
  @override
  @JsonKey(ignore: true)
  _$$ChangeShiftTypeImplCopyWith<_$ChangeShiftTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PostShiftState {
  int get shiftType => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostShiftStateCopyWith<PostShiftState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostShiftStateCopyWith<$Res> {
  factory $PostShiftStateCopyWith(
          PostShiftState value, $Res Function(PostShiftState) then) =
      _$PostShiftStateCopyWithImpl<$Res, PostShiftState>;
  @useResult
  $Res call(
      {int shiftType,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class _$PostShiftStateCopyWithImpl<$Res, $Val extends PostShiftState>
    implements $PostShiftStateCopyWith<$Res> {
  _$PostShiftStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftType = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      shiftType: null == shiftType
          ? _value.shiftType
          : shiftType // ignore: cast_nullable_to_non_nullable
              as int,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostShiftStateImplCopyWith<$Res>
    implements $PostShiftStateCopyWith<$Res> {
  factory _$$PostShiftStateImplCopyWith(_$PostShiftStateImpl value,
          $Res Function(_$PostShiftStateImpl) then) =
      __$$PostShiftStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int shiftType,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$PostShiftStateImplCopyWithImpl<$Res>
    extends _$PostShiftStateCopyWithImpl<$Res, _$PostShiftStateImpl>
    implements _$$PostShiftStateImplCopyWith<$Res> {
  __$$PostShiftStateImplCopyWithImpl(
      _$PostShiftStateImpl _value, $Res Function(_$PostShiftStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shiftType = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$PostShiftStateImpl(
      shiftType: null == shiftType
          ? _value.shiftType
          : shiftType // ignore: cast_nullable_to_non_nullable
              as int,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ));
  }
}

/// @nodoc

class _$PostShiftStateImpl implements _PostShiftState {
  const _$PostShiftStateImpl(
      {required this.shiftType,
      required this.showErrorMessages,
      required this.isSubmitting,
      required this.authFailureOrSuccessOption});

  @override
  final int shiftType;
  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'PostShiftState(shiftType: $shiftType, showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostShiftStateImpl &&
            (identical(other.shiftType, shiftType) ||
                other.shiftType == shiftType) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shiftType, showErrorMessages,
      isSubmitting, authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostShiftStateImplCopyWith<_$PostShiftStateImpl> get copyWith =>
      __$$PostShiftStateImplCopyWithImpl<_$PostShiftStateImpl>(
          this, _$identity);
}

abstract class _PostShiftState implements PostShiftState {
  const factory _PostShiftState(
      {required final int shiftType,
      required final bool showErrorMessages,
      required final bool isSubmitting,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$PostShiftStateImpl;

  @override
  int get shiftType;
  @override
  bool get showErrorMessages;
  @override
  bool get isSubmitting;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$PostShiftStateImplCopyWith<_$PostShiftStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
