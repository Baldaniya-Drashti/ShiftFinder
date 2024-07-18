// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String holderName) holderNameChanged,
    required TResult Function(String cardNo) cardNoChanged,
    required TResult Function(String cvv) cvvNoChanged,
    required TResult Function(String expDate) expDateChanged,
    required TResult Function() addCardBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String holderName)? holderNameChanged,
    TResult? Function(String cardNo)? cardNoChanged,
    TResult? Function(String cvv)? cvvNoChanged,
    TResult? Function(String expDate)? expDateChanged,
    TResult? Function()? addCardBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String holderName)? holderNameChanged,
    TResult Function(String cardNo)? cardNoChanged,
    TResult Function(String cvv)? cvvNoChanged,
    TResult Function(String expDate)? expDateChanged,
    TResult Function()? addCardBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HolderNameChanged value) holderNameChanged,
    required TResult Function(CardNoChanged value) cardNoChanged,
    required TResult Function(CvvNoChanged value) cvvNoChanged,
    required TResult Function(ExpDateChanged value) expDateChanged,
    required TResult Function(AddCardBtnPressed value) addCardBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HolderNameChanged value)? holderNameChanged,
    TResult? Function(CardNoChanged value)? cardNoChanged,
    TResult? Function(CvvNoChanged value)? cvvNoChanged,
    TResult? Function(ExpDateChanged value)? expDateChanged,
    TResult? Function(AddCardBtnPressed value)? addCardBtnPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HolderNameChanged value)? holderNameChanged,
    TResult Function(CardNoChanged value)? cardNoChanged,
    TResult Function(CvvNoChanged value)? cvvNoChanged,
    TResult Function(ExpDateChanged value)? expDateChanged,
    TResult Function(AddCardBtnPressed value)? addCardBtnPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardEventCopyWith<$Res> {
  factory $CardEventCopyWith(CardEvent value, $Res Function(CardEvent) then) =
      _$CardEventCopyWithImpl<$Res, CardEvent>;
}

/// @nodoc
class _$CardEventCopyWithImpl<$Res, $Val extends CardEvent>
    implements $CardEventCopyWith<$Res> {
  _$CardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$HolderNameChangedImplCopyWith<$Res> {
  factory _$$HolderNameChangedImplCopyWith(_$HolderNameChangedImpl value,
          $Res Function(_$HolderNameChangedImpl) then) =
      __$$HolderNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String holderName});
}

/// @nodoc
class __$$HolderNameChangedImplCopyWithImpl<$Res>
    extends _$CardEventCopyWithImpl<$Res, _$HolderNameChangedImpl>
    implements _$$HolderNameChangedImplCopyWith<$Res> {
  __$$HolderNameChangedImplCopyWithImpl(_$HolderNameChangedImpl _value,
      $Res Function(_$HolderNameChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? holderName = null,
  }) {
    return _then(_$HolderNameChangedImpl(
      null == holderName
          ? _value.holderName
          : holderName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$HolderNameChangedImpl implements HolderNameChanged {
  const _$HolderNameChangedImpl(this.holderName);

  @override
  final String holderName;

  @override
  String toString() {
    return 'CardEvent.holderNameChanged(holderName: $holderName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HolderNameChangedImpl &&
            (identical(other.holderName, holderName) ||
                other.holderName == holderName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, holderName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HolderNameChangedImplCopyWith<_$HolderNameChangedImpl> get copyWith =>
      __$$HolderNameChangedImplCopyWithImpl<_$HolderNameChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String holderName) holderNameChanged,
    required TResult Function(String cardNo) cardNoChanged,
    required TResult Function(String cvv) cvvNoChanged,
    required TResult Function(String expDate) expDateChanged,
    required TResult Function() addCardBtnPressed,
  }) {
    return holderNameChanged(holderName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String holderName)? holderNameChanged,
    TResult? Function(String cardNo)? cardNoChanged,
    TResult? Function(String cvv)? cvvNoChanged,
    TResult? Function(String expDate)? expDateChanged,
    TResult? Function()? addCardBtnPressed,
  }) {
    return holderNameChanged?.call(holderName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String holderName)? holderNameChanged,
    TResult Function(String cardNo)? cardNoChanged,
    TResult Function(String cvv)? cvvNoChanged,
    TResult Function(String expDate)? expDateChanged,
    TResult Function()? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (holderNameChanged != null) {
      return holderNameChanged(holderName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HolderNameChanged value) holderNameChanged,
    required TResult Function(CardNoChanged value) cardNoChanged,
    required TResult Function(CvvNoChanged value) cvvNoChanged,
    required TResult Function(ExpDateChanged value) expDateChanged,
    required TResult Function(AddCardBtnPressed value) addCardBtnPressed,
  }) {
    return holderNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HolderNameChanged value)? holderNameChanged,
    TResult? Function(CardNoChanged value)? cardNoChanged,
    TResult? Function(CvvNoChanged value)? cvvNoChanged,
    TResult? Function(ExpDateChanged value)? expDateChanged,
    TResult? Function(AddCardBtnPressed value)? addCardBtnPressed,
  }) {
    return holderNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HolderNameChanged value)? holderNameChanged,
    TResult Function(CardNoChanged value)? cardNoChanged,
    TResult Function(CvvNoChanged value)? cvvNoChanged,
    TResult Function(ExpDateChanged value)? expDateChanged,
    TResult Function(AddCardBtnPressed value)? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (holderNameChanged != null) {
      return holderNameChanged(this);
    }
    return orElse();
  }
}

