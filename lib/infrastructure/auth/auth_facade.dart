// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:shift/domain/auth/auth_failure.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/auth/i_auth_facade.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/infrastructure/account/current_user_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  var logger = Logger();

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
  Future<Either<AuthFailure, String>> register({
    required Username firstName,
    required Username lastName,
    required int check_terms_privacy,
    required InputEmptyOrNot companyName,
    required String countryCode,
    required MobileNumber phoneNumber,
    required EmailAddress email,
    required Password password,
    required ConfirmPassword confirmPassword,
    required String profileImage,

    /// if current user is employer
    required String? association,
    required String? companyDescription,

    /// if current user is contractor
    required String? referralCode,
    required String? locationAddress,
  }) async {
    try {
      var formData = FormData.fromMap({
        "service_roles": getCurrentRole(),
        "industry_id": getCurrentIndustry(),
        "country_code": countryCode,
        "first_name": firstName.getOrCrash(),
        "last_name": lastName.getOrCrash(),
        "check_terms_privacy": check_terms_privacy,
        "email": email.getOrCrash(),
        "password": password.getOrCrash(),
        "password_confirmation": confirmPassword.getOrCrash(),
        "company_name": companyName.getOrCrash(),
        "phone": phoneNumber.getOrCrash(),
        "association_you_belong_to": association,
        "company_description": companyDescription,
        "location": locationAddress,
        "referral_code": referralCode,
        "last_page": 1,
      });
      // var formData = FormData.fromMap({
      //   "service_roles": 2,
      //   "industry_id": 2,
      //   "country_code": "",
      //   "first_name": "karan",
      //   "last_name": "gajjar",
      //   "check_terms_privacy": 1,
      //   "email": "karan2@mailinator.com",
      //   "password": "12345678",
      //   "password_confirmation": "12345678",
      //   "company_name": "iroid",
      //   "phone": "1234567895",
      //   "association_you_belong_to": "",
      //   "company_description": "",
      //   "location": "",
      //   "referral_code": "",
      //   "last_page": 1,
      // });

      // logger.d('formData: ${jsonEncode(formData)}');

      logger.d('formData : ${formData.fields.map((e) => e)}');
      // log('role : ${getCurrentRole()} \n ${getCurrentIndustry()}');
      // log('');

      if (profileImage.isNotEmpty) {
        var multipartFile = await MultipartFile.fromFile(
          profileImage,
          filename: 'profile.png',
          headers: {
            'contentType': ['image/png'],
          },
        );
        formData.files.add(MapEntry('profile', multipartFile));
      }

      // print('formData after add image: ${formData.fields.map((e) => e)}');

      final response = await apiService.postMethod(
        ApiConstants.register,
        {},
        formData: formData,
        isMultipart: true,
      );
      logger.d("RESPONSE OF REGISTER---> ${response.data}");

      final account = CurrentUserDto.fromJson(response.data).toDomain();
      setCurrentUser(account);
      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);
        if (commonRespose.dioMessage != null) {
          return left(
              AuthFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AuthFailure.serverError());
    }
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
