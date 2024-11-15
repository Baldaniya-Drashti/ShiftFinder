// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CurrentUserDtoImpl _$$CurrentUserDtoImplFromJson(Map<String, dynamic> json) =>
    _$CurrentUserDtoImpl(
      userId: (json['id'] as num?)?.toInt(),
      isDialogBox: (json['isDialogBox'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      isVerified: (json['is_verified'] as num?)?.toInt(),
      serviceRole: (json['service_roles'] as num?)?.toInt(),
      industryId: (json['industry_id'] as num?)?.toInt(),
      profileImage: json['profile'] as String?,
      isProfileComplete: (json['isProfileComplete'] as num?)?.toInt(),
      companyName: json['company_name'] as String?,
      countryCode: json['country_code'] as String?,
      countryNameCode: json['country_name_code'] as String?,
      phone: (json['phone'] as num?)?.toInt(),
      association: json['association_you_belong_to'] as String?,
      companyDescription: json['company_description'] as String?,
      location: json['location'] as String?,
      referralCode: json['referral_code'] as String?,
      lastPage: json['last_page'] as String?,
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => EducationDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      reference: (json['reference'] as List<dynamic>?)
          ?.map((e) => ReferenceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      document: (json['document'] as List<dynamic>?)
          ?.map((e) => DocumentDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      authDto: json['auth'] == null
          ? null
          : AuthDto.fromJson(json['auth'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CurrentUserDtoImplToJson(
        _$CurrentUserDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'isDialogBox': instance.isDialogBox,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'is_verified': instance.isVerified,
      'service_roles': instance.serviceRole,
      'industry_id': instance.industryId,
      'profile': instance.profileImage,
      'isProfileComplete': instance.isProfileComplete,
      'company_name': instance.companyName,
      'country_code': instance.countryCode,
      'country_name_code': instance.countryNameCode,
      'phone': instance.phone,
      'association_you_belong_to': instance.association,
      'company_description': instance.companyDescription,
      'location': instance.location,
      'referral_code': instance.referralCode,
      'last_page': instance.lastPage,
      'education': instance.education,
      'reference': instance.reference,
      'document': instance.document,
      'auth': instance.authDto,
    };

_$AuthDtoImpl _$$AuthDtoImplFromJson(Map<String, dynamic> json) =>
    _$AuthDtoImpl(
      tokenType: json['token_type'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toInt(),
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$$AuthDtoImplToJson(_$AuthDtoImpl instance) =>
    <String, dynamic>{
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
