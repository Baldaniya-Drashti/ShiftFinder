// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginFormEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailId) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() obscureText,
    required TResult Function() loginPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailId)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function()? obscureText,
    TResult? Function()? loginPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailId)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? obscureText,
    TResult Function()? loginPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(LoginPressed value) loginPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(LoginPressed value)? loginPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(LoginPressed value)? loginPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormEventCopyWith<$Res> {
  factory $LoginFormEventCopyWith(
          LoginFormEvent value, $Res Function(LoginFormEvent) then) =
      _$LoginFormEventCopyWithImpl<$Res, LoginFormEvent>;
}

/// @nodoc
class _$LoginFormEventCopyWithImpl<$Res, $Val extends LoginFormEvent>
    implements $LoginFormEventCopyWith<$Res> {
  _$LoginFormEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EmailChangedImplCopyWith<$Res> {
  factory _$$EmailChangedImplCopyWith(
          _$EmailChangedImpl value, $Res Function(_$EmailChangedImpl) then) =
      __$$EmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String emailId});
}

/// @nodoc
class __$$EmailChangedImplCopyWithImpl<$Res>
    extends _$LoginFormEventCopyWithImpl<$Res, _$EmailChangedImpl>
    implements _$$EmailChangedImplCopyWith<$Res> {
  __$$EmailChangedImplCopyWithImpl(
      _$EmailChangedImpl _value, $Res Function(_$EmailChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailId = null,
  }) {
    return _then(_$EmailChangedImpl(
      null == emailId
          ? _value.emailId
          : emailId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailChangedImpl implements EmailChanged {
  const _$EmailChangedImpl(this.emailId);

  @override
  final String emailId;

  @override
  String toString() {
    return 'LoginFormEvent.emailChanged(emailId: $emailId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailChangedImpl &&
            (identical(other.emailId, emailId) || other.emailId == emailId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, emailId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      __$$EmailChangedImplCopyWithImpl<_$EmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailId) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() obscureText,
    required TResult Function() loginPressed,
  }) {
    return emailChanged(emailId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailId)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function()? obscureText,
    TResult? Function()? loginPressed,
  }) {
    return emailChanged?.call(emailId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailId)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? obscureText,
    TResult Function()? loginPressed,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(emailId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(LoginPressed value) loginPressed,
  }) {
    return emailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(LoginPressed value)? loginPressed,
  }) {
    return emailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(LoginPressed value)? loginPressed,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(this);
    }
    return orElse();
  }
}

abstract class EmailChanged implements LoginFormEvent {
  const factory EmailChanged(final String emailId) = _$EmailChangedImpl;

  String get emailId;
  @JsonKey(ignore: true)
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordChangedImplCopyWith<$Res> {
  factory _$$PasswordChangedImplCopyWith(_$PasswordChangedImpl value,
          $Res Function(_$PasswordChangedImpl) then) =
      __$$PasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$PasswordChangedImplCopyWithImpl<$Res>
    extends _$LoginFormEventCopyWithImpl<$Res, _$PasswordChangedImpl>
    implements _$$PasswordChangedImplCopyWith<$Res> {
  __$$PasswordChangedImplCopyWithImpl(
      _$PasswordChangedImpl _value, $Res Function(_$PasswordChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_$PasswordChangedImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordChangedImpl implements PasswordChanged {
  const _$PasswordChangedImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'LoginFormEvent.passwordChanged(password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordChangedImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordChangedImplCopyWith<_$PasswordChangedImpl> get copyWith =>
      __$$PasswordChangedImplCopyWithImpl<_$PasswordChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailId) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() obscureText,
    required TResult Function() loginPressed,
  }) {
    return passwordChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailId)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function()? obscureText,
    TResult? Function()? loginPressed,
  }) {
    return passwordChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailId)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? obscureText,
    TResult Function()? loginPressed,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(LoginPressed value) loginPressed,
  }) {
    return passwordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(LoginPressed value)? loginPressed,
  }) {
    return passwordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(LoginPressed value)? loginPressed,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(this);
    }
    return orElse();
  }
}

abstract class PasswordChanged implements LoginFormEvent {
  const factory PasswordChanged(final String password) = _$PasswordChangedImpl;

