// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ForgotPasswordEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordEventCopyWith<$Res> {
  factory $ForgotPasswordEventCopyWith(
          ForgotPasswordEvent value, $Res Function(ForgotPasswordEvent) then) =
      _$ForgotPasswordEventCopyWithImpl<$Res, ForgotPasswordEvent>;
}

/// @nodoc
class _$ForgotPasswordEventCopyWithImpl<$Res, $Val extends ForgotPasswordEvent>
    implements $ForgotPasswordEventCopyWith<$Res> {
  _$ForgotPasswordEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MobileNumberChangedImplCopyWith<$Res> {
  factory _$$MobileNumberChangedImplCopyWith(_$MobileNumberChangedImpl value,
          $Res Function(_$MobileNumberChangedImpl) then) =
      __$$MobileNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String mobileNumber});
}

/// @nodoc
class __$$MobileNumberChangedImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$MobileNumberChangedImpl>
    implements _$$MobileNumberChangedImplCopyWith<$Res> {
  __$$MobileNumberChangedImplCopyWithImpl(_$MobileNumberChangedImpl _value,
      $Res Function(_$MobileNumberChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobileNumber = null,
  }) {
    return _then(_$MobileNumberChangedImpl(
      null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MobileNumberChangedImpl implements MobileNumberChanged {
  const _$MobileNumberChangedImpl(this.mobileNumber);

  @override
  final String mobileNumber;

  @override
  String toString() {
    return 'ForgotPasswordEvent.mobileNumberChanged(mobileNumber: $mobileNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobileNumberChangedImpl &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mobileNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MobileNumberChangedImplCopyWith<_$MobileNumberChangedImpl> get copyWith =>
      __$$MobileNumberChangedImplCopyWithImpl<_$MobileNumberChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return mobileNumberChanged(mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return mobileNumberChanged?.call(mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (mobileNumberChanged != null) {
      return mobileNumberChanged(mobileNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return mobileNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return mobileNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (mobileNumberChanged != null) {
      return mobileNumberChanged(this);
    }
    return orElse();
  }
}

abstract class MobileNumberChanged implements ForgotPasswordEvent {
  const factory MobileNumberChanged(final String mobileNumber) =
      _$MobileNumberChangedImpl;

  String get mobileNumber;
  @JsonKey(ignore: true)
  _$$MobileNumberChangedImplCopyWith<_$MobileNumberChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmailChangedImplCopyWith<$Res> {
  factory _$$EmailChangedImplCopyWith(
          _$EmailChangedImpl value, $Res Function(_$EmailChangedImpl) then) =
      __$$EmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailChangedImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$EmailChangedImpl>
    implements _$$EmailChangedImplCopyWith<$Res> {
  __$$EmailChangedImplCopyWithImpl(
      _$EmailChangedImpl _value, $Res Function(_$EmailChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailChangedImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailChangedImpl implements EmailChanged {
  const _$EmailChangedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordEvent.emailChanged(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailChangedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      __$$EmailChangedImplCopyWithImpl<_$EmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return emailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return emailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return emailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return emailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(this);
    }
    return orElse();
  }
}

abstract class EmailChanged implements ForgotPasswordEvent {
  const factory EmailChanged(final String email) = _$EmailChangedImpl;

  String get email;
  @JsonKey(ignore: true)
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectCountryCodeImplCopyWith<$Res> {
  factory _$$SelectCountryCodeImplCopyWith(_$SelectCountryCodeImpl value,
          $Res Function(_$SelectCountryCodeImpl) then) =
      __$$SelectCountryCodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String counryCode});
}

/// @nodoc
class __$$SelectCountryCodeImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$SelectCountryCodeImpl>
    implements _$$SelectCountryCodeImplCopyWith<$Res> {
  __$$SelectCountryCodeImplCopyWithImpl(_$SelectCountryCodeImpl _value,
      $Res Function(_$SelectCountryCodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? counryCode = null,
  }) {
    return _then(_$SelectCountryCodeImpl(
      null == counryCode
          ? _value.counryCode
          : counryCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SelectCountryCodeImpl implements SelectCountryCode {
  const _$SelectCountryCodeImpl(this.counryCode);

  @override
  final String counryCode;

  @override
  String toString() {
    return 'ForgotPasswordEvent.selectCountryCode(counryCode: $counryCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectCountryCodeImpl &&
            (identical(other.counryCode, counryCode) ||
                other.counryCode == counryCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, counryCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectCountryCodeImplCopyWith<_$SelectCountryCodeImpl> get copyWith =>
      __$$SelectCountryCodeImplCopyWithImpl<_$SelectCountryCodeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return selectCountryCode(counryCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return selectCountryCode?.call(counryCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (selectCountryCode != null) {
      return selectCountryCode(counryCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return selectCountryCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return selectCountryCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (selectCountryCode != null) {
      return selectCountryCode(this);
    }
    return orElse();
  }
}

abstract class SelectCountryCode implements ForgotPasswordEvent {
  const factory SelectCountryCode(final String counryCode) =
      _$SelectCountryCodeImpl;

  String get counryCode;
  @JsonKey(ignore: true)
  _$$SelectCountryCodeImplCopyWith<_$SelectCountryCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendOtpPressedImplCopyWith<$Res> {
  factory _$$SendOtpPressedImplCopyWith(_$SendOtpPressedImpl value,
          $Res Function(_$SendOtpPressedImpl) then) =
      __$$SendOtpPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SendOtpPressedImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$SendOtpPressedImpl>
    implements _$$SendOtpPressedImplCopyWith<$Res> {
  __$$SendOtpPressedImplCopyWithImpl(
      _$SendOtpPressedImpl _value, $Res Function(_$SendOtpPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SendOtpPressedImpl implements SendOtpPressed {
  const _$SendOtpPressedImpl();

  @override
  String toString() {
    return 'ForgotPasswordEvent.sendOtpPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SendOtpPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return sendOtpPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return sendOtpPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (sendOtpPressed != null) {
      return sendOtpPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return sendOtpPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return sendOtpPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (sendOtpPressed != null) {
      return sendOtpPressed(this);
    }
    return orElse();
  }
}

abstract class SendOtpPressed implements ForgotPasswordEvent {
  const factory SendOtpPressed() = _$SendOtpPressedImpl;
}

/// @nodoc
abstract class _$$NextPageImplCopyWith<$Res> {
  factory _$$NextPageImplCopyWith(
          _$NextPageImpl value, $Res Function(_$NextPageImpl) then) =
      __$$NextPageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int page});
}

/// @nodoc
class __$$NextPageImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$NextPageImpl>
    implements _$$NextPageImplCopyWith<$Res> {
  __$$NextPageImplCopyWithImpl(
      _$NextPageImpl _value, $Res Function(_$NextPageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
  }) {
    return _then(_$NextPageImpl(
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$NextPageImpl implements NextPage {
  const _$NextPageImpl(this.page);

  @override
  final int page;

  @override
  String toString() {
    return 'ForgotPasswordEvent.nextPage(page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NextPageImpl &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NextPageImplCopyWith<_$NextPageImpl> get copyWith =>
      __$$NextPageImplCopyWithImpl<_$NextPageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return nextPage(page);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return nextPage?.call(page);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (nextPage != null) {
      return nextPage(page);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return nextPage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return nextPage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (nextPage != null) {
      return nextPage(this);
    }
    return orElse();
  }
}

abstract class NextPage implements ForgotPasswordEvent {
  const factory NextPage(final int page) = _$NextPageImpl;

  int get page;
  @JsonKey(ignore: true)
  _$$NextPageImplCopyWith<_$NextPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeOTPImplCopyWith<$Res> {
  factory _$$ChangeOTPImplCopyWith(
          _$ChangeOTPImpl value, $Res Function(_$ChangeOTPImpl) then) =
      __$$ChangeOTPImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String otp});
}

/// @nodoc
class __$$ChangeOTPImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$ChangeOTPImpl>
    implements _$$ChangeOTPImplCopyWith<$Res> {
  __$$ChangeOTPImplCopyWithImpl(
      _$ChangeOTPImpl _value, $Res Function(_$ChangeOTPImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = null,
  }) {
    return _then(_$ChangeOTPImpl(
      null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ChangeOTPImpl implements ChangeOTP {
  const _$ChangeOTPImpl(this.otp);

  @override
  final String otp;

  @override
  String toString() {
    return 'ForgotPasswordEvent.changeOTP(otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeOTPImpl &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, otp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeOTPImplCopyWith<_$ChangeOTPImpl> get copyWith =>
      __$$ChangeOTPImplCopyWithImpl<_$ChangeOTPImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return changeOTP(otp);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return changeOTP?.call(otp);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (changeOTP != null) {
      return changeOTP(otp);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return changeOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return changeOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (changeOTP != null) {
      return changeOTP(this);
    }
    return orElse();
  }
}

abstract class ChangeOTP implements ForgotPasswordEvent {
  const factory ChangeOTP(final String otp) = _$ChangeOTPImpl;

  String get otp;
  @JsonKey(ignore: true)
  _$$ChangeOTPImplCopyWith<_$ChangeOTPImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StartCountdownImplCopyWith<$Res> {
  factory _$$StartCountdownImplCopyWith(_$StartCountdownImpl value,
          $Res Function(_$StartCountdownImpl) then) =
      __$$StartCountdownImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartCountdownImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$StartCountdownImpl>
    implements _$$StartCountdownImplCopyWith<$Res> {
  __$$StartCountdownImplCopyWithImpl(
      _$StartCountdownImpl _value, $Res Function(_$StartCountdownImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartCountdownImpl implements StartCountdown {
  const _$StartCountdownImpl();

  @override
  String toString() {
    return 'ForgotPasswordEvent.startCountdown()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartCountdownImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return startCountdown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return startCountdown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (startCountdown != null) {
      return startCountdown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return startCountdown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return startCountdown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (startCountdown != null) {
      return startCountdown(this);
    }
    return orElse();
  }
}

abstract class StartCountdown implements ForgotPasswordEvent {
  const factory StartCountdown() = _$StartCountdownImpl;
}

/// @nodoc
abstract class _$$DecrementTimerImplCopyWith<$Res> {
  factory _$$DecrementTimerImplCopyWith(_$DecrementTimerImpl value,
          $Res Function(_$DecrementTimerImpl) then) =
      __$$DecrementTimerImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DecrementTimerImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$DecrementTimerImpl>
    implements _$$DecrementTimerImplCopyWith<$Res> {
  __$$DecrementTimerImplCopyWithImpl(
      _$DecrementTimerImpl _value, $Res Function(_$DecrementTimerImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$DecrementTimerImpl implements DecrementTimer {
  const _$DecrementTimerImpl();

  @override
  String toString() {
    return 'ForgotPasswordEvent.decrementTimer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DecrementTimerImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return decrementTimer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return decrementTimer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (decrementTimer != null) {
      return decrementTimer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return decrementTimer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return decrementTimer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (decrementTimer != null) {
      return decrementTimer(this);
    }
    return orElse();
  }
}

abstract class DecrementTimer implements ForgotPasswordEvent {
  const factory DecrementTimer() = _$DecrementTimerImpl;
}

/// @nodoc
abstract class _$$ResendOtpImplCopyWith<$Res> {
  factory _$$ResendOtpImplCopyWith(
          _$ResendOtpImpl value, $Res Function(_$ResendOtpImpl) then) =
      __$$ResendOtpImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendOtpImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$ResendOtpImpl>
    implements _$$ResendOtpImplCopyWith<$Res> {
  __$$ResendOtpImplCopyWithImpl(
      _$ResendOtpImpl _value, $Res Function(_$ResendOtpImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ResendOtpImpl implements ResendOtp {
  const _$ResendOtpImpl();

  @override
  String toString() {
    return 'ForgotPasswordEvent.resendOtp()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResendOtpImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return resendOtp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return resendOtp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return resendOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return resendOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(this);
    }
    return orElse();
  }
}

abstract class ResendOtp implements ForgotPasswordEvent {
  const factory ResendOtp() = _$ResendOtpImpl;
}

/// @nodoc
abstract class _$$VerifyOtpImplCopyWith<$Res> {
  factory _$$VerifyOtpImplCopyWith(
          _$VerifyOtpImpl value, $Res Function(_$VerifyOtpImpl) then) =
      __$$VerifyOtpImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifyOtpImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$VerifyOtpImpl>
    implements _$$VerifyOtpImplCopyWith<$Res> {
  __$$VerifyOtpImplCopyWithImpl(
      _$VerifyOtpImpl _value, $Res Function(_$VerifyOtpImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$VerifyOtpImpl implements VerifyOtp {
  const _$VerifyOtpImpl();

  @override
  String toString() {
    return 'ForgotPasswordEvent.verifyOtp()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifyOtpImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return verifyOtp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return verifyOtp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return verifyOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return verifyOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(this);
    }
    return orElse();
  }
}

abstract class VerifyOtp implements ForgotPasswordEvent {
  const factory VerifyOtp() = _$VerifyOtpImpl;
}

/// @nodoc
abstract class _$$NewPasswordChangedImplCopyWith<$Res> {
  factory _$$NewPasswordChangedImplCopyWith(_$NewPasswordChangedImpl value,
          $Res Function(_$NewPasswordChangedImpl) then) =
      __$$NewPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String newPassword});
}

/// @nodoc
class __$$NewPasswordChangedImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$NewPasswordChangedImpl>
    implements _$$NewPasswordChangedImplCopyWith<$Res> {
  __$$NewPasswordChangedImplCopyWithImpl(_$NewPasswordChangedImpl _value,
      $Res Function(_$NewPasswordChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPassword = null,
  }) {
    return _then(_$NewPasswordChangedImpl(
      null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$NewPasswordChangedImpl implements NewPasswordChanged {
  const _$NewPasswordChangedImpl(this.newPassword);

  @override
  final String newPassword;

  @override
  String toString() {
    return 'ForgotPasswordEvent.newPasswordChanged(newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewPasswordChangedImpl &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewPasswordChangedImplCopyWith<_$NewPasswordChangedImpl> get copyWith =>
      __$$NewPasswordChangedImplCopyWithImpl<_$NewPasswordChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return newPasswordChanged(newPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return newPasswordChanged?.call(newPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (newPasswordChanged != null) {
      return newPasswordChanged(newPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return newPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return newPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (newPasswordChanged != null) {
      return newPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class NewPasswordChanged implements ForgotPasswordEvent {
  const factory NewPasswordChanged(final String newPassword) =
      _$NewPasswordChangedImpl;

  String get newPassword;
  @JsonKey(ignore: true)
  _$$NewPasswordChangedImplCopyWith<_$NewPasswordChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmPasswordChangedImplCopyWith<$Res> {
  factory _$$ConfirmPasswordChangedImplCopyWith(
          _$ConfirmPasswordChangedImpl value,
          $Res Function(_$ConfirmPasswordChangedImpl) then) =
      __$$ConfirmPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String confirmPassword, String newPassword});
}

/// @nodoc
class __$$ConfirmPasswordChangedImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res,
        _$ConfirmPasswordChangedImpl>
    implements _$$ConfirmPasswordChangedImplCopyWith<$Res> {
  __$$ConfirmPasswordChangedImplCopyWithImpl(
      _$ConfirmPasswordChangedImpl _value,
      $Res Function(_$ConfirmPasswordChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confirmPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_$ConfirmPasswordChangedImpl(
      null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
      null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConfirmPasswordChangedImpl implements ConfirmPasswordChanged {
  const _$ConfirmPasswordChangedImpl(this.confirmPassword, this.newPassword);

  @override
  final String confirmPassword;
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ForgotPasswordEvent.confirmPasswordChanged(confirmPassword: $confirmPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmPasswordChangedImpl &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confirmPassword, newPassword);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmPasswordChangedImplCopyWith<_$ConfirmPasswordChangedImpl>
      get copyWith => __$$ConfirmPasswordChangedImplCopyWithImpl<
          _$ConfirmPasswordChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return confirmPasswordChanged(confirmPassword, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return confirmPasswordChanged?.call(confirmPassword, newPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (confirmPasswordChanged != null) {
      return confirmPasswordChanged(confirmPassword, newPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return confirmPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return confirmPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (confirmPasswordChanged != null) {
      return confirmPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class ConfirmPasswordChanged implements ForgotPasswordEvent {
  const factory ConfirmPasswordChanged(
          final String confirmPassword, final String newPassword) =
      _$ConfirmPasswordChangedImpl;

  String get confirmPassword;
  String get newPassword;
  @JsonKey(ignore: true)
  _$$ConfirmPasswordChangedImplCopyWith<_$ConfirmPasswordChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ObscureTextImplCopyWith<$Res> {
  factory _$$ObscureTextImplCopyWith(
          _$ObscureTextImpl value, $Res Function(_$ObscureTextImpl) then) =
      __$$ObscureTextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int field});
}

/// @nodoc
class __$$ObscureTextImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$ObscureTextImpl>
    implements _$$ObscureTextImplCopyWith<$Res> {
  __$$ObscureTextImplCopyWithImpl(
      _$ObscureTextImpl _value, $Res Function(_$ObscureTextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = null,
  }) {
    return _then(_$ObscureTextImpl(
      null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ObscureTextImpl implements ObscureText {
  const _$ObscureTextImpl(this.field);

  @override
  final int field;

  @override
  String toString() {
    return 'ForgotPasswordEvent.obscureText(field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ObscureTextImpl &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ObscureTextImplCopyWith<_$ObscureTextImpl> get copyWith =>
      __$$ObscureTextImplCopyWithImpl<_$ObscureTextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return obscureText(field);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return obscureText?.call(field);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (obscureText != null) {
      return obscureText(field);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return obscureText(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return obscureText?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (obscureText != null) {
      return obscureText(this);
    }
    return orElse();
  }
}

abstract class ObscureText implements ForgotPasswordEvent {
  const factory ObscureText(final int field) = _$ObscureTextImpl;

  int get field;
  @JsonKey(ignore: true)
  _$$ObscureTextImplCopyWith<_$ObscureTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveNewPasswordImplCopyWith<$Res> {
  factory _$$SaveNewPasswordImplCopyWith(_$SaveNewPasswordImpl value,
          $Res Function(_$SaveNewPasswordImpl) then) =
      __$$SaveNewPasswordImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SaveNewPasswordImplCopyWithImpl<$Res>
    extends _$ForgotPasswordEventCopyWithImpl<$Res, _$SaveNewPasswordImpl>
    implements _$$SaveNewPasswordImplCopyWith<$Res> {
  __$$SaveNewPasswordImplCopyWithImpl(
      _$SaveNewPasswordImpl _value, $Res Function(_$SaveNewPasswordImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SaveNewPasswordImpl implements SaveNewPassword {
  const _$SaveNewPasswordImpl();

  @override
  String toString() {
    return 'ForgotPasswordEvent.saveNewPassword()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SaveNewPasswordImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String mobileNumber) mobileNumberChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String counryCode) selectCountryCode,
    required TResult Function() sendOtpPressed,
    required TResult Function(int page) nextPage,
    required TResult Function(String otp) changeOTP,
    required TResult Function() startCountdown,
    required TResult Function() decrementTimer,
    required TResult Function() resendOtp,
    required TResult Function() verifyOtp,
    required TResult Function(String newPassword) newPasswordChanged,
    required TResult Function(String confirmPassword, String newPassword)
        confirmPasswordChanged,
    required TResult Function(int field) obscureText,
    required TResult Function() saveNewPassword,
  }) {
    return saveNewPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String mobileNumber)? mobileNumberChanged,
    TResult? Function(String email)? emailChanged,
    TResult? Function(String counryCode)? selectCountryCode,
    TResult? Function()? sendOtpPressed,
    TResult? Function(int page)? nextPage,
    TResult? Function(String otp)? changeOTP,
    TResult? Function()? startCountdown,
    TResult? Function()? decrementTimer,
    TResult? Function()? resendOtp,
    TResult? Function()? verifyOtp,
    TResult? Function(String newPassword)? newPasswordChanged,
    TResult? Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult? Function(int field)? obscureText,
    TResult? Function()? saveNewPassword,
  }) {
    return saveNewPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String mobileNumber)? mobileNumberChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String counryCode)? selectCountryCode,
    TResult Function()? sendOtpPressed,
    TResult Function(int page)? nextPage,
    TResult Function(String otp)? changeOTP,
    TResult Function()? startCountdown,
    TResult Function()? decrementTimer,
    TResult Function()? resendOtp,
    TResult Function()? verifyOtp,
    TResult Function(String newPassword)? newPasswordChanged,
    TResult Function(String confirmPassword, String newPassword)?
        confirmPasswordChanged,
    TResult Function(int field)? obscureText,
    TResult Function()? saveNewPassword,
    required TResult orElse(),
  }) {
    if (saveNewPassword != null) {
      return saveNewPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MobileNumberChanged value) mobileNumberChanged,
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(SelectCountryCode value) selectCountryCode,
    required TResult Function(SendOtpPressed value) sendOtpPressed,
    required TResult Function(NextPage value) nextPage,
    required TResult Function(ChangeOTP value) changeOTP,
    required TResult Function(StartCountdown value) startCountdown,
    required TResult Function(DecrementTimer value) decrementTimer,
    required TResult Function(ResendOtp value) resendOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(NewPasswordChanged value) newPasswordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(ObscureText value) obscureText,
    required TResult Function(SaveNewPassword value) saveNewPassword,
  }) {
    return saveNewPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(SelectCountryCode value)? selectCountryCode,
    TResult? Function(SendOtpPressed value)? sendOtpPressed,
    TResult? Function(NextPage value)? nextPage,
    TResult? Function(ChangeOTP value)? changeOTP,
    TResult? Function(StartCountdown value)? startCountdown,
    TResult? Function(DecrementTimer value)? decrementTimer,
    TResult? Function(ResendOtp value)? resendOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(NewPasswordChanged value)? newPasswordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(ObscureText value)? obscureText,
    TResult? Function(SaveNewPassword value)? saveNewPassword,
  }) {
    return saveNewPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MobileNumberChanged value)? mobileNumberChanged,
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(SelectCountryCode value)? selectCountryCode,
    TResult Function(SendOtpPressed value)? sendOtpPressed,
    TResult Function(NextPage value)? nextPage,
    TResult Function(ChangeOTP value)? changeOTP,
    TResult Function(StartCountdown value)? startCountdown,
    TResult Function(DecrementTimer value)? decrementTimer,
    TResult Function(ResendOtp value)? resendOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(NewPasswordChanged value)? newPasswordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(ObscureText value)? obscureText,
    TResult Function(SaveNewPassword value)? saveNewPassword,
    required TResult orElse(),
  }) {
    if (saveNewPassword != null) {
      return saveNewPassword(this);
    }
    return orElse();
  }
}

abstract class SaveNewPassword implements ForgotPasswordEvent {
  const factory SaveNewPassword() = _$SaveNewPasswordImpl;
}

/// @nodoc
mixin _$ForgotPasswordState {
  bool get isSubmitting => throw _privateConstructorUsedError;
  int get currentView => throw _privateConstructorUsedError;

  /// >>>>>>>>>>>>>>>>>>>> FOR FORGOT PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<
  MobileNumber get mobileNumber => throw _privateConstructorUsedError;
  EmailAddress get emailAddress => throw _privateConstructorUsedError;
  String get selectedCountrycode => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  /// >>>>>>>>>>>>>>>>>>>> FOR OTP SCREEN <<<<<<<<<<<<<<<<<<<<
  OTPText get enteredOTP => throw _privateConstructorUsedError;
  int get secondsRemaining => throw _privateConstructorUsedError;
  bool get showOtpErrorMessages => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get resendFailureOrSuccessOption =>
      throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get verifyOtpFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  /// >>>>>>>>>>>>>>>>>>>> FOR NEW PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<
  Password get newPassword => throw _privateConstructorUsedError;
  ConfirmPassword get confirmPassword => throw _privateConstructorUsedError;
  bool get isNewPassObscure => throw _privateConstructorUsedError;
  bool get isConfirmPassObscure => throw _privateConstructorUsedError;
  bool get showNewPassErrorMessages => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get saveNewPassFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ForgotPasswordStateCopyWith<ForgotPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordStateCopyWith(
          ForgotPasswordState value, $Res Function(ForgotPasswordState) then) =
      _$ForgotPasswordStateCopyWithImpl<$Res, ForgotPasswordState>;
  @useResult
  $Res call(
      {bool isSubmitting,
      int currentView,
      MobileNumber mobileNumber,
      EmailAddress emailAddress,
      String selectedCountrycode,
      bool showErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
      OTPText enteredOTP,
      int secondsRemaining,
      bool showOtpErrorMessages,
      Option<Either<AuthFailure, String>> resendFailureOrSuccessOption,
      Option<Either<AuthFailure, String>> verifyOtpFailureOrSuccessOption,
      Password newPassword,
      ConfirmPassword confirmPassword,
      bool isNewPassObscure,
      bool isConfirmPassObscure,
      bool showNewPassErrorMessages,
      Option<Either<AuthFailure, String>> saveNewPassFailureOrSuccessOption});
}

/// @nodoc
class _$ForgotPasswordStateCopyWithImpl<$Res, $Val extends ForgotPasswordState>
    implements $ForgotPasswordStateCopyWith<$Res> {
  _$ForgotPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? currentView = null,
    Object? mobileNumber = null,
    Object? emailAddress = null,
    Object? selectedCountrycode = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
    Object? enteredOTP = null,
    Object? secondsRemaining = null,
    Object? showOtpErrorMessages = null,
    Object? resendFailureOrSuccessOption = null,
    Object? verifyOtpFailureOrSuccessOption = null,
    Object? newPassword = null,
    Object? confirmPassword = null,
    Object? isNewPassObscure = null,
    Object? isConfirmPassObscure = null,
    Object? showNewPassErrorMessages = null,
    Object? saveNewPassFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      currentView: null == currentView
          ? _value.currentView
          : currentView // ignore: cast_nullable_to_non_nullable
              as int,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as MobileNumber,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as EmailAddress,
      selectedCountrycode: null == selectedCountrycode
          ? _value.selectedCountrycode
          : selectedCountrycode // ignore: cast_nullable_to_non_nullable
              as String,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      enteredOTP: null == enteredOTP
          ? _value.enteredOTP
          : enteredOTP // ignore: cast_nullable_to_non_nullable
              as OTPText,
      secondsRemaining: null == secondsRemaining
          ? _value.secondsRemaining
          : secondsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      showOtpErrorMessages: null == showOtpErrorMessages
          ? _value.showOtpErrorMessages
          : showOtpErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      resendFailureOrSuccessOption: null == resendFailureOrSuccessOption
          ? _value.resendFailureOrSuccessOption
          : resendFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      verifyOtpFailureOrSuccessOption: null == verifyOtpFailureOrSuccessOption
          ? _value.verifyOtpFailureOrSuccessOption
          : verifyOtpFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as Password,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as ConfirmPassword,
      isNewPassObscure: null == isNewPassObscure
          ? _value.isNewPassObscure
          : isNewPassObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmPassObscure: null == isConfirmPassObscure
          ? _value.isConfirmPassObscure
          : isConfirmPassObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      showNewPassErrorMessages: null == showNewPassErrorMessages
          ? _value.showNewPassErrorMessages
          : showNewPassErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      saveNewPassFailureOrSuccessOption: null ==
              saveNewPassFailureOrSuccessOption
          ? _value.saveNewPassFailureOrSuccessOption
          : saveNewPassFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForgotPasswordStateImplCopyWith<$Res>
    implements $ForgotPasswordStateCopyWith<$Res> {
  factory _$$ForgotPasswordStateImplCopyWith(_$ForgotPasswordStateImpl value,
          $Res Function(_$ForgotPasswordStateImpl) then) =
      __$$ForgotPasswordStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isSubmitting,
      int currentView,
      MobileNumber mobileNumber,
      EmailAddress emailAddress,
      String selectedCountrycode,
      bool showErrorMessages,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption,
      OTPText enteredOTP,
      int secondsRemaining,
      bool showOtpErrorMessages,
      Option<Either<AuthFailure, String>> resendFailureOrSuccessOption,
      Option<Either<AuthFailure, String>> verifyOtpFailureOrSuccessOption,
      Password newPassword,
      ConfirmPassword confirmPassword,
      bool isNewPassObscure,
      bool isConfirmPassObscure,
      bool showNewPassErrorMessages,
      Option<Either<AuthFailure, String>> saveNewPassFailureOrSuccessOption});
}

/// @nodoc
class __$$ForgotPasswordStateImplCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res, _$ForgotPasswordStateImpl>
    implements _$$ForgotPasswordStateImplCopyWith<$Res> {
  __$$ForgotPasswordStateImplCopyWithImpl(_$ForgotPasswordStateImpl _value,
      $Res Function(_$ForgotPasswordStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSubmitting = null,
    Object? currentView = null,
    Object? mobileNumber = null,
    Object? emailAddress = null,
    Object? selectedCountrycode = null,
    Object? showErrorMessages = null,
    Object? authFailureOrSuccessOption = null,
    Object? enteredOTP = null,
    Object? secondsRemaining = null,
    Object? showOtpErrorMessages = null,
    Object? resendFailureOrSuccessOption = null,
    Object? verifyOtpFailureOrSuccessOption = null,
    Object? newPassword = null,
    Object? confirmPassword = null,
    Object? isNewPassObscure = null,
    Object? isConfirmPassObscure = null,
    Object? showNewPassErrorMessages = null,
    Object? saveNewPassFailureOrSuccessOption = null,
  }) {
    return _then(_$ForgotPasswordStateImpl(
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
      currentView: null == currentView
          ? _value.currentView
          : currentView // ignore: cast_nullable_to_non_nullable
              as int,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as MobileNumber,
      emailAddress: null == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as EmailAddress,
      selectedCountrycode: null == selectedCountrycode
          ? _value.selectedCountrycode
          : selectedCountrycode // ignore: cast_nullable_to_non_nullable
              as String,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      authFailureOrSuccessOption: null == authFailureOrSuccessOption
          ? _value.authFailureOrSuccessOption
          : authFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      enteredOTP: null == enteredOTP
          ? _value.enteredOTP
          : enteredOTP // ignore: cast_nullable_to_non_nullable
              as OTPText,
      secondsRemaining: null == secondsRemaining
          ? _value.secondsRemaining
          : secondsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      showOtpErrorMessages: null == showOtpErrorMessages
          ? _value.showOtpErrorMessages
          : showOtpErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      resendFailureOrSuccessOption: null == resendFailureOrSuccessOption
          ? _value.resendFailureOrSuccessOption
          : resendFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      verifyOtpFailureOrSuccessOption: null == verifyOtpFailureOrSuccessOption
          ? _value.verifyOtpFailureOrSuccessOption
          : verifyOtpFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as Password,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as ConfirmPassword,
      isNewPassObscure: null == isNewPassObscure
          ? _value.isNewPassObscure
          : isNewPassObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      isConfirmPassObscure: null == isConfirmPassObscure
          ? _value.isConfirmPassObscure
          : isConfirmPassObscure // ignore: cast_nullable_to_non_nullable
              as bool,
      showNewPassErrorMessages: null == showNewPassErrorMessages
          ? _value.showNewPassErrorMessages
          : showNewPassErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      saveNewPassFailureOrSuccessOption: null ==
              saveNewPassFailureOrSuccessOption
          ? _value.saveNewPassFailureOrSuccessOption
          : saveNewPassFailureOrSuccessOption // ignore: cast_nullable_to_non_nullable
              as Option<Either<AuthFailure, String>>,
    ));
  }
}

/// @nodoc

class _$ForgotPasswordStateImpl implements _ForgotPasswordState {
  const _$ForgotPasswordStateImpl(
      {required this.isSubmitting,
      required this.currentView,
      required this.mobileNumber,
      required this.emailAddress,
      required this.selectedCountrycode,
      required this.showErrorMessages,
      required this.authFailureOrSuccessOption,
      required this.enteredOTP,
      required this.secondsRemaining,
      required this.showOtpErrorMessages,
      required this.resendFailureOrSuccessOption,
      required this.verifyOtpFailureOrSuccessOption,
      required this.newPassword,
      required this.confirmPassword,
      required this.isNewPassObscure,
      required this.isConfirmPassObscure,
      required this.showNewPassErrorMessages,
      required this.saveNewPassFailureOrSuccessOption});

  @override
  final bool isSubmitting;
  @override
  final int currentView;

  /// >>>>>>>>>>>>>>>>>>>> FOR FORGOT PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<
  @override
  final MobileNumber mobileNumber;
  @override
  final EmailAddress emailAddress;
  @override
  final String selectedCountrycode;
  @override
  final bool showErrorMessages;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  /// >>>>>>>>>>>>>>>>>>>> FOR OTP SCREEN <<<<<<<<<<<<<<<<<<<<
  @override
  final OTPText enteredOTP;
  @override
  final int secondsRemaining;
  @override
  final bool showOtpErrorMessages;
  @override
  final Option<Either<AuthFailure, String>> resendFailureOrSuccessOption;
  @override
  final Option<Either<AuthFailure, String>> verifyOtpFailureOrSuccessOption;

  /// >>>>>>>>>>>>>>>>>>>> FOR NEW PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<
  @override
  final Password newPassword;
  @override
  final ConfirmPassword confirmPassword;
  @override
  final bool isNewPassObscure;
  @override
  final bool isConfirmPassObscure;
  @override
  final bool showNewPassErrorMessages;
  @override
  final Option<Either<AuthFailure, String>> saveNewPassFailureOrSuccessOption;

  @override
  String toString() {
    return 'ForgotPasswordState(isSubmitting: $isSubmitting, currentView: $currentView, mobileNumber: $mobileNumber, emailAddress: $emailAddress, selectedCountrycode: $selectedCountrycode, showErrorMessages: $showErrorMessages, authFailureOrSuccessOption: $authFailureOrSuccessOption, enteredOTP: $enteredOTP, secondsRemaining: $secondsRemaining, showOtpErrorMessages: $showOtpErrorMessages, resendFailureOrSuccessOption: $resendFailureOrSuccessOption, verifyOtpFailureOrSuccessOption: $verifyOtpFailureOrSuccessOption, newPassword: $newPassword, confirmPassword: $confirmPassword, isNewPassObscure: $isNewPassObscure, isConfirmPassObscure: $isConfirmPassObscure, showNewPassErrorMessages: $showNewPassErrorMessages, saveNewPassFailureOrSuccessOption: $saveNewPassFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordStateImpl &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.currentView, currentView) ||
                other.currentView == currentView) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.selectedCountrycode, selectedCountrycode) ||
                other.selectedCountrycode == selectedCountrycode) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.authFailureOrSuccessOption, authFailureOrSuccessOption) ||
                other.authFailureOrSuccessOption ==
                    authFailureOrSuccessOption) &&
            (identical(other.enteredOTP, enteredOTP) ||
                other.enteredOTP == enteredOTP) &&
            (identical(other.secondsRemaining, secondsRemaining) ||
                other.secondsRemaining == secondsRemaining) &&
            (identical(other.showOtpErrorMessages, showOtpErrorMessages) ||
                other.showOtpErrorMessages == showOtpErrorMessages) &&
            (identical(other.resendFailureOrSuccessOption,
                    resendFailureOrSuccessOption) ||
                other.resendFailureOrSuccessOption ==
                    resendFailureOrSuccessOption) &&
            (identical(other.verifyOtpFailureOrSuccessOption,
                    verifyOtpFailureOrSuccessOption) ||
                other.verifyOtpFailureOrSuccessOption ==
                    verifyOtpFailureOrSuccessOption) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.isNewPassObscure, isNewPassObscure) ||
                other.isNewPassObscure == isNewPassObscure) &&
            (identical(other.isConfirmPassObscure, isConfirmPassObscure) ||
                other.isConfirmPassObscure == isConfirmPassObscure) &&
            (identical(other.showNewPassErrorMessages, showNewPassErrorMessages) ||
                other.showNewPassErrorMessages == showNewPassErrorMessages) &&
            (identical(other.saveNewPassFailureOrSuccessOption,
                    saveNewPassFailureOrSuccessOption) ||
                other.saveNewPassFailureOrSuccessOption ==
                    saveNewPassFailureOrSuccessOption));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isSubmitting,
      currentView,
      mobileNumber,
      emailAddress,
      selectedCountrycode,
      showErrorMessages,
      authFailureOrSuccessOption,
      enteredOTP,
      secondsRemaining,
      showOtpErrorMessages,
      resendFailureOrSuccessOption,
      verifyOtpFailureOrSuccessOption,
      newPassword,
      confirmPassword,
      isNewPassObscure,
      isConfirmPassObscure,
      showNewPassErrorMessages,
      saveNewPassFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordStateImplCopyWith<_$ForgotPasswordStateImpl> get copyWith =>
      __$$ForgotPasswordStateImplCopyWithImpl<_$ForgotPasswordStateImpl>(
          this, _$identity);
}

abstract class _ForgotPasswordState implements ForgotPasswordState {
  const factory _ForgotPasswordState(
      {required final bool isSubmitting,
      required final int currentView,
      required final MobileNumber mobileNumber,
      required final EmailAddress emailAddress,
      required final String selectedCountrycode,
      required final bool showErrorMessages,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption,
      required final OTPText enteredOTP,
      required final int secondsRemaining,
      required final bool showOtpErrorMessages,
      required final Option<Either<AuthFailure, String>>
          resendFailureOrSuccessOption,
      required final Option<Either<AuthFailure, String>>
          verifyOtpFailureOrSuccessOption,
      required final Password newPassword,
      required final ConfirmPassword confirmPassword,
      required final bool isNewPassObscure,
      required final bool isConfirmPassObscure,
      required final bool showNewPassErrorMessages,
      required final Option<Either<AuthFailure, String>>
          saveNewPassFailureOrSuccessOption}) = _$ForgotPasswordStateImpl;

  @override
  bool get isSubmitting;
  @override
  int get currentView;
  @override

  /// >>>>>>>>>>>>>>>>>>>> FOR FORGOT PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<
  MobileNumber get mobileNumber;
  @override
  EmailAddress get emailAddress;
  @override
  String get selectedCountrycode;
  @override
  bool get showErrorMessages;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override

  /// >>>>>>>>>>>>>>>>>>>> FOR OTP SCREEN <<<<<<<<<<<<<<<<<<<<
  OTPText get enteredOTP;
  @override
  int get secondsRemaining;
  @override
  bool get showOtpErrorMessages;
  @override
  Option<Either<AuthFailure, String>> get resendFailureOrSuccessOption;
  @override
  Option<Either<AuthFailure, String>> get verifyOtpFailureOrSuccessOption;
  @override

  /// >>>>>>>>>>>>>>>>>>>> FOR NEW PASSWORD SCREEN <<<<<<<<<<<<<<<<<<<<
  Password get newPassword;
  @override
  ConfirmPassword get confirmPassword;
  @override
  bool get isNewPassObscure;
  @override
  bool get isConfirmPassObscure;
  @override
  bool get showNewPassErrorMessages;
  @override
  Option<Either<AuthFailure, String>> get saveNewPassFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$ForgotPasswordStateImplCopyWith<_$ForgotPasswordStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
