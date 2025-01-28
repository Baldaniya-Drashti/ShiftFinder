import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shift/infrastructure/core/contractor_complete_profile_dto.dart';
import 'package:shift/infrastructure/core/document_dto/document_dto.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/infrastructure/core/experience_model/experience_dto.dart';
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart';

part 'account.freezed.dart';

@freezed
class Account with _$Account {
  const Account._();

  const factory Account(
      {int? userId,
      int? isDialogBox,
      String? firstName,
      String? lastName,
      String? email,
      int? isVerified,
      int? serviceRole,
      int? industryId,
      String? profileImage,
      int? isProfileComplete,
      String? companyName,
      String? countryCode,
      String? countryNameCode,
      int? phone,
      String? association,
      String? companyDescription,
      String? location,
      double? latitude,
      double? longitude,
      String? referralCode,
      String? lastPage,
      ContractorCompleteProfileDTO? complete_profile,
      List<EducationDTO>? education,
      List<ExperienceDTO>? experience,
      List<ReferenceDTO>? reference,
      List<DocumentDTO>? document,
      Auth? auth,
      String? your_referral_code}) = _Account;
}

@freezed
class Auth with _$Auth {
  const Auth._();
  const factory Auth({
    String? tokenType,
    int? expiresIn,
    String? accessToken,
    String? refreshToken,
  }) = _Auth;
}
