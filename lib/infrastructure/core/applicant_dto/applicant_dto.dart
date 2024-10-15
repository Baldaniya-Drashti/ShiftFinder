import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';

part 'applicant_dto.freezed.dart';

part 'applicant_dto.g.dart';

@freezed
class ApplicantDto with _$ApplicantDto {
  const factory ApplicantDto({
    int? id,
    String? first_name,
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
    String? referral_code,
    String? last_page,
    List<EducationDTO>? education,
    List<ReferenceDTO>? reference,
    List<DocumentDTO>? document,
    List<SpecialtiesDetailDto>? specialties_detail,
    List<SpecialtiesDetailDto>? complete_profile,
    List<CompleteProfileDto>? softwares_skill_list,
  }) = _ApplicantDto;

  factory ApplicantDto.fromJson(Map<String, dynamic> json) => _$ApplicantDtoFromJson(json);
}

@freezed
class CompleteProfileDto with _$CompleteProfileDto {
  const factory CompleteProfileDto({
    int? id,
    List<CompleteProfileDataDto>? roles_list,
  }) = _CompleteProfileDto;

  factory CompleteProfileDto.fromJson(Map<String, dynamic> json) => _$CompleteProfileDtoFromJson(json);
}

@freezed
class CompleteProfileDataDto with _$CompleteProfileDataDto {
  const factory CompleteProfileDataDto({
    int? id,
    String? name,
  }) = _CompleteProfileDataDto;

  factory CompleteProfileDataDto.fromJson(Map<String, dynamic> json) => _$CompleteProfileDataDtoFromJson(json);
}


@freezed
class SpecialtiesDetailDto with _$SpecialtiesDetailDto {
  const factory SpecialtiesDetailDto({
    int? id,
    CompleteProfileDataDto? specialtie_lists,
    String? specialtie_lists_other,
    int? experience_year,
    int? experience_month,
  }) = _SpecialtiesDetailDto;

  factory SpecialtiesDetailDto.fromJson(Map<String, dynamic> json) => _$SpecialtiesDetailDtoFromJson(json);
}