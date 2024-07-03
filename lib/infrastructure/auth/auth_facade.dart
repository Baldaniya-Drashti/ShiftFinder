import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  final ApiService apiService;

  AuthFacade(this.apiService);

  @override
  Future<Either<AuthFailure, Unit>> changePassword(
      {required Password oldPassword,
      required Password newPassword,
      required Password confirmNewPassword}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> checkAuthenticated() async {
    log('getUserToken() : ${getUserToken()}');
    // getCookie returns null as a String, so it has to be checked like this.
    return getUserToken() != null;
  }

  @override
  Future<Either<AuthFailure, String>> login({
    required String countryCode,
    required EmailAddress mobileNumber,
  }) async {
    try {
      final response = await apiService.postMethod(
        ApiConstants.login,
        {
          "role": 2,
          "country_code": countryCode,
          "mobile": "9664620465",
        },
      );

      // final account = CurrentUserDto.fromJson(response.data).toDomain();
      // setRememberToken(account.rememberToken ?? "");
      // _setUserData(account);
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);
        if (commonRespose.dioMessage != null) {
          return left(
              AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AuthFailure.networkError());
      }
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, String>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, String>> register(
      {required Username firstName,
      required Username lastName,
      required String emailAddress,
      required String countryCode,
      required MobileNumber mobileNumber}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> registerForPush(
      {required String fcmToken}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, String>> resendOtp(
      {required String countryCode, required EmailAddress mobileNumber}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, String>> verifyOtp(
      {required String countryCode,
      required EmailAddress mobileNumber,
      required OTPText otp}) {
    throw UnimplementedError();
  }

  // @override
  // Future<Either<AuthFailure, String>> login({
  //   required String countryCode,
  //   required EmailAddress mobileNumber,
  // }) async {
  //   try {
  //     final response = await apiService.postMethod(
  //       ApiConstants.login,
  //       {
  //         "role": 2,
  //         "country_code": countryCode,
  //         "mobile": "9664620465",
  //       },
  //     );

  //     final account = CurrentUserDto.fromJson(response.data).toDomain();
  //     setRememberToken(account.rememberToken ?? "");
  //     _setUserData(account);
  //     return right(response.dioMessage ?? "");
  //   } on DioException catch (err) {
  //     if (err.response != null) {
  //       var commonRespose = CommonResponse.fromJson(err.response?.data);
  //       if (commonRespose.dioMessage != null) {
  //         return left(
  //             AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
  //       }
  //     } else if (err.type == DioExceptionType.connectionError) {
  //       return left(const AuthFailure.networkError());
  //     }
  //     return left(const AuthFailure.serverError());
  //   }
  // }
}