abstract class HolderNameChanged implements CardEvent {
  const factory HolderNameChanged(final String holderName) =
      _$HolderNameChangedImpl;

  String get holderName;
  @JsonKey(ignore: true)
  _$$HolderNameChangedImplCopyWith<_$HolderNameChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CardNoChangedImplCopyWith<$Res> {
  factory _$$CardNoChangedImplCopyWith(
          _$CardNoChangedImpl value, $Res Function(_$CardNoChangedImpl) then) =
      __$$CardNoChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cardNo});
}

/// @nodoc
class __$$CardNoChangedImplCopyWithImpl<$Res>
    extends _$CardEventCopyWithImpl<$Res, _$CardNoChangedImpl>
    implements _$$CardNoChangedImplCopyWith<$Res> {
  __$$CardNoChangedImplCopyWithImpl(
      _$CardNoChangedImpl _value, $Res Function(_$CardNoChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNo = null,
  }) {
    return _then(_$CardNoChangedImpl(
      null == cardNo
          ? _value.cardNo
          : cardNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CardNoChangedImpl implements CardNoChanged {
  const _$CardNoChangedImpl(this.cardNo);

  @override
  final String cardNo;

  @override
  String toString() {
    return 'CardEvent.cardNoChanged(cardNo: $cardNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardNoChangedImpl &&
            (identical(other.cardNo, cardNo) || other.cardNo == cardNo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cardNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardNoChangedImplCopyWith<_$CardNoChangedImpl> get copyWith =>
      __$$CardNoChangedImplCopyWithImpl<_$CardNoChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String holderName) holderNameChanged,
    required TResult Function(String cardNo) cardNoChanged,
    required TResult Function(String cvv) cvvNoChanged,
    required TResult Function(String expDate) expDateChanged,
    required TResult Function() addCardBtnPressed,
  }) {
    return cardNoChanged(cardNo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String holderName)? holderNameChanged,
    TResult? Function(String cardNo)? cardNoChanged,
    TResult? Function(String cvv)? cvvNoChanged,
    TResult? Function(String expDate)? expDateChanged,
    TResult? Function()? addCardBtnPressed,
  }) {
    return cardNoChanged?.call(cardNo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String holderName)? holderNameChanged,
    TResult Function(String cardNo)? cardNoChanged,
    TResult Function(String cvv)? cvvNoChanged,
    TResult Function(String expDate)? expDateChanged,
    TResult Function()? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (cardNoChanged != null) {
      return cardNoChanged(cardNo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HolderNameChanged value) holderNameChanged,
    required TResult Function(CardNoChanged value) cardNoChanged,
    required TResult Function(CvvNoChanged value) cvvNoChanged,
    required TResult Function(ExpDateChanged value) expDateChanged,
    required TResult Function(AddCardBtnPressed value) addCardBtnPressed,
  }) {
    return cardNoChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HolderNameChanged value)? holderNameChanged,
    TResult? Function(CardNoChanged value)? cardNoChanged,
    TResult? Function(CvvNoChanged value)? cvvNoChanged,
    TResult? Function(ExpDateChanged value)? expDateChanged,
    TResult? Function(AddCardBtnPressed value)? addCardBtnPressed,
  }) {
    return cardNoChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HolderNameChanged value)? holderNameChanged,
    TResult Function(CardNoChanged value)? cardNoChanged,
    TResult Function(CvvNoChanged value)? cvvNoChanged,
    TResult Function(ExpDateChanged value)? expDateChanged,
    TResult Function(AddCardBtnPressed value)? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (cardNoChanged != null) {
      return cardNoChanged(this);
    }
    return orElse();
  }
}

