// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CurrentUserDto _$CurrentUserDtoFromJson(Map<String, dynamic> json) {
  return _CurrentUserDto.fromJson(json);
}

/// @nodoc
mixin _$CurrentUserDto {
  @JsonKey(name: 'id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_verified')
  int? get isVerified => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_roles')
  int? get serviceRole => throw _privateConstructorUsedError;
  @JsonKey(name: 'industry_id')
  int? get industryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile')
  String? get profileImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_name')
  String? get companyName => throw _privateConstructorUsedError;
  @JsonKey(name: 'countryCode')
  String? get countryCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_name_code')
  String? get countryNameCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  int? get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'association_you_belong_to')
  String? get association => throw _privateConstructorUsedError;
  @JsonKey(name: 'company_description')
  String? get companyDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'location')
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'referral_code')
  String? get referralCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_page')
  String? get lastPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'education')
  List<EducationDTO>? get education => throw _privateConstructorUsedError;
  @JsonKey(name: 'reference')
  List<ReferenceDTO>? get reference => throw _privateConstructorUsedError;
  @JsonKey(name: 'document')
  List<DocumentDTO>? get document => throw _privateConstructorUsedError;
  @JsonKey(name: 'auth')
  AuthDto? get authDto => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentUserDtoCopyWith<CurrentUserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentUserDtoCopyWith<$Res> {
  factory $CurrentUserDtoCopyWith(
          CurrentUserDto value, $Res Function(CurrentUserDto) then) =
      _$CurrentUserDtoCopyWithImpl<$Res, CurrentUserDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? userId,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'is_verified') int? isVerified,
      @JsonKey(name: 'service_roles') int? serviceRole,
      @JsonKey(name: 'industry_id') int? industryId,
      @JsonKey(name: 'profile') String? profileImage,
      @JsonKey(name: 'company_name') String? companyName,
      @JsonKey(name: 'countryCode') String? countryCode,
      @JsonKey(name: 'country_name_code') String? countryNameCode,
      @JsonKey(name: 'phone') int? phone,
      @JsonKey(name: 'association_you_belong_to') String? association,
      @JsonKey(name: 'company_description') String? companyDescription,
      @JsonKey(name: 'location') String? location,
      @JsonKey(name: 'referral_code') String? referralCode,
      @JsonKey(name: 'last_page') String? lastPage,
      @JsonKey(name: 'education') List<EducationDTO>? education,
      @JsonKey(name: 'reference') List<ReferenceDTO>? reference,
      @JsonKey(name: 'document') List<DocumentDTO>? document,
      @JsonKey(name: 'auth') AuthDto? authDto});

  $AuthDtoCopyWith<$Res>? get authDto;
}

