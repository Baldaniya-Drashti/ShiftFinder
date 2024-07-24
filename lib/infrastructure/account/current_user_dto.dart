// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';

part 'current_user_dto.freezed.dart';
part 'current_user_dto.g.dart';

@freezed
class CurrentUserDto with _$CurrentUserDto {
  const CurrentUserDto._();
  const factory CurrentUserDto({
    @JsonKey(name: 'id') int? userId,
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
    @JsonKey(name: 'auth') AuthDto? authDto,
  }) = _CurrentUserDto;
  Account toDomain() {
    return Account(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      countryCode: countryCode,
      phone: phone,
      association: association,
      companyDescription: companyDescription,
      companyName: companyName,
      countryNameCode: countryCode,
      industryId: industryId,
      isVerified: isVerified,
      lastPage: lastPage,
      location: location,
      profileImage: profileImage,
      referralCode: referralCode,
      serviceRole: serviceRole,
      education: education,
      reference: reference,
      auth: authDto?.toDomain(),
    );
  }

  factory CurrentUserDto.fromDomain(Account account) {
    return CurrentUserDto(
      userId: account.userId,
      firstName: account.firstName,
      lastName: account.lastName,
      email: account.email,
      countryCode: account.countryCode,
      phone: account.phone,
      association: account.association,
      companyDescription: account.companyDescription,
      companyName: account.companyName,
      countryNameCode: account.countryCode,
      industryId: account.industryId,
      isVerified: account.isVerified,
      lastPage: account.lastPage,
      location: account.location,
      profileImage: account.profileImage,
      referralCode: account.referralCode,
      serviceRole: account.serviceRole,
      education: account.education,
      reference: account.reference,
      authDto: account.auth != null ? AuthDto.fromDomain(account.auth!) : null,
    );
  }
  factory CurrentUserDto.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserDtoFromJson(json);
}

@freezed
class AuthDto with _$AuthDto {
  const AuthDto._();
  const factory AuthDto({
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'expires_in') int? expiresIn,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
  }) = _AuthDto;
  Auth toDomain() {
    return Auth(
      accessToken: accessToken,
      expiresIn: expiresIn,
      refreshToken: refreshToken,
      tokenType: tokenType,
    );
  }

  factory AuthDto.fromDomain(Auth auth) {
    return AuthDto(
      tokenType: auth.tokenType,
      accessToken: auth.accessToken,
      expiresIn: auth.expiresIn,
      refreshToken: auth.refreshToken,
    );
  }
  factory AuthDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDtoFromJson(json);
}
