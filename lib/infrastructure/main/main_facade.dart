import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';

@LazySingleton(as: IMainFacade)
class MainFacade implements IMainFacade {
  final ApiService apiService;
  static const int _perPage = 25;

  MainFacade({required this.apiService});

  @override
  Future<Either<MainFailure, HealthcarePostDTO>> createPostApi({
    required String roleListId,
    required String specialityDetailId,
    required String specialityDetailOther,
    required String softwareSkillId,
    required String softwareSkillOther,
    required String languageListId,
    required String languageOther,
    required String locationId,
    required String locationUnit,
    required double rateHour,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'roles_list_id': roleListId,
        'specialties_detail_id': specialityDetailId,
        'specialties_detail_other': specialityDetailOther,
        'softwares_skill_list_id': softwareSkillId,
        'software_skill_other': softwareSkillOther,
        'languages_list_id': languageListId,
        'language_other': languageOther,
        'location_id': locationId,
        'location_unit': locationUnit,
        'rate_hour': rateHour,
      };

      print("Sending Data->  ${jsonEncode(mapData)}");

      final res = await apiService.postMethod(
        ApiConstants.createPost,
        mapData,
      );

      final data = HealthcarePostDTO.fromJson(res.data);
      print("Healthercare Post Response->  $data");

      return right(data);
      // return left(const MainFailure.networkError());
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const MainFailure.networkError());
      }

      return left(const MainFailure.serverError());
    }
  }

  @override
  Future<Either<MainFailure, CommonResponse>> getEmployerDashboardListAPI(
      {required int page}) async {
    try {
      Map<String, dynamic> mapData = {
        'page': page,
        'perPage': _perPage,
      };
      // if (productId != null) {
      //   mapData.addAll({
      //     'is_like_list': "1",
      //     'product_id': productId,
      //   });
      // }
      final res = await apiService.getMethod(ApiConstants.employerDashboard,
          queryParameters: mapData);

      if (res != null) {
        return right(res);
      } else {
        return left(const MainFailure.serverError());
      }
    } on DioException catch (err) {
      if (err.response != null) {
        var commonRespose = CommonResponse.fromJson(err.response?.data);

        if (commonRespose.dioMessage != null) {
          return left(
              MainFailure.showAPIResponseMessage(commonRespose.dioMessage!));
        }
      } else if (err.type == DioExceptionType.connectionError) {
        return left(const MainFailure.networkError());
      }

      return left(const MainFailure.serverError());
    }
  }

  @override
  Future<Either<MainFailure, CommonResponse>> getViewApplicantsAPI(
      {required String postId, required bool isTotalApplicants}) {

    throw UnimplementedError();
  }
}