  String get password;
  @JsonKey(ignore: true)
  _$$PasswordChangedImplCopyWith<_$PasswordChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ObscureTextImplCopyWith<$Res> {
  factory _$$ObscureTextImplCopyWith(
          _$ObscureTextImpl value, $Res Function(_$ObscureTextImpl) then) =
      __$$ObscureTextImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ObscureTextImplCopyWithImpl<$Res>
    extends _$LoginFormEventCopyWithImpl<$Res, _$ObscureTextImpl>
    implements _$$ObscureTextImplCopyWith<$Res> {
  __$$ObscureTextImplCopyWithImpl(
      _$ObscureTextImpl _value, $Res Function(_$ObscureTextImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ObscureTextImpl implements ObscureText {
  const _$ObscureTextImpl();

  @override
  String toString() {
    return 'LoginFormEvent.obscureText()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ObscureTextImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailId) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() obscureText,
    required TResult Function() loginPressed,
  }) {
    return obscureText();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailId)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function()? obscureText,
    TResult? Function()? loginPressed,
  }) {
    return obscureText?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailId)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? obscureText,
    TResult Function()? loginPressed,
    required TResult orElse(),
  }) {
    if (obscureText != null) {
      return obscureText();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(LoginPressed value) loginPressed,
  }) {
    return obscureText(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(LoginPressed value)? loginPressed,
  }) {
    return obscureText?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(LoginPressed value)? loginPressed,
    required TResult orElse(),
  }) {
    if (obscureText != null) {
      return obscureText(this);
    }
    return orElse();
  }
}

abstract class ObscureText implements LoginFormEvent {
  const factory ObscureText() = _$ObscureTextImpl;
}

/// @nodoc
abstract class _$$LoginPressedImplCopyWith<$Res> {
  factory _$$LoginPressedImplCopyWith(
          _$LoginPressedImpl value, $Res Function(_$LoginPressedImpl) then) =
      __$$LoginPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginPressedImplCopyWithImpl<$Res>
    extends _$LoginFormEventCopyWithImpl<$Res, _$LoginPressedImpl>
    implements _$$LoginPressedImplCopyWith<$Res> {
  __$$LoginPressedImplCopyWithImpl(
      _$LoginPressedImpl _value, $Res Function(_$LoginPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoginPressedImpl implements LoginPressed {
  const _$LoginPressedImpl();

  @override
  String toString() {
    return 'LoginFormEvent.loginPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailId) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() obscureText,
    required TResult Function() loginPressed,
  }) {
    return loginPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailId)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function()? obscureText,
    TResult? Function()? loginPressed,
  }) {
    return loginPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailId)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? obscureText,
    TResult Function()? loginPressed,
    required TResult orElse(),
  }) {
    if (loginPressed != null) {
      return loginPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(LoginPressed value) loginPressed,
  }) {
    return loginPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(LoginPressed value)? loginPressed,
  }) {
    return loginPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(LoginPressed value)? loginPressed,
    required TResult orElse(),
  }) {
    if (loginPressed != null) {
      return loginPressed(this);
    }
    return orElse();
  }
}

abstract class LoginPressed implements LoginFormEvent {
  const factory LoginPressed() = _$LoginPressedImpl;
}

