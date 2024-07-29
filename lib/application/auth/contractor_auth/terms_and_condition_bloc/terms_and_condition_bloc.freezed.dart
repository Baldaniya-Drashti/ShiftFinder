// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'terms_and_condition_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TermsAndConditionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() submitTerms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? submitTerms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? submitTerms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubmitTerms value) submitTerms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitTerms value)? submitTerms,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitTerms value)? submitTerms,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsAndConditionEventCopyWith<$Res> {
  factory $TermsAndConditionEventCopyWith(TermsAndConditionEvent value,
          $Res Function(TermsAndConditionEvent) then) =
      _$TermsAndConditionEventCopyWithImpl<$Res, TermsAndConditionEvent>;
}

/// @nodoc
class _$TermsAndConditionEventCopyWithImpl<$Res,
        $Val extends TermsAndConditionEvent>
    implements $TermsAndConditionEventCopyWith<$Res> {
  _$TermsAndConditionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SubmitTermsImplCopyWith<$Res> {
  factory _$$SubmitTermsImplCopyWith(
          _$SubmitTermsImpl value, $Res Function(_$SubmitTermsImpl) then) =
      __$$SubmitTermsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitTermsImplCopyWithImpl<$Res>
    extends _$TermsAndConditionEventCopyWithImpl<$Res, _$SubmitTermsImpl>
    implements _$$SubmitTermsImplCopyWith<$Res> {
  __$$SubmitTermsImplCopyWithImpl(
      _$SubmitTermsImpl _value, $Res Function(_$SubmitTermsImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubmitTermsImpl implements SubmitTerms {
  const _$SubmitTermsImpl();

  @override
  String toString() {
    return 'TermsAndConditionEvent.submitTerms()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitTermsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() submitTerms,
  }) {
    return submitTerms();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? submitTerms,
  }) {
    return submitTerms?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? submitTerms,
    required TResult orElse(),
  }) {
    if (submitTerms != null) {
      return submitTerms();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubmitTerms value) submitTerms,
  }) {
    return submitTerms(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitTerms value)? submitTerms,
  }) {
    return submitTerms?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitTerms value)? submitTerms,
    required TResult orElse(),
  }) {
    if (submitTerms != null) {
      return submitTerms(this);
    }
    return orElse();
  }
}

abstract class SubmitTerms implements TermsAndConditionEvent {
  const factory SubmitTerms() = _$SubmitTermsImpl;
}

/// @nodoc
mixin _$TermsAndConditionState {
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, Account>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TermsAndConditionStateCopyWith<TermsAndConditionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsAndConditionStateCopyWith<$Res> {
  factory $TermsAndConditionStateCopyWith(TermsAndConditionState value,
          $Res Function(TermsAndConditionState) then) =
      _$TermsAndConditionStateCopyWithImpl<$Res, TermsAndConditionState>;
  @useResult
  $Res call(
      {bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, Account>> authFailureOrSuccessOption});
}

/// @nodoc
class _$TermsAndConditionStateCopyWithImpl<$Res,
        $Val extends TermsAndConditionState>
    implements $TermsAndConditionStateCopyWith<$Res> {
  _$TermsAndConditionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
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
              as Option<Either<AuthFailure, Account>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermsAndConditionStateImplCopyWith<$Res>
    implements $TermsAndConditionStateCopyWith<$Res> {
  factory _$$TermsAndConditionStateImplCopyWith(
          _$TermsAndConditionStateImpl value,
          $Res Function(_$TermsAndConditionStateImpl) then) =
      __$$TermsAndConditionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, Account>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$TermsAndConditionStateImplCopyWithImpl<$Res>
    extends _$TermsAndConditionStateCopyWithImpl<$Res,
        _$TermsAndConditionStateImpl>
    implements _$$TermsAndConditionStateImplCopyWith<$Res> {
  __$$TermsAndConditionStateImplCopyWithImpl(
      _$TermsAndConditionStateImpl _value,
      $Res Function(_$TermsAndConditionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$TermsAndConditionStateImpl(
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
              as Option<Either<AuthFailure, Account>>,
    ));
  }
}

/// @nodoc

class _$TermsAndConditionStateImpl implements _TermsAndConditionState {
  const _$TermsAndConditionStateImpl(
      {required this.showErrorMessages,
      required this.isSubmitting,
      required this.authFailureOrSuccessOption});

  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final Option<Either<AuthFailure, Account>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'TermsAndConditionState(showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsAndConditionStateImpl &&
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
  int get hashCode => Object.hash(
      runtimeType, showErrorMessages, isSubmitting, authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermsAndConditionStateImplCopyWith<_$TermsAndConditionStateImpl>
      get copyWith => __$$TermsAndConditionStateImplCopyWithImpl<
          _$TermsAndConditionStateImpl>(this, _$identity);
}

abstract class _TermsAndConditionState implements TermsAndConditionState {
  const factory _TermsAndConditionState(
      {required final bool showErrorMessages,
      required final bool isSubmitting,
      required final Option<Either<AuthFailure, Account>>
          authFailureOrSuccessOption}) = _$TermsAndConditionStateImpl;

  @override
  bool get showErrorMessages;
  @override
  bool get isSubmitting;
  @override
  Option<Either<AuthFailure, Account>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$TermsAndConditionStateImplCopyWith<_$TermsAndConditionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
