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
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectedUser) submitOnboarding1,
    required TResult Function(int selectedIndustry, BuildContext context)
        submitOnboarding2,
    required TResult Function() submitOnboarding3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedUser)? submitOnboarding1,
    TResult? Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult? Function()? submitOnboarding3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedUser)? submitOnboarding1,
    TResult Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult Function()? submitOnboarding3,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubmitOnboarding1 value) submitOnboarding1,
    required TResult Function(SubmitOnboarding2 value) submitOnboarding2,
    required TResult Function(SubmitOnboarding3 value) submitOnboarding3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult? Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult? Function(SubmitOnboarding3 value)? submitOnboarding3,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult Function(SubmitOnboarding3 value)? submitOnboarding3,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingEventCopyWith<$Res> {
  factory $OnboardingEventCopyWith(
          OnboardingEvent value, $Res Function(OnboardingEvent) then) =
      _$OnboardingEventCopyWithImpl<$Res, OnboardingEvent>;
}

/// @nodoc
class _$OnboardingEventCopyWithImpl<$Res, $Val extends OnboardingEvent>
    implements $OnboardingEventCopyWith<$Res> {
  _$OnboardingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SubmitOnboarding1ImplCopyWith<$Res> {
  factory _$$SubmitOnboarding1ImplCopyWith(_$SubmitOnboarding1Impl value,
          $Res Function(_$SubmitOnboarding1Impl) then) =
      __$$SubmitOnboarding1ImplCopyWithImpl<$Res>;
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
    required TResult Function(int selectedIndustry, BuildContext context)
        submitOnboarding2,
    required TResult Function() submitOnboarding3,
  }) {
    return submitOnboarding1(selectedUser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedUser)? submitOnboarding1,
    TResult? Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult? Function()? submitOnboarding3,
  }) {
    return submitOnboarding1?.call(selectedUser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedUser)? submitOnboarding1,
    TResult Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult Function()? submitOnboarding3,
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
    required TResult Function(SubmitOnboarding2 value) submitOnboarding2,
    required TResult Function(SubmitOnboarding3 value) submitOnboarding3,
  }) {
    return submitOnboarding1(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult? Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult? Function(SubmitOnboarding3 value)? submitOnboarding3,
  }) {
    return submitOnboarding1?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult Function(SubmitOnboarding3 value)? submitOnboarding3,
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

  int get selectedUser;
  @JsonKey(ignore: true)
  _$$SubmitOnboarding1ImplCopyWith<_$SubmitOnboarding1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitOnboarding2ImplCopyWith<$Res> {
  factory _$$SubmitOnboarding2ImplCopyWith(_$SubmitOnboarding2Impl value,
          $Res Function(_$SubmitOnboarding2Impl) then) =
      __$$SubmitOnboarding2ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int selectedIndustry, BuildContext context});
}

/// @nodoc
class __$$SubmitOnboarding2ImplCopyWithImpl<$Res>
    extends _$OnboardingEventCopyWithImpl<$Res, _$SubmitOnboarding2Impl>
    implements _$$SubmitOnboarding2ImplCopyWith<$Res> {
  __$$SubmitOnboarding2ImplCopyWithImpl(_$SubmitOnboarding2Impl _value,
      $Res Function(_$SubmitOnboarding2Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndustry = null,
    Object? context = null,
  }) {
    return _then(_$SubmitOnboarding2Impl(
      null == selectedIndustry
          ? _value.selectedIndustry
          : selectedIndustry // ignore: cast_nullable_to_non_nullable
              as int,
      null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
    ));
  }
}

/// @nodoc

class _$SubmitOnboarding2Impl implements SubmitOnboarding2 {
  const _$SubmitOnboarding2Impl(this.selectedIndustry, this.context);

  @override
  final int selectedIndustry;
  @override
  final BuildContext context;

  @override
  String toString() {
    return 'OnboardingEvent.submitOnboarding2(selectedIndustry: $selectedIndustry, context: $context)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitOnboarding2Impl &&
            (identical(other.selectedIndustry, selectedIndustry) ||
                other.selectedIndustry == selectedIndustry) &&
            (identical(other.context, context) || other.context == context));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIndustry, context);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitOnboarding2ImplCopyWith<_$SubmitOnboarding2Impl> get copyWith =>
      __$$SubmitOnboarding2ImplCopyWithImpl<_$SubmitOnboarding2Impl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectedUser) submitOnboarding1,
    required TResult Function(int selectedIndustry, BuildContext context)
        submitOnboarding2,
    required TResult Function() submitOnboarding3,
  }) {
    return submitOnboarding2(selectedIndustry, context);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedUser)? submitOnboarding1,
    TResult? Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult? Function()? submitOnboarding3,
  }) {
    return submitOnboarding2?.call(selectedIndustry, context);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedUser)? submitOnboarding1,
    TResult Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult Function()? submitOnboarding3,
    required TResult orElse(),
  }) {
    if (submitOnboarding2 != null) {
      return submitOnboarding2(selectedIndustry, context);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubmitOnboarding1 value) submitOnboarding1,
    required TResult Function(SubmitOnboarding2 value) submitOnboarding2,
    required TResult Function(SubmitOnboarding3 value) submitOnboarding3,
  }) {
    return submitOnboarding2(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult? Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult? Function(SubmitOnboarding3 value)? submitOnboarding3,
  }) {
    return submitOnboarding2?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult Function(SubmitOnboarding3 value)? submitOnboarding3,
    required TResult orElse(),
  }) {
    if (submitOnboarding2 != null) {
      return submitOnboarding2(this);
    }
    return orElse();
  }
}