abstract class CardNoChanged implements CardEvent {
  const factory CardNoChanged(final String cardNo) = _$CardNoChangedImpl;

  String get cardNo;
  @JsonKey(ignore: true)
  _$$CardNoChangedImplCopyWith<_$CardNoChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CvvNoChangedImplCopyWith<$Res> {
  factory _$$CvvNoChangedImplCopyWith(
          _$CvvNoChangedImpl value, $Res Function(_$CvvNoChangedImpl) then) =
      __$$CvvNoChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cvv});
}

/// @nodoc
class __$$CvvNoChangedImplCopyWithImpl<$Res>
    extends _$CardEventCopyWithImpl<$Res, _$CvvNoChangedImpl>
    implements _$$CvvNoChangedImplCopyWith<$Res> {
  __$$CvvNoChangedImplCopyWithImpl(
      _$CvvNoChangedImpl _value, $Res Function(_$CvvNoChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cvv = null,
  }) {
    return _then(_$CvvNoChangedImpl(
      null == cvv
          ? _value.cvv
          : cvv // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CvvNoChangedImpl implements CvvNoChanged {
  const _$CvvNoChangedImpl(this.cvv);

  @override
  final String cvv;

  @override
  String toString() {
    return 'CardEvent.cvvNoChanged(cvv: $cvv)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CvvNoChangedImpl &&
            (identical(other.cvv, cvv) || other.cvv == cvv));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cvv);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CvvNoChangedImplCopyWith<_$CvvNoChangedImpl> get copyWith =>
      __$$CvvNoChangedImplCopyWithImpl<_$CvvNoChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String holderName) holderNameChanged,
    required TResult Function(String cardNo) cardNoChanged,
    required TResult Function(String cvv) cvvNoChanged,
    required TResult Function(String expDate) expDateChanged,
    required TResult Function() addCardBtnPressed,
  }) {
    return cvvNoChanged(cvv);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String holderName)? holderNameChanged,
    TResult? Function(String cardNo)? cardNoChanged,
    TResult? Function(String cvv)? cvvNoChanged,
    TResult? Function(String expDate)? expDateChanged,
    TResult? Function()? addCardBtnPressed,
  }) {
    return cvvNoChanged?.call(cvv);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String holderName)? holderNameChanged,
    TResult Function(String cardNo)? cardNoChanged,
    TResult Function(String cvv)? cvvNoChanged,
    TResult Function(String expDate)? expDateChanged,
    TResult Function()? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (cvvNoChanged != null) {
      return cvvNoChanged(cvv);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HolderNameChanged value) holderNameChanged,
    required TResult Function(CardNoChanged value) cardNoChanged,
    required TResult Function(CvvNoChanged value) cvvNoChanged,
    required TResult Function(ExpDateChanged value) expDateChanged,
    required TResult Function(AddCardBtnPressed value) addCardBtnPressed,
  }) {
    return cvvNoChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HolderNameChanged value)? holderNameChanged,
    TResult? Function(CardNoChanged value)? cardNoChanged,
    TResult? Function(CvvNoChanged value)? cvvNoChanged,
    TResult? Function(ExpDateChanged value)? expDateChanged,
    TResult? Function(AddCardBtnPressed value)? addCardBtnPressed,
  }) {
    return cvvNoChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HolderNameChanged value)? holderNameChanged,
    TResult Function(CardNoChanged value)? cardNoChanged,
    TResult Function(CvvNoChanged value)? cvvNoChanged,
    TResult Function(ExpDateChanged value)? expDateChanged,
    TResult Function(AddCardBtnPressed value)? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (cvvNoChanged != null) {
      return cvvNoChanged(this);
    }
    return orElse();
  }
}

