// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Account {
  int? get userId => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  int? get isVerified => throw _privateConstructorUsedError;
  int? get serviceRole => throw _privateConstructorUsedError;
  int? get industryId => throw _privateConstructorUsedError;
  String? get profileImage => throw _privateConstructorUsedError;
  String? get companyName => throw _privateConstructorUsedError;
  String? get countryCode => throw _privateConstructorUsedError;
  String? get countryNameCode => throw _privateConstructorUsedError;
  int? get phone => throw _privateConstructorUsedError;
  String? get association => throw _privateConstructorUsedError;
  String? get companyDescription => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get referralCode => throw _privateConstructorUsedError;
  String? get lastPage => throw _privateConstructorUsedError;
  List<EducationDTO>? get education => throw _privateConstructorUsedError;
  Auth? get auth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {int? userId,
      String? firstName,
      String? lastName,
      String? email,
      int? isVerified,
      int? serviceRole,
      int? industryId,
      String? profileImage,
      String? companyName,
      String? countryCode,
      String? countryNameCode,
      int? phone,
      String? association,
      String? companyDescription,
      String? location,
      String? referralCode,
      String? lastPage,
      List<EducationDTO>? education,
      Auth? auth});

  $AuthCopyWith<$Res>? get auth;
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? isVerified = freezed,
    Object? serviceRole = freezed,
    Object? industryId = freezed,
    Object? profileImage = freezed,
    Object? companyName = freezed,
    Object? countryCode = freezed,
    Object? countryNameCode = freezed,
    Object? phone = freezed,
    Object? association = freezed,
    Object? companyDescription = freezed,
    Object? location = freezed,
    Object? referralCode = freezed,
    Object? lastPage = freezed,
    Object? education = freezed,
    Object? auth = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceRole: freezed == serviceRole
          ? _value.serviceRole
          : serviceRole // ignore: cast_nullable_to_non_nullable
              as int?,
      industryId: freezed == industryId
          ? _value.industryId
          : industryId // ignore: cast_nullable_to_non_nullable
              as int?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryNameCode: freezed == countryNameCode
          ? _value.countryNameCode
          : countryNameCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int?,
      association: freezed == association
          ? _value.association
          : association // ignore: cast_nullable_to_non_nullable
              as String?,
      companyDescription: freezed == companyDescription
          ? _value.companyDescription
          : companyDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as String?,
      education: freezed == education
          ? _value.education
          : education // ignore: cast_nullable_to_non_nullable
              as List<EducationDTO>?,
      auth: freezed == auth
          ? _value.auth
          : auth // ignore: cast_nullable_to_non_nullable
              as Auth?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthCopyWith<$Res>? get auth {
    if (_value.auth == null) {
      return null;
    }

    return $AuthCopyWith<$Res>(_value.auth!, (value) {
      return _then(_value.copyWith(auth: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountImplCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$AccountImplCopyWith(
          _$AccountImpl value, $Res Function(_$AccountImpl) then) =
      __$$AccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? userId,
      String? firstName,
      String? lastName,
      String? email,
      int? isVerified,
      int? serviceRole,
      int? industryId,
      String? profileImage,
      String? companyName,
      String? countryCode,
      String? countryNameCode,
      int? phone,
      String? association,
      String? companyDescription,
      String? location,
      String? referralCode,
      String? lastPage,
      List<EducationDTO>? education,
      Auth? auth});

  @override
  $AuthCopyWith<$Res>? get auth;
}

/// @nodoc
class __$$AccountImplCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$AccountImpl>
    implements _$$AccountImplCopyWith<$Res> {
  __$$AccountImplCopyWithImpl(
      _$AccountImpl _value, $Res Function(_$AccountImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? isVerified = freezed,
    Object? serviceRole = freezed,
    Object? industryId = freezed,
    Object? profileImage = freezed,
    Object? companyName = freezed,
    Object? countryCode = freezed,
    Object? countryNameCode = freezed,
    Object? phone = freezed,
    Object? association = freezed,
    Object? companyDescription = freezed,
    Object? location = freezed,
    Object? referralCode = freezed,
    Object? lastPage = freezed,
    Object? education = freezed,
    Object? auth = freezed,
  }) {
    return _then(_$AccountImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as int?,
      serviceRole: freezed == serviceRole
          ? _value.serviceRole
          : serviceRole // ignore: cast_nullable_to_non_nullable
              as int?,
      industryId: freezed == industryId
          ? _value.industryId
          : industryId // ignore: cast_nullable_to_non_nullable
              as int?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryNameCode: freezed == countryNameCode
          ? _value.countryNameCode
          : countryNameCode // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as int?,
      association: freezed == association
          ? _value.association
          : association // ignore: cast_nullable_to_non_nullable
              as String?,
      companyDescription: freezed == companyDescription
          ? _value.companyDescription
          : companyDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPage: freezed == lastPage
          ? _value.lastPage
          : lastPage // ignore: cast_nullable_to_non_nullable
              as String?,
      education: freezed == education
          ? _value._education
          : education // ignore: cast_nullable_to_non_nullable
              as List<EducationDTO>?,
      auth: freezed == auth
          ? _value.auth
          : auth // ignore: cast_nullable_to_non_nullable
              as Auth?,
    ));
  }
}

/// @nodoc

class _$AccountImpl extends _Account {
  const _$AccountImpl(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.isVerified,
      this.serviceRole,
      this.industryId,
      this.profileImage,
      this.companyName,
      this.countryCode,
      this.countryNameCode,
      this.phone,
      this.association,
      this.companyDescription,
      this.location,
      this.referralCode,
      this.lastPage,
      final List<EducationDTO>? education,
      this.auth})
      : _education = education,
        super._();

  @override
  final int? userId;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final int? isVerified;
  @override
  final int? serviceRole;
  @override
  final int? industryId;
  @override
  final String? profileImage;
  @override
  final String? companyName;
  @override
  final String? countryCode;
  @override
  final String? countryNameCode;
  @override
  final int? phone;
  @override
  final String? association;
  @override
  final String? companyDescription;
  @override
  final String? location;
  @override
  final String? referralCode;
  @override
  final String? lastPage;
  final List<EducationDTO>? _education;
  @override
  List<EducationDTO>? get education {
    final value = _education;
    if (value == null) return null;
    if (_education is EqualUnmodifiableListView) return _education;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Auth? auth;

  @override
  String toString() {
    return 'Account(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, isVerified: $isVerified, serviceRole: $serviceRole, industryId: $industryId, profileImage: $profileImage, companyName: $companyName, countryCode: $countryCode, countryNameCode: $countryNameCode, phone: $phone, association: $association, companyDescription: $companyDescription, location: $location, referralCode: $referralCode, lastPage: $lastPage, education: $education, auth: $auth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.serviceRole, serviceRole) ||
                other.serviceRole == serviceRole) &&
            (identical(other.industryId, industryId) ||
                other.industryId == industryId) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode) &&
            (identical(other.countryNameCode, countryNameCode) ||
                other.countryNameCode == countryNameCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.association, association) ||
                other.association == association) &&
            (identical(other.companyDescription, companyDescription) ||
                other.companyDescription == companyDescription) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.lastPage, lastPage) ||
                other.lastPage == lastPage) &&
            const DeepCollectionEquality()
                .equals(other._education, _education) &&
            (identical(other.auth, auth) || other.auth == auth));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userId,
        firstName,
        lastName,
        email,
        isVerified,
        serviceRole,
        industryId,
        profileImage,
        companyName,
        countryCode,
        countryNameCode,
        phone,
        association,
        companyDescription,
        location,
        referralCode,
        lastPage,
        const DeepCollectionEquality().hash(_education),
        auth
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      __$$AccountImplCopyWithImpl<_$AccountImpl>(this, _$identity);
}

