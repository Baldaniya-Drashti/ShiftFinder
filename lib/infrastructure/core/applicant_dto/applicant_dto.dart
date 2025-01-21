import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';

part 'applicant_dto.freezed.dart';

part 'applicant_dto.g.dart';

@freezed
class ApplicantDto with _$ApplicantDto {
  const factory ApplicantDto({
    int? id,
    String? first_name,
    String? distance,
    String? last_name,
    String? email,
    int? is_verified,
    int? isProfileComplete,
    int? service_roles,
    int? industry_id,
    String? profile,
    String? company_name,
    String? country_code,
    String? country_name_code,
    int? phone,
    String? association_you_belong_to,
    String? company_description,
    String? location,
    double? longitude,
    double? latitude,
    String? referral_code,
    String? last_page,
    CompleteProfileDto? complete_profile,
    List<EducationDTO>? education,
    List<ExperienceDTO>? experience,
    List<ReferenceDTO>? reference,
    List<DocumentDTO>? document,
  }) = _ApplicantDto;

  factory ApplicantDto.fromJson(Map<String, dynamic> json) =>
      _$ApplicantDtoFromJson(json);
}

@freezed
class CompleteProfileDto with _$CompleteProfileDto {
  const factory CompleteProfileDto({
    int? id,
    List<CompleteProfileDataDto>? roles_list,
    List<SpecialtiesDetailDto>? specialties_detail,
    List<CompleteProfileDataDto>? softwares_skill_list,
    List<CompleteProfileDataDto>? languages_list,
    String? language_other,
    String? software_skill_other,
  }) = _CompleteProfileDto;

  factory CompleteProfileDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileDtoFromJson(json);
}

@freezed
class CompleteProfileDataDto with _$CompleteProfileDataDto {
  const factory CompleteProfileDataDto({
    int? id,
    String? name,
  }) = _CompleteProfileDataDto;

  factory CompleteProfileDataDto.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileDataDtoFromJson(json);
}

@freezed
class SpecialtiesDetailDto with _$SpecialtiesDetailDto {
  const factory SpecialtiesDetailDto({
    int? id,
    // CompleteProfileDataDto? specialtie_lists,
    CompleteProfileDataDto? role,
    String? specialtie_lists_other,
    String? experience_year,
    String? experience_month,
  }) = _SpecialtiesDetailDto;

  factory SpecialtiesDetailDto.fromJson(Map<String, dynamic> json) =>
      _$SpecialtiesDetailDtoFromJson(json);
}