/// @nodoc
mixin _$LoginFormState {
  EmailAddress get emailId => throw _privateConstructorUsedError;
  Password get password => throw _privateConstructorUsedError;
  bool get isObscure => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  String get selectedCountrycode => throw _privateConstructorUsedError;
  OTPText get enteredOTP => throw _privateConstructorUsedError;
  int get secondsRemaining => throw _privateConstructorUsedError;
  FocusNode get mobileNumberFocusNode => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, Account>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;
  Option<Either<AuthFailure, Account>> get verificationFailureOrSuccessOption =>
      throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get resendFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginFormStateCopyWith<LoginFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormStateCopyWith<$Res> {
  factory $LoginFormStateCopyWith(
          LoginFormState value, $Res Function(LoginFormState) then) =
      _$LoginFormStateCopyWithImpl<$Res, LoginFormState>;
  @useResult
  $Res call(
      {EmailAddress emailId,
      Password password,
      bool isObscure,
      bool showErrorMessages,
      bool isSubmitting,
      String selectedCountrycode,
      OTPText enteredOTP,
      int secondsRemaining,
      FocusNode mobileNumberFocusNode,
      Option<Either<AuthFailure, Account>> authFailureOrSuccessOption,
      Option<Either<AuthFailure, Account>> verificationFailureOrSuccessOption,
      Option<Either<AuthFailure, String>> resendFailureOrSuccessOption});
}

/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res, $Val extends LoginFormState>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailId = null,
    Object? password = null,
    Object? isObscure = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? selectedCountrycode = null,
    Object? enteredOTP = null,
    Object? secondsRemaining = null,
    Object? mobileNumberFocusNode = null,
    Object? authFailureOrSuccessOption = null,
    Object? verificationFailureOrSuccessOption = null,
    Object? resendFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      emailId: null == emailId
          ? _value.emailId
          : emailId // ignore: cast_nullable_to_non_nullable
              as EmailAddress,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      isObscure: null == isObscure
          ? _value.isObscure
          : isObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedCountrycode: null == selectedCountrycode
          ? _value.selectedCountrycode
          : selectedCountrycode // ignore: cast_nullable_to_non_nullable
              as String,
      enteredOTP: null == enteredOTP
          ? _value.enteredOTP
          : enteredOTP // ignore: cast_nullable_to_non_nullable
              as OTPText,
      secondsRemaining: null == secondsRemaining
          ? _value.secondsRemaining
          : secondsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      mobileNumberFocusNode: null == mobileNumberFocusNode
          ? _value.mobileNumberFocusNode
          : mobileNumberFocusNode // ignore: cast_nullable_to_non_nullable
              as FocusNode,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Account>>,
      verificationFailureOrSuccessOption: null ==
              verificationFailureOrSuccessOption
          ? _value.verificationFailureOrSuccessOption
          : verificationFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Account>>,
      resendFailureOrSuccessOption: null == resendFailureOrSuccessOption
          ? _value.resendFailureOrSuccessOption
          : resendFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginFormStateImplCopyWith<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  factory _$$LoginFormStateImplCopyWith(_$LoginFormStateImpl value,
          $Res Function(_$LoginFormStateImpl) then) =
      __$$LoginFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {EmailAddress emailId,
      Password password,
      bool isObscure,
      bool showErrorMessages,
      bool isSubmitting,
      String selectedCountrycode,
      OTPText enteredOTP,
      int secondsRemaining,
      FocusNode mobileNumberFocusNode,
      Option<Either<AuthFailure, Account>> authFailureOrSuccessOption,
      Option<Either<AuthFailure, Account>> verificationFailureOrSuccessOption,
      Option<Either<AuthFailure, String>> resendFailureOrSuccessOption});
}

/// @nodoc
class __$$LoginFormStateImplCopyWithImpl<$Res>
    extends _$LoginFormStateCopyWithImpl<$Res, _$LoginFormStateImpl>
    implements _$$LoginFormStateImplCopyWith<$Res> {
  __$$LoginFormStateImplCopyWithImpl(
      _$LoginFormStateImpl _value, $Res Function(_$LoginFormStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailId = null,
    Object? password = null,
    Object? isObscure = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? selectedCountrycode = null,
    Object? enteredOTP = null,
    Object? secondsRemaining = null,
    Object? mobileNumberFocusNode = null,
    Object? authFailureOrSuccessOption = null,
    Object? verificationFailureOrSuccessOption = null,
    Object? resendFailureOrSuccessOption = null,
  }) {
    return _then(_$LoginFormStateImpl(
      emailId: null == emailId
          ? _value.emailId
          : emailId // ignore: cast_nullable_to_non_nullable
              as EmailAddress,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      isObscure: null == isObscure
          ? _value.isObscure
          : isObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedCountrycode: null == selectedCountrycode
          ? _value.selectedCountrycode
          : selectedCountrycode // ignore: cast_nullable_to_non_nullable
              as String,
      enteredOTP: null == enteredOTP
          ? _value.enteredOTP
          : enteredOTP // ignore: cast_nullable_to_non_nullable
              as OTPText,
      secondsRemaining: null == secondsRemaining
          ? _value.secondsRemaining
          : secondsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      mobileNumberFocusNode: null == mobileNumberFocusNode
          ? _value.mobileNumberFocusNode
          : mobileNumberFocusNode // ignore: cast_nullable_to_non_nullable
              as FocusNode,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Account>>,
      verificationFailureOrSuccessOption: null ==
              verificationFailureOrSuccessOption
          ? _value.verificationFailureOrSuccessOption
          : verificationFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, Account>>,
      resendFailureOrSuccessOption: null == resendFailureOrSuccessOption
          ? _value.resendFailureOrSuccessOption
          : resendFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ));
  }
}

/// @nodoc

