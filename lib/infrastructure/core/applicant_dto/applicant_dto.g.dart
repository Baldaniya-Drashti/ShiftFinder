// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicantDtoImpl _$$ApplicantDtoImplFromJson(Map<String, dynamic> json) =>
    _$ApplicantDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      email: json['email'] as String?,
      is_verified: (json['is_verified'] as num?)?.toInt(),
      isProfileComplete: (json['isProfileComplete'] as num?)?.toInt(),
      service_roles: (json['service_roles'] as num?)?.toInt(),
      industry_id: (json['industry_id'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      company_name: json['company_name'] as String?,
      country_code: json['country_code'] as String?,
      country_name_code: json['country_name_code'] as String?,
      phone: (json['phone'] as num?)?.toInt(),
      association_you_belong_to: json['association_you_belong_to'] as String?,
      company_description: json['company_description'] as String?,
      location: json['location'] as String?,
      referral_code: json['referral_code'] as String?,
      last_page: json['last_page'] as String?,
      education: (json['education'] as List<dynamic>?)
          ?.map((e) => EducationDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      reference: (json['reference'] as List<dynamic>?)
          ?.map((e) => ReferenceDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      document: (json['document'] as List<dynamic>?)
          ?.map((e) => DocumentDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialties_detail: (json['specialties_detail'] as List<dynamic>?)
          ?.map((e) => SpecialtiesDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      complete_profile: (json['complete_profile'] as List<dynamic>?)
          ?.map((e) => SpecialtiesDetailDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      softwares_skill_list: (json['softwares_skill_list'] as List<dynamic>?)
          ?.map((e) => CompleteProfileDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ApplicantDtoImplToJson(_$ApplicantDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'is_verified': instance.is_verified,
      'isProfileComplete': instance.isProfileComplete,
      'service_roles': instance.service_roles,
      'industry_id': instance.industry_id,
      'profile': instance.profile,
      'company_name': instance.company_name,
      'country_code': instance.country_code,
      'country_name_code': instance.country_name_code,
      'phone': instance.phone,
      'association_you_belong_to': instance.association_you_belong_to,
      'company_description': instance.company_description,
      'location': instance.location,
      'referral_code': instance.referral_code,
      'last_page': instance.last_page,
      'education': instance.education,
      'reference': instance.reference,
      'document': instance.document,
      'specialties_detail': instance.specialties_detail,
      'complete_profile': instance.complete_profile,
      'softwares_skill_list': instance.softwares_skill_list,
    };

_$CompleteProfileDtoImpl _$$CompleteProfileDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CompleteProfileDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      roles_list: (json['roles_list'] as List<dynamic>?)
          ?.map(
              (e) => CompleteProfileDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CompleteProfileDtoImplToJson(
        _$CompleteProfileDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roles_list': instance.roles_list,
    };

_$CompleteProfileDataDtoImpl _$$CompleteProfileDataDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$CompleteProfileDataDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$CompleteProfileDataDtoImplToJson(
        _$CompleteProfileDataDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$SpecialtiesDetailDtoImpl _$$SpecialtiesDetailDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$SpecialtiesDetailDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      specialtie_lists: json['specialtie_lists'] == null
          ? null
          : CompleteProfileDataDto.fromJson(
              json['specialtie_lists'] as Map<String, dynamic>),
      specialtie_lists_other: json['specialtie_lists_other'] as String?,
      experience_year: (json['experience_year'] as num?)?.toInt(),
      experience_month: (json['experience_month'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SpecialtiesDetailDtoImplToJson(
        _$SpecialtiesDetailDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specialtie_lists': instance.specialtie_lists,
      'specialtie_lists_other': instance.specialtie_lists_other,
      'experience_year': instance.experience_year,
      'experience_month': instance.experience_month,
    };