abstract class CvvNoChanged implements CardEvent {
  const factory CvvNoChanged(final String cvv) = _$CvvNoChangedImpl;

  String get cvv;
  @JsonKey(ignore: true)
  _$$CvvNoChangedImplCopyWith<_$CvvNoChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExpDateChangedImplCopyWith<$Res> {
  factory _$$ExpDateChangedImplCopyWith(_$ExpDateChangedImpl value,
          $Res Function(_$ExpDateChangedImpl) then) =
      __$$ExpDateChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String expDate});
}

/// @nodoc
class __$$ExpDateChangedImplCopyWithImpl<$Res>
    extends _$CardEventCopyWithImpl<$Res, _$ExpDateChangedImpl>
    implements _$$ExpDateChangedImplCopyWith<$Res> {
  __$$ExpDateChangedImplCopyWithImpl(
      _$ExpDateChangedImpl _value, $Res Function(_$ExpDateChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expDate = null,
  }) {
    return _then(_$ExpDateChangedImpl(
      null == expDate
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ExpDateChangedImpl implements ExpDateChanged {
  const _$ExpDateChangedImpl(this.expDate);

  @override
  final String expDate;

  @override
  String toString() {
    return 'CardEvent.expDateChanged(expDate: $expDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpDateChangedImpl &&
            (identical(other.expDate, expDate) || other.expDate == expDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, expDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpDateChangedImplCopyWith<_$ExpDateChangedImpl> get copyWith =>
      __$$ExpDateChangedImplCopyWithImpl<_$ExpDateChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String holderName) holderNameChanged,
    required TResult Function(String cardNo) cardNoChanged,
    required TResult Function(String cvv) cvvNoChanged,
    required TResult Function(String expDate) expDateChanged,
    required TResult Function() addCardBtnPressed,
  }) {
    return expDateChanged(expDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String holderName)? holderNameChanged,
    TResult? Function(String cardNo)? cardNoChanged,
    TResult? Function(String cvv)? cvvNoChanged,
    TResult? Function(String expDate)? expDateChanged,
    TResult? Function()? addCardBtnPressed,
  }) {
    return expDateChanged?.call(expDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String holderName)? holderNameChanged,
    TResult Function(String cardNo)? cardNoChanged,
    TResult Function(String cvv)? cvvNoChanged,
    TResult Function(String expDate)? expDateChanged,
    TResult Function()? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (expDateChanged != null) {
      return expDateChanged(expDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HolderNameChanged value) holderNameChanged,
    required TResult Function(CardNoChanged value) cardNoChanged,
    required TResult Function(CvvNoChanged value) cvvNoChanged,
    required TResult Function(ExpDateChanged value) expDateChanged,
    required TResult Function(AddCardBtnPressed value) addCardBtnPressed,
  }) {
    return expDateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HolderNameChanged value)? holderNameChanged,
    TResult? Function(CardNoChanged value)? cardNoChanged,
    TResult? Function(CvvNoChanged value)? cvvNoChanged,
    TResult? Function(ExpDateChanged value)? expDateChanged,
    TResult? Function(AddCardBtnPressed value)? addCardBtnPressed,
  }) {
    return expDateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HolderNameChanged value)? holderNameChanged,
    TResult Function(CardNoChanged value)? cardNoChanged,
    TResult Function(CvvNoChanged value)? cvvNoChanged,
    TResult Function(ExpDateChanged value)? expDateChanged,
    TResult Function(AddCardBtnPressed value)? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (expDateChanged != null) {
      return expDateChanged(this);
    }
    return orElse();
  }
}

abstract class ExpDateChanged implements CardEvent {
  const factory ExpDateChanged(final String expDate) = _$ExpDateChangedImpl;

