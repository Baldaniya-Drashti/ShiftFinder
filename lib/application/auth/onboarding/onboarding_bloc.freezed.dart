// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingEvent {
  int get selectedUser => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectedUser) submitOnboarding1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedUser)? submitOnboarding1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedUser)? submitOnboarding1,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubmitOnboarding1 value) submitOnboarding1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitOnboarding1 value)? submitOnboarding1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitOnboarding1 value)? submitOnboarding1,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnboardingEventCopyWith<OnboardingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingEventCopyWith<$Res> {
  factory $OnboardingEventCopyWith(
          OnboardingEvent value, $Res Function(OnboardingEvent) then) =
      _$OnboardingEventCopyWithImpl<$Res, OnboardingEvent>;
  @useResult
  $Res call({int selectedUser});
}

/// @nodoc
class _$OnboardingEventCopyWithImpl<$Res, $Val extends OnboardingEvent>
    implements $OnboardingEventCopyWith<$Res> {
  _$OnboardingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedUser = null,
  }) {
    return _then(_value.copyWith(
      selectedUser: null == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmitOnboarding1ImplCopyWith<$Res>
    implements $OnboardingEventCopyWith<$Res> {
  factory _$$SubmitOnboarding1ImplCopyWith(_$SubmitOnboarding1Impl value,
          $Res Function(_$SubmitOnboarding1Impl) then) =
      __$$SubmitOnboarding1ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedUser});
}

/// @nodoc
class __$$SubmitOnboarding1ImplCopyWithImpl<$Res>
    extends _$OnboardingEventCopyWithImpl<$Res, _$SubmitOnboarding1Impl>
    implements _$$SubmitOnboarding1ImplCopyWith<$Res> {
  __$$SubmitOnboarding1ImplCopyWithImpl(_$SubmitOnboarding1Impl _value,
      $Res Function(_$SubmitOnboarding1Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedUser = null,
  }) {
    return _then(_$SubmitOnboarding1Impl(
      null == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SubmitOnboarding1Impl implements SubmitOnboarding1 {
  const _$SubmitOnboarding1Impl(this.selectedUser);

  @override
  final int selectedUser;

  @override
  String toString() {
    return 'OnboardingEvent.submitOnboarding1(selectedUser: $selectedUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitOnboarding1Impl &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitOnboarding1ImplCopyWith<_$SubmitOnboarding1Impl> get copyWith =>
      __$$SubmitOnboarding1ImplCopyWithImpl<_$SubmitOnboarding1Impl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectedUser) submitOnboarding1,
  }) {
    return submitOnboarding1(selectedUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedUser)? submitOnboarding1,
  }) {
    return submitOnboarding1?.call(selectedUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedUser)? submitOnboarding1,
    required TResult orElse(),
  }) {
    if (submitOnboarding1 != null) {
      return submitOnboarding1(selectedUser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubmitOnboarding1 value) submitOnboarding1,
  }) {
    return submitOnboarding1(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitOnboarding1 value)? submitOnboarding1,
  }) {
    return submitOnboarding1?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitOnboarding1 value)? submitOnboarding1,
    required TResult orElse(),
  }) {
    if (submitOnboarding1 != null) {
      return submitOnboarding1(this);
    }
    return orElse();
  }
}

abstract class SubmitOnboarding1 implements OnboardingEvent {
  const factory SubmitOnboarding1(final int selectedUser) =
      _$SubmitOnboarding1Impl;

  @override
  int get selectedUser;
  @override
  @JsonKey(ignore: true)
  _$$SubmitOnboarding1ImplCopyWith<_$SubmitOnboarding1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OnboardingState {
  int get selectedUser => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call(
      {int selectedUser,
      bool showErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedUser = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      selectedUser: null == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as int,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingStateImplCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$OnboardingStateImplCopyWith(_$OnboardingStateImpl value,
          $Res Function(_$OnboardingStateImpl) then) =
      __$$OnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int selectedUser,
      bool showErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$OnboardingStateImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingStateImpl>
    implements _$$OnboardingStateImplCopyWith<$Res> {
  __$$OnboardingStateImplCopyWithImpl(
      _$OnboardingStateImpl _value, $Res Function(_$OnboardingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedUser = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$OnboardingStateImpl(
      selectedUser: null == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as int,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ));
  }
}

/// @nodoc

class _$OnboardingStateImpl implements _OnboardingState {
  const _$OnboardingStateImpl(
      {required this.selectedUser,
      required this.showErrorMessages,
      required this.authFailureOrSuccessOption});

  @override
  final int selectedUser;
  @override
  final bool showErrorMessages;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'OnboardingState(selectedUser: $selectedUser, showErrorMessages: $showErrorMessages, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStateImpl &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, selectedUser, showErrorMessages, authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      __$$OnboardingStateImplCopyWithImpl<_$OnboardingStateImpl>(
          this, _$identity);
}

abstract class _OnboardingState implements OnboardingState {
  const factory _OnboardingState(
      {required final int selectedUser,
      required final bool showErrorMessages,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$OnboardingStateImpl;

  @override
  int get selectedUser;
  @override
  bool get showErrorMessages;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
