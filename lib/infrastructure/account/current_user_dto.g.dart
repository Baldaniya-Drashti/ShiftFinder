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
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      referralCode: json['referral_code'] as String?,
      lastPage: json['last_page'] as String?,
      complete_profile: json['complete_profile'] == null
          ? null
          : ContractorCompleteProfileDTO.fromJson(
              json['complete_profile'] as Map<String, dynamic>),
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => EducationDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      experience: (json['experience'] as List<dynamic>?)
          ?.map((e) => ExperienceDTO.fromJson(e as Map<String, dynamic>))
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
      your_referral_code: json['your_referral_code'] as String?,
      legal_screening_question_answer:
          (json['legal_screening_question_answer'] as List<dynamic>?)
              ?.map((e) =>
                  LegalScreeningAnswerDTO.fromJson(e as Map<String, dynamic>))
              .toList(),
      location_detail: (json['location_detail'] as List<dynamic>?)
          ?.map((e) => LocationDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      isUserEnable: (json['isUserEnable'] as num?)?.toInt(),
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
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'referral_code': instance.referralCode,
      'last_page': instance.lastPage,
      'complete_profile': instance.complete_profile,
      'education': instance.education,
      'experience': instance.experience,
      'reference': instance.reference,
      'document': instance.document,
      'auth': instance.authDto,
      'your_referral_code': instance.your_referral_code,
      'legal_screening_question_answer':
          instance.legal_screening_question_answer,
      'location_detail': instance.location_detail,
      'isUserEnable': instance.isUserEnable,
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