/// @nodoc
class _$CurrentUserDtoCopyWithImpl<$Res, $Val extends CurrentUserDto>
    implements $CurrentUserDtoCopyWith<$Res> {
  _$CurrentUserDtoCopyWithImpl(this._value, this._then);

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
    Object? reference = freezed,
    Object? document = freezed,
    Object? authDto = freezed,
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
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as List<ReferenceDTO>?,
      document: freezed == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as List<DocumentDTO>?,
      authDto: freezed == authDto
          ? _value.authDto
          : authDto // ignore: cast_nullable_to_non_nullable
              as AuthDto?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthDtoCopyWith<$Res>? get authDto {
    if (_value.authDto == null) {
      return null;
    }

    return $AuthDtoCopyWith<$Res>(_value.authDto!, (value) {
      return _then(_value.copyWith(authDto: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CurrentUserDtoImplCopyWith<$Res>
    implements $CurrentUserDtoCopyWith<$Res> {
  factory _$$CurrentUserDtoImplCopyWith(_$CurrentUserDtoImpl value,
          $Res Function(_$CurrentUserDtoImpl) then) =
      __$$CurrentUserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? userId,
      @JsonKey(name: 'first_name') String? firstName,
      @JsonKey(name: 'last_name') String? lastName,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'is_verified') int? isVerified,
      @JsonKey(name: 'service_roles') int? serviceRole,
      @JsonKey(name: 'industry_id') int? industryId,
      @JsonKey(name: 'profile') String? profileImage,
      @JsonKey(name: 'company_name') String? companyName,
      @JsonKey(name: 'countryCode') String? countryCode,
      @JsonKey(name: 'country_name_code') String? countryNameCode,
      @JsonKey(name: 'phone') int? phone,
      @JsonKey(name: 'association_you_belong_to') String? association,
      @JsonKey(name: 'company_description') String? companyDescription,
      @JsonKey(name: 'location') String? location,
      @JsonKey(name: 'referral_code') String? referralCode,
      @JsonKey(name: 'last_page') String? lastPage,
      @JsonKey(name: 'education') List<EducationDTO>? education,
      @JsonKey(name: 'reference') List<ReferenceDTO>? reference,
      @JsonKey(name: 'document') List<DocumentDTO>? document,
      @JsonKey(name: 'auth') AuthDto? authDto});

  @override
  $AuthDtoCopyWith<$Res>? get authDto;
}

/// @nodoc
class __$$CurrentUserDtoImplCopyWithImpl<$Res>
    extends _$CurrentUserDtoCopyWithImpl<$Res, _$CurrentUserDtoImpl>
    implements _$$CurrentUserDtoImplCopyWith<$Res> {
  __$$CurrentUserDtoImplCopyWithImpl(
      _$CurrentUserDtoImpl _value, $Res Function(_$CurrentUserDtoImpl) _then)
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
    Object? reference = freezed,
    Object? document = freezed,
    Object? authDto = freezed,
  }) {
    return _then(_$CurrentUserDtoImpl(
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
      reference: freezed == reference
          ? _value._reference
          : reference // ignore: cast_nullable_to_non_nullable
              as List<ReferenceDTO>?,
      document: freezed == document
          ? _value._document
          : document // ignore: cast_nullable_to_non_nullable
              as List<DocumentDTO>?,
      authDto: freezed == authDto
          ? _value.authDto
          : authDto // ignore: cast_nullable_to_non_nullable
              as AuthDto?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentUserDtoImpl extends _CurrentUserDto {
  const _$CurrentUserDtoImpl(
      {@JsonKey(name: 'id') this.userId,
      @JsonKey(name: 'first_name') this.firstName,
      @JsonKey(name: 'last_name') this.lastName,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'is_verified') this.isVerified,
      @JsonKey(name: 'service_roles') this.serviceRole,
      @JsonKey(name: 'industry_id') this.industryId,
      @JsonKey(name: 'profile') this.profileImage,
      @JsonKey(name: 'company_name') this.companyName,
      @JsonKey(name: 'countryCode') this.countryCode,
      @JsonKey(name: 'country_name_code') this.countryNameCode,
      @JsonKey(name: 'phone') this.phone,
      @JsonKey(name: 'association_you_belong_to') this.association,
      @JsonKey(name: 'company_description') this.companyDescription,
      @JsonKey(name: 'location') this.location,
      @JsonKey(name: 'referral_code') this.referralCode,
      @JsonKey(name: 'last_page') this.lastPage,
      @JsonKey(name: 'education') final List<EducationDTO>? education,
      @JsonKey(name: 'reference') final List<ReferenceDTO>? reference,
      @JsonKey(name: 'document') final List<DocumentDTO>? document,
      @JsonKey(name: 'auth') this.authDto})
      : _education = education,
        _reference = reference,
        _document = document,
        super._();

  factory _$CurrentUserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrentUserDtoImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? userId;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'is_verified')
  final int? isVerified;
  @override
  @JsonKey(name: 'service_roles')
  final int? serviceRole;
  @override
  @JsonKey(name: 'industry_id')
  final int? industryId;
  @override
  @JsonKey(name: 'profile')
  final String? profileImage;
  @override
  @JsonKey(name: 'company_name')
  final String? companyName;
  @override
  @JsonKey(name: 'countryCode')
  final String? countryCode;
  @override
  @JsonKey(name: 'country_name_code')
  final String? countryNameCode;
  @override
  @JsonKey(name: 'phone')
  final int? phone;
  @override
  @JsonKey(name: 'association_you_belong_to')
  final String? association;
  @override
  @JsonKey(name: 'company_description')
  final String? companyDescription;
  @override
  @JsonKey(name: 'location')
  final String? location;
  @override
  @JsonKey(name: 'referral_code')
  final String? referralCode;
  @override
  @JsonKey(name: 'last_page')
  final String? lastPage;
  final List<EducationDTO>? _education;
  @override
  @JsonKey(name: 'education')
  List<EducationDTO>? get education {
    final value = _education;
    if (value == null) return null;
    if (_education is EqualUnmodifiableListView) return _education;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ReferenceDTO>? _reference;
  @override
  @JsonKey(name: 'reference')
  List<ReferenceDTO>? get reference {
    final value = _reference;
    if (value == null) return null;
    if (_reference is EqualUnmodifiableListView) return _reference;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<DocumentDTO>? _document;
  @override
  @JsonKey(name: 'document')
  List<DocumentDTO>? get document {
    final value = _document;
    if (value == null) return null;
    if (_document is EqualUnmodifiableListView) return _document;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'auth')
  final AuthDto? authDto;

  @override
  String toString() {
    return 'CurrentUserDto(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, isVerified: $isVerified, serviceRole: $serviceRole, industryId: $industryId, profileImage: $profileImage, companyName: $companyName, countryCode: $countryCode, countryNameCode: $countryNameCode, phone: $phone, association: $association, companyDescription: $companyDescription, location: $location, referralCode: $referralCode, lastPage: $lastPage, education: $education, reference: $reference, document: $document, authDto: $authDto)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentUserDtoImpl &&
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
            const DeepCollectionEquality()
                .equals(other._reference, _reference) &&
            const DeepCollectionEquality().equals(other._document, _document) &&
            (identical(other.authDto, authDto) || other.authDto == authDto));
  }

  @JsonKey(ignore: true)
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
        const DeepCollectionEquality().hash(_reference),
        const DeepCollectionEquality().hash(_document),
        authDto
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentUserDtoImplCopyWith<_$CurrentUserDtoImpl> get copyWith =>
      __$$CurrentUserDtoImplCopyWithImpl<_$CurrentUserDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentUserDtoImplToJson(
      this,
    );
  }
}

abstract class _CurrentUserDto extends CurrentUserDto {
  const factory _CurrentUserDto(
      {@JsonKey(name: 'id') final int? userId,
      @JsonKey(name: 'first_name') final String? firstName,
      @JsonKey(name: 'last_name') final String? lastName,
      @JsonKey(name: 'email') final String? email,
      @JsonKey(name: 'is_verified') final int? isVerified,
      @JsonKey(name: 'service_roles') final int? serviceRole,
      @JsonKey(name: 'industry_id') final int? industryId,
      @JsonKey(name: 'profile') final String? profileImage,
      @JsonKey(name: 'company_name') final String? companyName,
      @JsonKey(name: 'countryCode') final String? countryCode,
      @JsonKey(name: 'country_name_code') final String? countryNameCode,
      @JsonKey(name: 'phone') final int? phone,
      @JsonKey(name: 'association_you_belong_to') final String? association,
      @JsonKey(name: 'company_description') final String? companyDescription,
      @JsonKey(name: 'location') final String? location,
      @JsonKey(name: 'referral_code') final String? referralCode,
      @JsonKey(name: 'last_page') final String? lastPage,
      @JsonKey(name: 'education') final List<EducationDTO>? education,
      @JsonKey(name: 'reference') final List<ReferenceDTO>? reference,
      @JsonKey(name: 'document') final List<DocumentDTO>? document,
      @JsonKey(name: 'auth') final AuthDto? authDto}) = _$CurrentUserDtoImpl;
  const _CurrentUserDto._() : super._();

  factory _CurrentUserDto.fromJson(Map<String, dynamic> json) =
      _$CurrentUserDtoImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get userId;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'is_verified')
  int? get isVerified;
  @override
  @JsonKey(name: 'service_roles')
  int? get serviceRole;
  @override
  @JsonKey(name: 'industry_id')
  int? get industryId;
  @override
  @JsonKey(name: 'profile')
  String? get profileImage;
  @override
  @JsonKey(name: 'company_name')
  String? get companyName;
  @override
  @JsonKey(name: 'countryCode')
  String? get countryCode;
  @override
  @JsonKey(name: 'country_name_code')
  String? get countryNameCode;
  @override
  @JsonKey(name: 'phone')
  int? get phone;
  @override
  @JsonKey(name: 'association_you_belong_to')
  String? get association;
  @override
  @JsonKey(name: 'company_description')
  String? get companyDescription;
  @override
  @JsonKey(name: 'location')
  String? get location;
  @override
  @JsonKey(name: 'referral_code')
  String? get referralCode;
  @override
  @JsonKey(name: 'last_page')
  String? get lastPage;
  @override
  @JsonKey(name: 'education')
  List<EducationDTO>? get education;
  @override
  @JsonKey(name: 'reference')
  List<ReferenceDTO>? get reference;
  @override
  @JsonKey(name: 'document')
  List<DocumentDTO>? get document;
  @override
  @JsonKey(name: 'auth')
  AuthDto? get authDto;
  @override
  @JsonKey(ignore: true)
  _$$CurrentUserDtoImplCopyWith<_$CurrentUserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthDto _$AuthDtoFromJson(Map<String, dynamic> json) {
  return _AuthDto.fromJson(json);
}

/// @nodoc
mixin _$AuthDto {
  @JsonKey(name: 'token_type')
  String? get tokenType => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  int? get expiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_token')
  String? get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  String? get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthDtoCopyWith<AuthDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthDtoCopyWith<$Res> {
  factory $AuthDtoCopyWith(AuthDto value, $Res Function(AuthDto) then) =
      _$AuthDtoCopyWithImpl<$Res, AuthDto>;
  @useResult
  $Res call(
      {@JsonKey(name: 'token_type') String? tokenType,
      @JsonKey(name: 'expires_in') int? expiresIn,
      @JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'refresh_token') String? refreshToken});
}

/// @nodoc
class _$AuthDtoCopyWithImpl<$Res, $Val extends AuthDto>
    implements $AuthDtoCopyWith<$Res> {
  _$AuthDtoCopyWithImpl(this._value, this._then);

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
abstract class _$$AuthDtoImplCopyWith<$Res> implements $AuthDtoCopyWith<$Res> {
  factory _$$AuthDtoImplCopyWith(
          _$AuthDtoImpl value, $Res Function(_$AuthDtoImpl) then) =
      __$$AuthDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'token_type') String? tokenType,
      @JsonKey(name: 'expires_in') int? expiresIn,
      @JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'refresh_token') String? refreshToken});
}