abstract class SubmitOnboarding2 implements OnboardingEvent {
  const factory SubmitOnboarding2(
          final int selectedIndustry, final BuildContext context) =
      _$SubmitOnboarding2Impl;

  int get selectedIndustry;
  BuildContext get context;
  @JsonKey(ignore: true)
  _$$SubmitOnboarding2ImplCopyWith<_$SubmitOnboarding2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitOnboarding3ImplCopyWith<$Res> {
  factory _$$SubmitOnboarding3ImplCopyWith(_$SubmitOnboarding3Impl value,
          $Res Function(_$SubmitOnboarding3Impl) then) =
      __$$SubmitOnboarding3ImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitOnboarding3ImplCopyWithImpl<$Res>
    extends _$OnboardingEventCopyWithImpl<$Res, _$SubmitOnboarding3Impl>
    implements _$$SubmitOnboarding3ImplCopyWith<$Res> {
  __$$SubmitOnboarding3ImplCopyWithImpl(_$SubmitOnboarding3Impl _value,
      $Res Function(_$SubmitOnboarding3Impl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubmitOnboarding3Impl implements SubmitOnboarding3 {
  const _$SubmitOnboarding3Impl();

  @override
  String toString() {
    return 'OnboardingEvent.submitOnboarding3()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitOnboarding3Impl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int selectedUser) submitOnboarding1,
    required TResult Function(int selectedIndustry, BuildContext context)
        submitOnboarding2,
    required TResult Function() submitOnboarding3,
  }) {
    return submitOnboarding3();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int selectedUser)? submitOnboarding1,
    TResult? Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult? Function()? submitOnboarding3,
  }) {
    return submitOnboarding3?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int selectedUser)? submitOnboarding1,
    TResult Function(int selectedIndustry, BuildContext context)?
        submitOnboarding2,
    TResult Function()? submitOnboarding3,
    required TResult orElse(),
  }) {
    if (submitOnboarding3 != null) {
      return submitOnboarding3();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubmitOnboarding1 value) submitOnboarding1,
    required TResult Function(SubmitOnboarding2 value) submitOnboarding2,
    required TResult Function(SubmitOnboarding3 value) submitOnboarding3,
  }) {
    return submitOnboarding3(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult? Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult? Function(SubmitOnboarding3 value)? submitOnboarding3,
  }) {
    return submitOnboarding3?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubmitOnboarding1 value)? submitOnboarding1,
    TResult Function(SubmitOnboarding2 value)? submitOnboarding2,
    TResult Function(SubmitOnboarding3 value)? submitOnboarding3,
    required TResult orElse(),
  }) {
    if (submitOnboarding3 != null) {
      return submitOnboarding3(this);
    }
    return orElse();
  }
}

abstract class SubmitOnboarding3 implements OnboardingEvent {
  const factory SubmitOnboarding3() = _$SubmitOnboarding3Impl;
}

/// @nodoc
mixin _$OnboardingState {
  int get selectedUser => throw _privateConstructorUsedError;
  int get selectedIndustry => throw _privateConstructorUsedError;
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
      int selectedIndustry,
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
    Object? selectedIndustry = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      selectedUser: null == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as int,
      selectedIndustry: null == selectedIndustry
          ? _value.selectedIndustry
          : selectedIndustry // ignore: cast_nullable_to_non_nullable
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
      int selectedIndustry,
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
    Object? selectedIndustry = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$OnboardingStateImpl(
      selectedUser: null == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as int,
      selectedIndustry: null == selectedIndustry
          ? _value.selectedIndustry
          : selectedIndustry // ignore: cast_nullable_to_non_nullable
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
      required this.selectedIndustry,
      required this.showErrorMessages,
      required this.authFailureOrSuccessOption});

  @override
  final int selectedUser;
  @override
  final int selectedIndustry;
  @override
  final bool showErrorMessages;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'OnboardingState(selectedUser: $selectedUser, selectedIndustry: $selectedIndustry, showErrorMessages: $showErrorMessages, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStateImpl &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser) &&
            (identical(other.selectedIndustry, selectedIndustry) ||
                other.selectedIndustry == selectedIndustry) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedUser, selectedIndustry,
      showErrorMessages, authFailureOrSuccessOption);

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
      required final int selectedIndustry,
      required final bool showErrorMessages,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$OnboardingStateImpl;

  @override
  int get selectedUser;
  @override
  int get selectedIndustry;
  @override
  bool get showErrorMessages;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