  String get expDate;
  @JsonKey(ignore: true)
  _$$ExpDateChangedImplCopyWith<_$ExpDateChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddCardBtnPressedImplCopyWith<$Res> {
  factory _$$AddCardBtnPressedImplCopyWith(_$AddCardBtnPressedImpl value,
          $Res Function(_$AddCardBtnPressedImpl) then) =
      __$$AddCardBtnPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddCardBtnPressedImplCopyWithImpl<$Res>
    extends _$CardEventCopyWithImpl<$Res, _$AddCardBtnPressedImpl>
    implements _$$AddCardBtnPressedImplCopyWith<$Res> {
  __$$AddCardBtnPressedImplCopyWithImpl(_$AddCardBtnPressedImpl _value,
      $Res Function(_$AddCardBtnPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AddCardBtnPressedImpl implements AddCardBtnPressed {
  const _$AddCardBtnPressedImpl();

  @override
  String toString() {
    return 'CardEvent.addCardBtnPressed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddCardBtnPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String holderName) holderNameChanged,
    required TResult Function(String cardNo) cardNoChanged,
    required TResult Function(String cvv) cvvNoChanged,
    required TResult Function(String expDate) expDateChanged,
    required TResult Function() addCardBtnPressed,
  }) {
    return addCardBtnPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String holderName)? holderNameChanged,
    TResult? Function(String cardNo)? cardNoChanged,
    TResult? Function(String cvv)? cvvNoChanged,
    TResult? Function(String expDate)? expDateChanged,
    TResult? Function()? addCardBtnPressed,
  }) {
    return addCardBtnPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String holderName)? holderNameChanged,
    TResult Function(String cardNo)? cardNoChanged,
    TResult Function(String cvv)? cvvNoChanged,
    TResult Function(String expDate)? expDateChanged,
    TResult Function()? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (addCardBtnPressed != null) {
      return addCardBtnPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HolderNameChanged value) holderNameChanged,
    required TResult Function(CardNoChanged value) cardNoChanged,
    required TResult Function(CvvNoChanged value) cvvNoChanged,
    required TResult Function(ExpDateChanged value) expDateChanged,
    required TResult Function(AddCardBtnPressed value) addCardBtnPressed,
  }) {
    return addCardBtnPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HolderNameChanged value)? holderNameChanged,
    TResult? Function(CardNoChanged value)? cardNoChanged,
    TResult? Function(CvvNoChanged value)? cvvNoChanged,
    TResult? Function(ExpDateChanged value)? expDateChanged,
    TResult? Function(AddCardBtnPressed value)? addCardBtnPressed,
  }) {
    return addCardBtnPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HolderNameChanged value)? holderNameChanged,
    TResult Function(CardNoChanged value)? cardNoChanged,
    TResult Function(CvvNoChanged value)? cvvNoChanged,
    TResult Function(ExpDateChanged value)? expDateChanged,
    TResult Function(AddCardBtnPressed value)? addCardBtnPressed,
    required TResult orElse(),
  }) {
    if (addCardBtnPressed != null) {
      return addCardBtnPressed(this);
    }
    return orElse();
  }
}

abstract class AddCardBtnPressed implements CardEvent {
  const factory AddCardBtnPressed() = _$AddCardBtnPressedImpl;
}

