// ignore_for_file: non_constant_identifier_names

import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/core/speciality/speciality_dto.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, String>> register({
    required Username firstName,
    required Username lastName,
    required int check_terms_privacy,
    required String profileImage,
    required String? companyName,
    required String countryCode,
    required String countryFlag,
    required MobileNumber phoneNumber,
    required EmailAddress email,
    required Password password,
    required ConfirmPassword confirmPassword,

    /// if current user is employer
    required String? association,
    required String? companyDescription,

    /// if current user is contractor
    required String? referralCode,
    required String? locationAddress,
  });

  Future<Either<AuthFailure, Account>> login({
    required EmailAddress email,
    required Password password,
  });

  Future<Either<AuthFailure, Account>> addLastPageApi({
    required String lastPage,
  });

  Future<bool> checkAuthenticated();

  Future<bool> checkUserVerified();

  Future<Either<AuthFailure, String>> logout();

  Future<Either<AuthFailure, Unit>> changePassword({
    required Password oldPassword,
    required Password newPassword,
    required Password confirmNewPassword,
  });

  Future<Either<AuthFailure, Unit>> registerForPush({
    required String fcmToken,
  });

  Future<Either<AuthFailure, String>> verifyOtp({
    required String emailAddress,
    required String phoneNumber,
    required OTPText otp,
    bool isForgotPassword = false,
  });

  Future<Either<AuthFailure, String>> resendOtp({
    required String emailAddress,
    required String phoneNumber,
    bool forgotPassword = false,
  });

  Future<Either<AuthFailure, String>> forgotPassword({
    required String password,
    required String confirmPassword,
  });

  Future<Either<AuthFailure, List<SkillDTO>>> getRoleList();

  Future<Either<AuthFailure, List<SpecialityDTO>>> getSpecialityList();

  Future<Either<AuthFailure, List<SkillDTO>>> getExperienceList();

  Future<Either<AuthFailure, List<SkillDTO>>> getSoftwareSkillList();

  Future<Either<AuthFailure, List<SkillDTO>>> getLanguageList();

  Future<Either<AuthFailure, String>> completeProfileAPI({
    required String? languageOther,
    required String languageListId,
    required String softwareSkillOther,
    required String softwaresSkillListId,
    required String specialtiesDetail,
    required String specialityOther,
    required String rolesListId,
  });

  Future<Either<AuthFailure, String>> addEducationApi({
    required InputEmptyOrNot programCompleted,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot graduatingInstitution,
  });

  // Future<Either<AuthFailure, String>> deleteEducationApi({
  //   required int educationId,
  // });

  Future<Either<AuthFailure, String>> editEmailOrPhone({
    String? email,
    String? countryCode,
    String? countryNameCode,
    String? phone,
  });

  Future<Either<AuthFailure, String>> editEmployerProfile({
   required Map<String, dynamic> data,
  });
}
