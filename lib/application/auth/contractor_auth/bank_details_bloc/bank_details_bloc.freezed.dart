// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_details_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BankDetailsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankDetailsEventCopyWith<$Res> {
  factory $BankDetailsEventCopyWith(
          BankDetailsEvent value, $Res Function(BankDetailsEvent) then) =
      _$BankDetailsEventCopyWithImpl<$Res, BankDetailsEvent>;
}

/// @nodoc
class _$BankDetailsEventCopyWithImpl<$Res, $Val extends BankDetailsEvent>
    implements $BankDetailsEventCopyWith<$Res> {
  _$BankDetailsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$BankNameChangedImplCopyWith<$Res> {
  factory _$$BankNameChangedImplCopyWith(_$BankNameChangedImpl value,
          $Res Function(_$BankNameChangedImpl) then) =
      __$$BankNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String bankName});
}

/// @nodoc
class __$$BankNameChangedImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$BankNameChangedImpl>
    implements _$$BankNameChangedImplCopyWith<$Res> {
  __$$BankNameChangedImplCopyWithImpl(
      _$BankNameChangedImpl _value, $Res Function(_$BankNameChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = null,
  }) {
    return _then(_$BankNameChangedImpl(
      null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BankNameChangedImpl implements BankNameChanged {
  const _$BankNameChangedImpl(this.bankName);

  @override
  final String bankName;

  @override
  String toString() {
    return 'BankDetailsEvent.bankNameChanged(bankName: $bankName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankNameChangedImpl &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bankName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankNameChangedImplCopyWith<_$BankNameChangedImpl> get copyWith =>
      __$$BankNameChangedImplCopyWithImpl<_$BankNameChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return bankNameChanged(bankName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return bankNameChanged?.call(bankName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (bankNameChanged != null) {
      return bankNameChanged(bankName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return bankNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return bankNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (bankNameChanged != null) {
      return bankNameChanged(this);
    }
    return orElse();
  }
}

abstract class BankNameChanged implements BankDetailsEvent {
  const factory BankNameChanged(final String bankName) = _$BankNameChangedImpl;

  String get bankName;
  @JsonKey(ignore: true)
  _$$BankNameChangedImplCopyWith<_$BankNameChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountHolderNameChangedImplCopyWith<$Res> {
  factory _$$AccountHolderNameChangedImplCopyWith(
          _$AccountHolderNameChangedImpl value,
          $Res Function(_$AccountHolderNameChangedImpl) then) =
      __$$AccountHolderNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String holderName});
}

/// @nodoc
class __$$AccountHolderNameChangedImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$AccountHolderNameChangedImpl>
    implements _$$AccountHolderNameChangedImplCopyWith<$Res> {
  __$$AccountHolderNameChangedImplCopyWithImpl(
      _$AccountHolderNameChangedImpl _value,
      $Res Function(_$AccountHolderNameChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? holderName = null,
  }) {
    return _then(_$AccountHolderNameChangedImpl(
      null == holderName
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccountHolderNameChangedImpl implements AccountHolderNameChanged {
  const _$AccountHolderNameChangedImpl(this.holderName);

  @override
  final String holderName;

  @override
  String toString() {
    return 'BankDetailsEvent.accountHolderNameChanged(holderName: $holderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountHolderNameChangedImpl &&
            (identical(other.holderName, holderName) ||
                other.holderName == holderName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, holderName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountHolderNameChangedImplCopyWith<_$AccountHolderNameChangedImpl>
      get copyWith => __$$AccountHolderNameChangedImplCopyWithImpl<
          _$AccountHolderNameChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return accountHolderNameChanged(holderName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return accountHolderNameChanged?.call(holderName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (accountHolderNameChanged != null) {
      return accountHolderNameChanged(holderName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return accountHolderNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return accountHolderNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (accountHolderNameChanged != null) {
      return accountHolderNameChanged(this);
    }
    return orElse();
  }
}

abstract class AccountHolderNameChanged implements BankDetailsEvent {
  const factory AccountHolderNameChanged(final String holderName) =
      _$AccountHolderNameChangedImpl;

  String get holderName;
  @JsonKey(ignore: true)
  _$$AccountHolderNameChangedImplCopyWith<_$AccountHolderNameChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransitNumberChnagedImplCopyWith<$Res> {
  factory _$$TransitNumberChnagedImplCopyWith(_$TransitNumberChnagedImpl value,
          $Res Function(_$TransitNumberChnagedImpl) then) =
      __$$TransitNumberChnagedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String transitNumber});
}

/// @nodoc
class __$$TransitNumberChnagedImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$TransitNumberChnagedImpl>
    implements _$$TransitNumberChnagedImplCopyWith<$Res> {
  __$$TransitNumberChnagedImplCopyWithImpl(_$TransitNumberChnagedImpl _value,
      $Res Function(_$TransitNumberChnagedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transitNumber = null,
  }) {
    return _then(_$TransitNumberChnagedImpl(
      null == transitNumber
          ? _value.transitNumber
          : transitNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransitNumberChnagedImpl implements TransitNumberChnaged {
  const _$TransitNumberChnagedImpl(this.transitNumber);

  @override
  final String transitNumber;

  @override
  String toString() {
    return 'BankDetailsEvent.transitNumberChanged(transitNumber: $transitNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransitNumberChnagedImpl &&
            (identical(other.transitNumber, transitNumber) ||
                other.transitNumber == transitNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transitNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransitNumberChnagedImplCopyWith<_$TransitNumberChnagedImpl>
      get copyWith =>
          __$$TransitNumberChnagedImplCopyWithImpl<_$TransitNumberChnagedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return transitNumberChanged(transitNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return transitNumberChanged?.call(transitNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (transitNumberChanged != null) {
      return transitNumberChanged(transitNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return transitNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return transitNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (transitNumberChanged != null) {
      return transitNumberChanged(this);
    }
    return orElse();
  }
}

abstract class TransitNumberChnaged implements BankDetailsEvent {
  const factory TransitNumberChnaged(final String transitNumber) =
      _$TransitNumberChnagedImpl;

  String get transitNumber;
  @JsonKey(ignore: true)
  _$$TransitNumberChnagedImplCopyWith<_$TransitNumberChnagedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InstituteNumberChangedImplCopyWith<$Res> {
  factory _$$InstituteNumberChangedImplCopyWith(
          _$InstituteNumberChangedImpl value,
          $Res Function(_$InstituteNumberChangedImpl) then) =
      __$$InstituteNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String instituteNumber});
}

/// @nodoc
class __$$InstituteNumberChangedImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$InstituteNumberChangedImpl>
    implements _$$InstituteNumberChangedImplCopyWith<$Res> {
  __$$InstituteNumberChangedImplCopyWithImpl(
      _$InstituteNumberChangedImpl _value,
      $Res Function(_$InstituteNumberChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? instituteNumber = null,
  }) {
    return _then(_$InstituteNumberChangedImpl(
      null == instituteNumber
          ? _value.instituteNumber
          : instituteNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InstituteNumberChangedImpl implements InstituteNumberChanged {
  const _$InstituteNumberChangedImpl(this.instituteNumber);

  @override
  final String instituteNumber;

  @override
  String toString() {
    return 'BankDetailsEvent.instituteNumberChanged(instituteNumber: $instituteNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstituteNumberChangedImpl &&
            (identical(other.instituteNumber, instituteNumber) ||
                other.instituteNumber == instituteNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, instituteNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InstituteNumberChangedImplCopyWith<_$InstituteNumberChangedImpl>
      get copyWith => __$$InstituteNumberChangedImplCopyWithImpl<
          _$InstituteNumberChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return instituteNumberChanged(instituteNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return instituteNumberChanged?.call(instituteNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (instituteNumberChanged != null) {
      return instituteNumberChanged(instituteNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return instituteNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return instituteNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (instituteNumberChanged != null) {
      return instituteNumberChanged(this);
    }
    return orElse();
  }
}

abstract class InstituteNumberChanged implements BankDetailsEvent {
  const factory InstituteNumberChanged(final String instituteNumber) =
      _$InstituteNumberChangedImpl;

  String get instituteNumber;
  @JsonKey(ignore: true)
  _$$InstituteNumberChangedImplCopyWith<_$InstituteNumberChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountNumberChangedImplCopyWith<$Res> {
  factory _$$AccountNumberChangedImplCopyWith(_$AccountNumberChangedImpl value,
          $Res Function(_$AccountNumberChangedImpl) then) =
      __$$AccountNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String accountNumber});
}

/// @nodoc
class __$$AccountNumberChangedImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$AccountNumberChangedImpl>
    implements _$$AccountNumberChangedImplCopyWith<$Res> {
  __$$AccountNumberChangedImplCopyWithImpl(_$AccountNumberChangedImpl _value,
      $Res Function(_$AccountNumberChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
  }) {
    return _then(_$AccountNumberChangedImpl(
      null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccountNumberChangedImpl implements AccountNumberChanged {
  const _$AccountNumberChangedImpl(this.accountNumber);

  @override
  final String accountNumber;

  @override
  String toString() {
    return 'BankDetailsEvent.accountNumberChanged(accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountNumberChangedImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountNumberChangedImplCopyWith<_$AccountNumberChangedImpl>
      get copyWith =>
          __$$AccountNumberChangedImplCopyWithImpl<_$AccountNumberChangedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return accountNumberChanged(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return accountNumberChanged?.call(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (accountNumberChanged != null) {
      return accountNumberChanged(accountNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return accountNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return accountNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (accountNumberChanged != null) {
      return accountNumberChanged(this);
    }
    return orElse();
  }
}

abstract class AccountNumberChanged implements BankDetailsEvent {
  const factory AccountNumberChanged(final String accountNumber) =
      _$AccountNumberChangedImpl;

  String get accountNumber;
  @JsonKey(ignore: true)
  _$$AccountNumberChangedImplCopyWith<_$AccountNumberChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BankAddressChangedImplCopyWith<$Res> {
  factory _$$BankAddressChangedImplCopyWith(_$BankAddressChangedImpl value,
          $Res Function(_$BankAddressChangedImpl) then) =
      __$$BankAddressChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String bankAddress});
}

/// @nodoc
class __$$BankAddressChangedImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$BankAddressChangedImpl>
    implements _$$BankAddressChangedImplCopyWith<$Res> {
  __$$BankAddressChangedImplCopyWithImpl(_$BankAddressChangedImpl _value,
      $Res Function(_$BankAddressChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankAddress = null,
  }) {
    return _then(_$BankAddressChangedImpl(
      null == bankAddress
          ? _value.bankAddress
          : bankAddress // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BankAddressChangedImpl implements BankAddressChanged {
  const _$BankAddressChangedImpl(this.bankAddress);

  @override
  final String bankAddress;

  @override
  String toString() {
    return 'BankDetailsEvent.bankAddressChanged(bankAddress: $bankAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankAddressChangedImpl &&
            (identical(other.bankAddress, bankAddress) ||
                other.bankAddress == bankAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bankAddress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankAddressChangedImplCopyWith<_$BankAddressChangedImpl> get copyWith =>
      __$$BankAddressChangedImplCopyWithImpl<_$BankAddressChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return bankAddressChanged(bankAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return bankAddressChanged?.call(bankAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (bankAddressChanged != null) {
      return bankAddressChanged(bankAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return bankAddressChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return bankAddressChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (bankAddressChanged != null) {
      return bankAddressChanged(this);
    }
    return orElse();
  }
}

abstract class BankAddressChanged implements BankDetailsEvent {
  const factory BankAddressChanged(final String bankAddress) =
      _$BankAddressChangedImpl;

  String get bankAddress;
  @JsonKey(ignore: true)
  _$$BankAddressChangedImplCopyWith<_$BankAddressChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckTermsConditionImplCopyWith<$Res> {
  factory _$$CheckTermsConditionImplCopyWith(_$CheckTermsConditionImpl value,
          $Res Function(_$CheckTermsConditionImpl) then) =
      __$$CheckTermsConditionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isCheck});
}

/// @nodoc
class __$$CheckTermsConditionImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$CheckTermsConditionImpl>
    implements _$$CheckTermsConditionImplCopyWith<$Res> {
  __$$CheckTermsConditionImplCopyWithImpl(_$CheckTermsConditionImpl _value,
      $Res Function(_$CheckTermsConditionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCheck = null,
  }) {
    return _then(_$CheckTermsConditionImpl(
      null == isCheck
          ? _value.isCheck
          : isCheck // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CheckTermsConditionImpl implements CheckTermsCondition {
  const _$CheckTermsConditionImpl(this.isCheck);

  @override
  final bool isCheck;

  @override
  String toString() {
    return 'BankDetailsEvent.checkTermsCondition(isCheck: $isCheck)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckTermsConditionImpl &&
            (identical(other.isCheck, isCheck) || other.isCheck == isCheck));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCheck);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckTermsConditionImplCopyWith<_$CheckTermsConditionImpl> get copyWith =>
      __$$CheckTermsConditionImplCopyWithImpl<_$CheckTermsConditionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return checkTermsCondition(isCheck);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return checkTermsCondition?.call(isCheck);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (checkTermsCondition != null) {
      return checkTermsCondition(isCheck);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return checkTermsCondition(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return checkTermsCondition?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (checkTermsCondition != null) {
      return checkTermsCondition(this);
    }
    return orElse();
  }
}

abstract class CheckTermsCondition implements BankDetailsEvent {
  const factory CheckTermsCondition(final bool isCheck) =
      _$CheckTermsConditionImpl;

  bool get isCheck;
  @JsonKey(ignore: true)
  _$$CheckTermsConditionImplCopyWith<_$CheckTermsConditionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitBtnPressedImplCopyWith<$Res> {
  factory _$$SubmitBtnPressedImplCopyWith(_$SubmitBtnPressedImpl value,
          $Res Function(_$SubmitBtnPressedImpl) then) =
      __$$SubmitBtnPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitBtnPressedImplCopyWithImpl<$Res>
    extends _$BankDetailsEventCopyWithImpl<$Res, _$SubmitBtnPressedImpl>
    implements _$$SubmitBtnPressedImplCopyWith<$Res> {
  __$$SubmitBtnPressedImplCopyWithImpl(_$SubmitBtnPressedImpl _value,
      $Res Function(_$SubmitBtnPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubmitBtnPressedImpl implements SubmitBtnPressed {
  const _$SubmitBtnPressedImpl();

  @override
  String toString() {
    return 'BankDetailsEvent.submitBtnPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitBtnPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankName) bankNameChanged,
    required TResult Function(String holderName) accountHolderNameChanged,
    required TResult Function(String transitNumber) transitNumberChanged,
    required TResult Function(String instituteNumber) instituteNumberChanged,
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String bankAddress) bankAddressChanged,
    required TResult Function(bool isCheck) checkTermsCondition,
    required TResult Function() submitBtnPressed,
  }) {
    return submitBtnPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankName)? bankNameChanged,
    TResult? Function(String holderName)? accountHolderNameChanged,
    TResult? Function(String transitNumber)? transitNumberChanged,
    TResult? Function(String instituteNumber)? instituteNumberChanged,
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String bankAddress)? bankAddressChanged,
    TResult? Function(bool isCheck)? checkTermsCondition,
    TResult? Function()? submitBtnPressed,
  }) {
    return submitBtnPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankName)? bankNameChanged,
    TResult Function(String holderName)? accountHolderNameChanged,
    TResult Function(String transitNumber)? transitNumberChanged,
    TResult Function(String instituteNumber)? instituteNumberChanged,
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String bankAddress)? bankAddressChanged,
    TResult Function(bool isCheck)? checkTermsCondition,
    TResult Function()? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (submitBtnPressed != null) {
      return submitBtnPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BankNameChanged value) bankNameChanged,
    required TResult Function(AccountHolderNameChanged value)
        accountHolderNameChanged,
    required TResult Function(TransitNumberChnaged value) transitNumberChanged,
    required TResult Function(InstituteNumberChanged value)
        instituteNumberChanged,
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(BankAddressChanged value) bankAddressChanged,
    required TResult Function(CheckTermsCondition value) checkTermsCondition,
    required TResult Function(SubmitBtnPressed value) submitBtnPressed,
  }) {
    return submitBtnPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BankNameChanged value)? bankNameChanged,
    TResult? Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult? Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult? Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(BankAddressChanged value)? bankAddressChanged,
    TResult? Function(CheckTermsCondition value)? checkTermsCondition,
    TResult? Function(SubmitBtnPressed value)? submitBtnPressed,
  }) {
    return submitBtnPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BankNameChanged value)? bankNameChanged,
    TResult Function(AccountHolderNameChanged value)? accountHolderNameChanged,
    TResult Function(TransitNumberChnaged value)? transitNumberChanged,
    TResult Function(InstituteNumberChanged value)? instituteNumberChanged,
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(BankAddressChanged value)? bankAddressChanged,
    TResult Function(CheckTermsCondition value)? checkTermsCondition,
    TResult Function(SubmitBtnPressed value)? submitBtnPressed,
    required TResult orElse(),
  }) {
    if (submitBtnPressed != null) {
      return submitBtnPressed(this);
    }
    return orElse();
  }
}

abstract class SubmitBtnPressed implements BankDetailsEvent {
  const factory SubmitBtnPressed() = _$SubmitBtnPressedImpl;
}

/// @nodoc
mixin _$BankDetailsState {
  Username get accountHolderName => throw _privateConstructorUsedError;
  InputEmptyOrNot get bankName => throw _privateConstructorUsedError;
  InputEmptyOrNot get transitNumber => throw _privateConstructorUsedError;
  InputEmptyOrNot get bankInstitutionNumber =>
      throw _privateConstructorUsedError;
  InputEmptyOrNot get accountNumber => throw _privateConstructorUsedError;
  InputEmptyOrNot get bankAddress => throw _privateConstructorUsedError;
  bool get isCheck => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BankDetailsStateCopyWith<BankDetailsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankDetailsStateCopyWith<$Res> {
  factory $BankDetailsStateCopyWith(
          BankDetailsState value, $Res Function(BankDetailsState) then) =
      _$BankDetailsStateCopyWithImpl<$Res, BankDetailsState>;
  @useResult
  $Res call(
      {Username accountHolderName,
      InputEmptyOrNot bankName,
      InputEmptyOrNot transitNumber,
      InputEmptyOrNot bankInstitutionNumber,
      InputEmptyOrNot accountNumber,
      InputEmptyOrNot bankAddress,
      bool isCheck,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class _$BankDetailsStateCopyWithImpl<$Res, $Val extends BankDetailsState>
    implements $BankDetailsStateCopyWith<$Res> {
  _$BankDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountHolderName = null,
    Object? bankName = null,
    Object? transitNumber = null,
    Object? bankInstitutionNumber = null,
    Object? accountNumber = null,
    Object? bankAddress = null,
    Object? isCheck = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as Username,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      transitNumber: null == transitNumber
          ? _value.transitNumber
          : transitNumber // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      bankInstitutionNumber: null == bankInstitutionNumber
          ? _value.bankInstitutionNumber
          : bankInstitutionNumber // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      bankAddress: null == bankAddress
          ? _value.bankAddress
          : bankAddress // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      isCheck: null == isCheck
          ? _value.isCheck
          : isCheck // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$BankDetailsStateImplCopyWith<$Res>
    implements $BankDetailsStateCopyWith<$Res> {
  factory _$$BankDetailsStateImplCopyWith(_$BankDetailsStateImpl value,
          $Res Function(_$BankDetailsStateImpl) then) =
      __$$BankDetailsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Username accountHolderName,
      InputEmptyOrNot bankName,
      InputEmptyOrNot transitNumber,
      InputEmptyOrNot bankInstitutionNumber,
      InputEmptyOrNot accountNumber,
      InputEmptyOrNot bankAddress,
      bool isCheck,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$BankDetailsStateImplCopyWithImpl<$Res>
    extends _$BankDetailsStateCopyWithImpl<$Res, _$BankDetailsStateImpl>
    implements _$$BankDetailsStateImplCopyWith<$Res> {
  __$$BankDetailsStateImplCopyWithImpl(_$BankDetailsStateImpl _value,
      $Res Function(_$BankDetailsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountHolderName = null,
    Object? bankName = null,
    Object? transitNumber = null,
    Object? bankInstitutionNumber = null,
    Object? accountNumber = null,
    Object? bankAddress = null,
    Object? isCheck = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$BankDetailsStateImpl(
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as Username,
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      transitNumber: null == transitNumber
          ? _value.transitNumber
          : transitNumber // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      bankInstitutionNumber: null == bankInstitutionNumber
          ? _value.bankInstitutionNumber
          : bankInstitutionNumber // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      bankAddress: null == bankAddress
          ? _value.bankAddress
          : bankAddress // ignore: cast_nullable_to_non_nullable
              as InputEmptyOrNot,
      isCheck: null == isCheck
          ? _value.isCheck
          : isCheck // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$BankDetailsStateImpl implements _BankDetailsState {
  const _$BankDetailsStateImpl(
      {required this.accountHolderName,
      required this.bankName,
      required this.transitNumber,
      required this.bankInstitutionNumber,
      required this.accountNumber,
      required this.bankAddress,
      required this.isCheck,
      required this.showErrorMessages,
      required this.isSubmitting,
      required this.authFailureOrSuccessOption});

  @override
  final Username accountHolderName;
  @override
  final InputEmptyOrNot bankName;
  @override
  final InputEmptyOrNot transitNumber;
  @override
  final InputEmptyOrNot bankInstitutionNumber;
  @override
  final InputEmptyOrNot accountNumber;
  @override
  final InputEmptyOrNot bankAddress;
  @override
  final bool isCheck;
  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'BankDetailsState(accountHolderName: $accountHolderName, bankName: $bankName, transitNumber: $transitNumber, bankInstitutionNumber: $bankInstitutionNumber, accountNumber: $accountNumber, bankAddress: $bankAddress, isCheck: $isCheck, showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankDetailsStateImpl &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.transitNumber, transitNumber) ||
                other.transitNumber == transitNumber) &&
            (identical(other.bankInstitutionNumber, bankInstitutionNumber) ||
                other.bankInstitutionNumber == bankInstitutionNumber) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.bankAddress, bankAddress) ||
                other.bankAddress == bankAddress) &&
            (identical(other.isCheck, isCheck) || other.isCheck == isCheck) &&
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
      runtimeType,
      accountHolderName,
      bankName,
      transitNumber,
      bankInstitutionNumber,
      accountNumber,
      bankAddress,
      isCheck,
      showErrorMessages,
      isSubmitting,
      authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankDetailsStateImplCopyWith<_$BankDetailsStateImpl> get copyWith =>
      __$$BankDetailsStateImplCopyWithImpl<_$BankDetailsStateImpl>(
          this, _$identity);
}

abstract class _BankDetailsState implements BankDetailsState {
  const factory _BankDetailsState(
      {required final Username accountHolderName,
      required final InputEmptyOrNot bankName,
      required final InputEmptyOrNot transitNumber,
      required final InputEmptyOrNot bankInstitutionNumber,
      required final InputEmptyOrNot accountNumber,
      required final InputEmptyOrNot bankAddress,
      required final bool isCheck,
      required final bool showErrorMessages,
      required final bool isSubmitting,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$BankDetailsStateImpl;

  @override
  Username get accountHolderName;
  @override
  InputEmptyOrNot get bankName;
  @override
  InputEmptyOrNot get transitNumber;
  @override
  InputEmptyOrNot get bankInstitutionNumber;
  @override
  InputEmptyOrNot get accountNumber;
  @override
  InputEmptyOrNot get bankAddress;
  @override
  bool get isCheck;
  @override
  bool get showErrorMessages;
  @override
  bool get isSubmitting;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$BankDetailsStateImplCopyWith<_$BankDetailsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
