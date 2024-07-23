// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/account/account_failure.dart';
import 'package:shift/domain/account/i_account_repository.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/infrastructure/account/current_user_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';

@LazySingleton(as: IAccountRepository)
class AccountRepository extends IAccountRepository {
  final ApiService apiService;

  AccountRepository(this.apiService);

  @override
  Future<Either<AccountFailure, Account>> getCurrentUserApi() async {
    try {
      final response = await apiService.getMethod(ApiConstants.getUserInfo,
          queryParameters: {"id": getCurrentUser().userId});
      if (response != null && response.data != null) {
        final account = CurrentUserDto.fromJson(response.data).toDomain();
        setCurrentUser(account);
        return right(account);
      } else {
        return left(const AccountFailure.serverError());
      }

      //  setUserToken(account.auth?.accessToken ?? "");
      //_setUserData(account);
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, String>> addEducationApi({
    required InputEmptyOrNot programCompleted,
    required InputEmptyOrNot yearOfCompletion,
    required InputEmptyOrNot graduatingInstitution,
  }) async {
    try {
      final mapData = {
        "program_completed": programCompleted.getOrCrash(),
        "year_of_completion": yearOfCompletion.getOrCrash(),
        "graduating_institution": graduatingInstitution.getOrCrash(),
        "last_page": "Education",
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");
      final response =
          await apiService.postMethod(ApiConstants.education, mapData);
      print("Response of Add Education---> ${jsonEncode(response.data)}");
      print("Response of Add Education---> ${response.dioMessage}");

      return right(response.dioMessage ?? "");
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }

  @override
  Future<Either<AccountFailure, Account>> deleteEducationApi({
    required int educationId,
  }) async {
    try {
      final mapData = {
        "id": educationId,
      };

      print("Sending Params:---> ${jsonEncode(mapData)}");

      final response = await apiService
          .deleteMethod('${ApiConstants.destroyEducation}?id=$educationId');

      if (response != null && response.data != null) {
        final account = CurrentUserDto.fromJson(response.data).toDomain();
        return right(account);
      } else {
        return left(const AccountFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              AccountFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const AccountFailure.networkError());
      }

      return left(const AccountFailure.serverError());
    }
  }
}