class _$LoginFormStateImpl implements _LoginFormState {
  const _$LoginFormStateImpl(
      {required this.emailId,
      required this.password,
      required this.isObscure,
      required this.showErrorMessages,
      required this.isSubmitting,
      required this.selectedCountrycode,
      required this.enteredOTP,
      required this.secondsRemaining,
      required this.mobileNumberFocusNode,
      required this.authFailureOrSuccessOption,
      required this.verificationFailureOrSuccessOption,
      required this.resendFailureOrSuccessOption});

  @override
  final EmailAddress emailId;
  @override
  final Password password;
  @override
  final bool isObscure;
  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final String selectedCountrycode;
  @override
  final OTPText enteredOTP;
  @override
  final int secondsRemaining;
  @override
  final FocusNode mobileNumberFocusNode;
  @override
  final Option<Either<AuthFailure, Account>> authFailureOrSuccessOption;
  @override
  final Option<Either<AuthFailure, Account>> verificationFailureOrSuccessOption;
  @override
  final Option<Either<AuthFailure, String>> resendFailureOrSuccessOption;

  @override
  String toString() {
    return 'LoginFormState(emailId: $emailId, password: $password, isObscure: $isObscure, showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, selectedCountrycode: $selectedCountrycode, enteredOTP: $enteredOTP, secondsRemaining: $secondsRemaining, mobileNumberFocusNode: $mobileNumberFocusNode, authFailureOrSuccessOption: $authFailureOrSuccessOption, verificationFailureOrSuccessOption: $verificationFailureOrSuccessOption, resendFailureOrSuccessOption: $resendFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFormStateImpl &&
            (identical(other.emailId, emailId) || other.emailId == emailId) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isObscure, isObscure) ||
                other.isObscure == isObscure) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.selectedCountrycode, selectedCountrycode) ||
                other.selectedCountrycode == selectedCountrycode) &&
            (identical(other.enteredOTP, enteredOTP) ||
                other.enteredOTP == enteredOTP) &&
            (identical(other.secondsRemaining, secondsRemaining) ||
                other.secondsRemaining == secondsRemaining) &&
            (identical(other.mobileNumberFocusNode, mobileNumberFocusNode) ||
                other.mobileNumberFocusNode == mobileNumberFocusNode) &&
            (identical(other.authFailureOrSuccessOption,
                    authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption) &&
            (identical(other.verificationFailureOrSuccessOption,
                    verificationFailureOrSuccessOption) ||
                other.verificationFailureOrSuccessOption ==
                    verificationFailureOrSuccessOption) &&
            (identical(other.resendFailureOrSuccessOption,
                    resendFailureOrSuccessOption) ||
                other.resendFailureOrSuccessOption ==
                    resendFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      emailId,
      password,
      isObscure,
      showErrorMessages,
      isSubmitting,
      selectedCountrycode,
      enteredOTP,
      secondsRemaining,
      mobileNumberFocusNode,
      authFailureOrSuccessOption,
      verificationFailureOrSuccessOption,
      resendFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFormStateImplCopyWith<_$LoginFormStateImpl> get copyWith =>
      __$$LoginFormStateImplCopyWithImpl<_$LoginFormStateImpl>(
          this, _$identity);
}

abstract class _LoginFormState implements LoginFormState {
  const factory _LoginFormState(
      {required final EmailAddress emailId,
      required final Password password,
      required final bool isObscure,
      required final bool showErrorMessages,
      required final bool isSubmitting,
      required final String selectedCountrycode,
      required final OTPText enteredOTP,
      required final int secondsRemaining,
      required final FocusNode mobileNumberFocusNode,
      required final Option<Either<AuthFailure, Account>>
          authFailureOrSuccessOption,
      required final Option<Either<AuthFailure, Account>>
          verificationFailureOrSuccessOption,
      required final Option<Either<AuthFailure, String>>
          resendFailureOrSuccessOption}) = _$LoginFormStateImpl;

  @override
  EmailAddress get emailId;
  @override
  Password get password;
  @override
  bool get isObscure;
  @override
  bool get showErrorMessages;
  @override
  bool get isSubmitting;
  @override
  String get selectedCountrycode;
  @override
  OTPText get enteredOTP;
  @override
  int get secondsRemaining;
  @override
  FocusNode get mobileNumberFocusNode;
  @override
  Option<Either<AuthFailure, Account>> get authFailureOrSuccessOption;
  @override
  Option<Either<AuthFailure, Account>> get verificationFailureOrSuccessOption;
  @override
  Option<Either<AuthFailure, String>> get resendFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$LoginFormStateImplCopyWith<_$LoginFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
