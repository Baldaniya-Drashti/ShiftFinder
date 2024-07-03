import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, String>> register({
    required Username firstName,
    required Username lastName,
    required String emailAddress,
    required String countryCode,
    required MobileNumber mobileNumber,
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