abstract class _Account extends Account {
  const factory _Account(
      {final int? userId,
      final String? firstName,
      final String? lastName,
      final String? email,
      final int? isVerified,
      final int? serviceRole,
      final int? industryId,
      final String? profileImage,
      final String? companyName,
      final String? countryCode,
      final String? countryNameCode,
      final int? phone,
      final String? association,
      final String? companyDescription,
      final String? location,
      final String? referralCode,
      final String? lastPage,
      final List<EducationDTO>? education,
      final Auth? auth}) = _$AccountImpl;
  const _Account._() : super._();

  @override
  int? get userId;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  int? get isVerified;
  @override
  int? get serviceRole;
  @override
  int? get industryId;
  @override
  String? get profileImage;
  @override
  String? get companyName;
  @override
  String? get countryCode;
  @override
  String? get countryNameCode;
  @override
  int? get phone;
  @override
  String? get association;
  @override
  String? get companyDescription;
  @override
  String? get location;
  @override
  String? get referralCode;
  @override
  String? get lastPage;
  @override
  List<EducationDTO>? get education;
  @override
  Auth? get auth;
  @override
  @JsonKey(ignore: true)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Auth {
  String? get tokenType => throw _privateConstructorUsedError;
  int? get expiresIn => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthCopyWith<Auth> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthCopyWith<$Res> {
  factory $AuthCopyWith(Auth value, $Res Function(Auth) then) =
      _$AuthCopyWithImpl<$Res, Auth>;
  @useResult
  $Res call(
      {String? tokenType,
      int? expiresIn,
      String? accessToken,
      String? refreshToken});
}

/// @nodoc
class _$AuthCopyWithImpl<$Res, $Val extends Auth>
    implements $AuthCopyWith<$Res> {
  _$AuthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_value.copyWith(
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthImplCopyWith<$Res> implements $AuthCopyWith<$Res> {
  factory _$$AuthImplCopyWith(
          _$AuthImpl value, $Res Function(_$AuthImpl) then) =
      __$$AuthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? tokenType,
      int? expiresIn,
      String? accessToken,
      String? refreshToken});
}

/// @nodoc
class __$$AuthImplCopyWithImpl<$Res>
    extends _$AuthCopyWithImpl<$Res, _$AuthImpl>
    implements _$$AuthImplCopyWith<$Res> {
  __$$AuthImplCopyWithImpl(_$AuthImpl _value, $Res Function(_$AuthImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$AuthImpl(
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthImpl extends _Auth {
  const _$AuthImpl(
      {this.tokenType, this.expiresIn, this.accessToken, this.refreshToken})
      : super._();

  @override
  final String? tokenType;
  @override
  final int? expiresIn;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;

  @override
  String toString() {
    return 'Auth(tokenType: $tokenType, expiresIn: $expiresIn, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthImpl &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tokenType, expiresIn, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthImplCopyWith<_$AuthImpl> get copyWith =>
      __$$AuthImplCopyWithImpl<_$AuthImpl>(this, _$identity);
}

abstract class _Auth extends Auth {
  const factory _Auth(
      {final String? tokenType,
      final int? expiresIn,
      final String? accessToken,
      final String? refreshToken}) = _$AuthImpl;
  const _Auth._() : super._();

  @override
  String? get tokenType;
  @override
  int? get expiresIn;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$AuthImplCopyWith<_$AuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
