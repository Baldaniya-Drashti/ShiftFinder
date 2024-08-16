// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';

@LazySingleton(as: IMainFacade)
class MainFacade implements IMainFacade {
  final ApiService apiService;
  // static const int _perPage = 25;

  MainFacade({required this.apiService});

  /*@override
  Future<Either<MainFailure, CommonResponse>> createPostApi({
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

      return right(res);
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
  }*/

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
      print("Healthercare Post Response->  ${data}");

      return right(data);
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
  Future<Either<MainFailure, List<SkillDTO>>> getUnpaidBreakListApi() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.unpaidBreakList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        print("UnPaid Break List Response---> $list");
        return right(list);
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
  Future<Either<MainFailure, List<SkillDTO>>>
      getAccomdationHoursListApi() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.accomdationHourList,
      );

      if (response != null) {
        var account = response.data as List<dynamic>;
        var list = account.map((e) => SkillDTO.fromJson(e)).toList();

        print("Accomdation List Response---> $list");
        return right(list);
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
  Future<Either<MainFailure, HealthcarePostDTO>> createPostShiftApi(
      {
      // required int postId,
      // required int shiftType,
      // required String date,
      // required int sameOrDifferentTime,
      // required String multiDate,
      // required String startTime,
      // required String endTime,
      // required int unpaidBreakId,
      // required String totalPayableHour,
      // required int commuteAllowanceType,
      // required String commuteAllowance,
      // required int accommodationAllowanceType,
      // required String accommodationAllowance,
      // required int individualShift,
      // required String shiftNote,
      // required int vacancieType,
      // required int numberOfVacancie,

      required MultiShiftDTO shift}) async {
    List<Map<String, dynamic>> mapMultiDateToApiFormat() {
      print("passShiftData111---> ${shift.multi_date}");

      if (shift.multi_date != null && shift.multi_date!.isNotEmpty) {
        return shift.multi_date!.map((multiDate) {
          return {
            'date': multiDate.date,
            'start_time': DateTime.parse((shift.same_or_different_time == 1)
                        ? shift.start_time ?? ""
                        : multiDate.start_time ?? "")
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000,
            'end_time': DateTime.parse((shift.same_or_different_time == 1)
                        ? shift.end_time ?? ""
                        : multiDate.end_time ?? "")
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000
          };
        }).toList();
      } else {
        return [];
      }
    }

    try {
      Map<String, dynamic> mapData = {
        'post_id': 22,
        'shift_type': shift.shift_type,
        'unpaid_break_id': shift.unpaid_break_id,
        'total_payable_hour': shift.total_payable_hour,
        'commute_allowance_type': shift.commute_allowance_type,
        'accommodation_allowance_type': shift.accommodation_allowance_type,
        'vacancie_type': shift.vacancie_type,
      };

      if (shift.shift_type == 1) {
        mapData.addAll({
          'date':
              DateTime.parse(shift.date ?? "").toUtc().millisecondsSinceEpoch /
                  1000,
          'start_time': DateTime.parse(shift.start_time ?? "")
                  .toUtc()
                  .millisecondsSinceEpoch /
              1000,
          'end_time': DateTime.parse(shift.end_time ?? "")
                  .toUtc()
                  .millisecondsSinceEpoch /
              1000,
        });
      } else if (shift.shift_type == 2) {
        mapData.addAll({
          'same_or_different_time': shift.same_or_different_time,
          'multi_date': mapMultiDateToApiFormat(),
          'individual_shift': shift.individual_shift,
        });
      }

      if (shift.commute_allowance != null &&
          shift.commute_allowance!.isNotEmpty) {
        mapData.addAll({
          'commute_allowance': shift.commute_allowance,
        });
      }
      if (shift.accommodation_allowance != null &&
          shift.accommodation_allowance!.isNotEmpty) {
        mapData.addAll({
          'accommodation_allowance': shift.accommodation_allowance,
        });
      }

      if (shift.shift_note != null && shift.shift_note!.isNotEmpty) {
        mapData.addAll({
          'shift_note': shift.shift_note,
        });
      }

      if (shift.number_of_vacancie != null) {
        mapData.addAll({
          'number_of_vacancie': shift.number_of_vacancie,
        });
      }

      print("Sending Data->  ${jsonEncode(mapData)}");

      final res = await apiService.postMethod(
        ApiConstants.createPostShift,
        mapData,
      );

      final data = HealthcarePostDTO.fromJson(res.data);
      print("Healthercare Shift Post Response->  $data");

      return right(data);
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
}