/// @nodoc
class __$$AuthDtoImplCopyWithImpl<$Res>
    extends _$AuthDtoCopyWithImpl<$Res, _$AuthDtoImpl>
    implements _$$AuthDtoImplCopyWith<$Res> {
  __$$AuthDtoImplCopyWithImpl(
      _$AuthDtoImpl _value, $Res Function(_$AuthDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenType = freezed,
    Object? expiresIn = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_$AuthDtoImpl(
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
@JsonSerializable()
class _$AuthDtoImpl extends _AuthDto {
  const _$AuthDtoImpl(
      {@JsonKey(name: 'token_type') this.tokenType,
      @JsonKey(name: 'expires_in') this.expiresIn,
      @JsonKey(name: 'access_token') this.accessToken,
      @JsonKey(name: 'refresh_token') this.refreshToken})
      : super._();

  factory _$AuthDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthDtoImplFromJson(json);

  @override
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @override
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  @override
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @override
  String toString() {
    return 'AuthDto(tokenType: $tokenType, expiresIn: $expiresIn, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthDtoImpl &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tokenType, expiresIn, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthDtoImplCopyWith<_$AuthDtoImpl> get copyWith =>
      __$$AuthDtoImplCopyWithImpl<_$AuthDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthDtoImplToJson(
      this,
    );
  }
}

abstract class _AuthDto extends AuthDto {
  const factory _AuthDto(
          {@JsonKey(name: 'token_type') final String? tokenType,
          @JsonKey(name: 'expires_in') final int? expiresIn,
          @JsonKey(name: 'access_token') final String? accessToken,
          @JsonKey(name: 'refresh_token') final String? refreshToken}) =
      _$AuthDtoImpl;
  const _AuthDto._() : super._();

  factory _AuthDto.fromJson(Map<String, dynamic> json) = _$AuthDtoImpl.fromJson;

  @override
  @JsonKey(name: 'token_type')
  String? get tokenType;
  @override
  @JsonKey(name: 'expires_in')
  int? get expiresIn;
  @override
  @JsonKey(name: 'access_token')
  String? get accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  String? get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$AuthDtoImplCopyWith<_$AuthDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
