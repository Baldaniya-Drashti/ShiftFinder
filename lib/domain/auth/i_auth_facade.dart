// ignore_for_file: non_constant_identifier_names

import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, String>> register({
    required Username firstName,
    required Username lastName,
    required int check_terms_privacy,
    required String profileImage,
    required InputEmptyOrNot companyName,
    required String countryCode,
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

  Future<Either<AuthFailure, String>> login({
    required String countryCode,
    required EmailAddress mobileNumber,
  });

  Future<bool> checkAuthenticated();

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
    required String countryCode,
    required EmailAddress mobileNumber,
    required OTPText otp,
  });
  Future<Either<AuthFailure, String>> resendOtp({
    required String countryCode,
    required EmailAddress mobileNumber,
  });
}