/// @nodoc
mixin _$CardState {
  Username get cardHolderName => throw _privateConstructorUsedError;
  CardNumber get cardNumber => throw _privateConstructorUsedError;
  CVV get cvvNo => throw _privateConstructorUsedError;
  CardDate get expDate => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardStateCopyWith<CardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardStateCopyWith<$Res> {
  factory $CardStateCopyWith(CardState value, $Res Function(CardState) then) =
      _$CardStateCopyWithImpl<$Res, CardState>;
  @useResult
  $Res call(
      {Username cardHolderName,
      CardNumber cardNumber,
      CVV cvvNo,
      CardDate expDate,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class _$CardStateCopyWithImpl<$Res, $Val extends CardState>
    implements $CardStateCopyWith<$Res> {
  _$CardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardHolderName = null,
    Object? cardNumber = null,
    Object? cvvNo = null,
    Object? expDate = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_value.copyWith(
      cardHolderName: null == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as Username,
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as CardNumber,
      cvvNo: null == cvvNo
          ? _value.cvvNo
          : cvvNo // ignore: cast_nullable_to_non_nullable
              as CVV,
      expDate: null == expDate
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as CardDate,
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
abstract class _$$CardStateImplCopyWith<$Res>
    implements $CardStateCopyWith<$Res> {
  factory _$$CardStateImplCopyWith(
          _$CardStateImpl value, $Res Function(_$CardStateImpl) then) =
      __$$CardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Username cardHolderName,
      CardNumber cardNumber,
      CVV cvvNo,
      CardDate expDate,
      bool showErrorMessages,
      bool isSubmitting,
      Option<Either<AuthFailure, String>> authFailureOrSuccessOption});
}

/// @nodoc
class __$$CardStateImplCopyWithImpl<$Res>
    extends _$CardStateCopyWithImpl<$Res, _$CardStateImpl>
    implements _$$CardStateImplCopyWith<$Res> {
  __$$CardStateImplCopyWithImpl(
      _$CardStateImpl _value, $Res Function(_$CardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardHolderName = null,
    Object? cardNumber = null,
    Object? cvvNo = null,
    Object? expDate = null,
    Object? showErrorMessages = null,
    Object? isSubmitting = null,
    Object? authFailureOrSuccessOption = null,
  }) {
    return _then(_$CardStateImpl(
      cardHolderName: null == cardHolderName
          ? _value.cardHolderName
          : cardHolderName // ignore: cast_nullable_to_non_nullable
              as Username,
      cardNumber: null == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as CardNumber,
      cvvNo: null == cvvNo
          ? _value.cvvNo
          : cvvNo // ignore: cast_nullable_to_non_nullable
              as CVV,
      expDate: null == expDate
          ? _value.expDate
          : expDate // ignore: cast_nullable_to_non_nullable
              as CardDate,
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

class _$CardStateImpl implements _CardState {
  const _$CardStateImpl(
      {required this.cardHolderName,
      required this.cardNumber,
      required this.cvvNo,
      required this.expDate,
      required this.showErrorMessages,
      required this.isSubmitting,
      required this.authFailureOrSuccessOption});

  @override
  final Username cardHolderName;
  @override
  final CardNumber cardNumber;
  @override
  final CVV cvvNo;
  @override
  final CardDate expDate;
  @override
  final bool showErrorMessages;
  @override
  final bool isSubmitting;
  @override
  final Option<Either<AuthFailure, String>> authFailureOrSuccessOption;

  @override
  String toString() {
    return 'CardState(cardHolderName: $cardHolderName, cardNumber: $cardNumber, cvvNo: $cvvNo, expDate: $expDate, showErrorMessages: $showErrorMessages, isSubmitting: $isSubmitting, authFailureOrSuccessOption: $authFailureOrSuccessOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardStateImpl &&
            (identical(other.cardHolderName, cardHolderName) ||
                other.cardHolderName == cardHolderName) &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.cvvNo, cvvNo) || other.cvvNo == cvvNo) &&
            (identical(other.expDate, expDate) || other.expDate == expDate) &&
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
      cardHolderName,
      cardNumber,
      cvvNo,
      expDate,
      showErrorMessages,
      isSubmitting,
      authFailureOrSuccessOption);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CardStateImplCopyWith<_$CardStateImpl> get copyWith =>
      __$$CardStateImplCopyWithImpl<_$CardStateImpl>(this, _$identity);
}

abstract class _CardState implements CardState {
  const factory _CardState(
      {required final Username cardHolderName,
      required final CardNumber cardNumber,
      required final CVV cvvNo,
      required final CardDate expDate,
      required final bool showErrorMessages,
      required final bool isSubmitting,
      required final Option<Either<AuthFailure, String>>
          authFailureOrSuccessOption}) = _$CardStateImpl;

  @override
  Username get cardHolderName;
  @override
  CardNumber get cardNumber;
  @override
  CVV get cvvNo;
  @override
  CardDate get expDate;
  @override
  bool get showErrorMessages;
  @override
  bool get isSubmitting;
  @override
  Option<Either<AuthFailure, String>> get authFailureOrSuccessOption;
  @override
  @JsonKey(ignore: true)
  _$$CardStateImplCopyWith<_$CardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
