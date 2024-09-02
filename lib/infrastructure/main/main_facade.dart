// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';

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
            'date': DateTime.parse(multiDate.date ?? "")
                    .toUtc()
                    .millisecondsSinceEpoch /
                1000,
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
        'post_id': shift.post_id,
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
          'multi_date': jsonEncode(mapMultiDateToApiFormat()),
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

  @override
  Future<Either<MainFailure, HealthcarePostDTO>> createPostShiftRecurringApi({
    required int postShiftId,
    required int recurringStatus,
    required String startDate,
    required int recurrenceMode,
    required String days,
    required String endDate,
    required String disclaimer,
    required int shareTeamStatus,
    required String teamId,
    required int saveTemplateStatus,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        // 'post_shift_id': postShiftId,
        'post_shift_id': postShiftId,
        'recurring_status': recurringStatus,
        'share_team_status': shareTeamStatus,
        'save_template_status': saveTemplateStatus,
      };

      if (disclaimer.isNotEmpty) {
        mapData.addAll({
          'disclaimer': disclaimer,
        });
      }

      if (recurringStatus == 1) {
        mapData.addAll({
          'start_date': startDate,
          'recurrence_mode': recurrenceMode,
          'days': days,
          'end_date': endDate,
        });
      }

      if (shareTeamStatus == 1) {
        mapData.addAll({
          'team_id': teamId,
        });
      }

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.postMethod(
        ApiConstants.createPostShiftAddMore,
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

  @override
  Future<Either<MainFailure, List<TeamDTO>>> getTeamsList({
    int? id,
    int? page,
    int? perPage,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'id': id,
        'page': page,
        'perPage': perPage ?? 60,
      };

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.getMethod(ApiConstants.getTeam,
          queryParameters: mapData);
      if (res != null) {
        var account = res.data as List<dynamic>;
        var data = account.map((e) => TeamDTO.fromJson(e)).toList();
        print("Get Team List Response->  $data");

        return right(data);
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
  Future<Either<MainFailure, String>> postShiftApi({
    required int postId,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'post_id': postId,
      };

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.putMethod(
        ApiConstants.putPostTheShift,
        data: mapData,
      );

      if (res != null) {
        return right(res.dioMessage ?? "");
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

  @override
  Future<Either<MainFailure, CommonResponse>> getEmployerTeamsListAPI(
      {required int page}) async {
    try {
      Map<String, dynamic> mapData = {
        'page': page,
        'perPage': _perPage,
      };

      final res = await apiService.getMethod(ApiConstants.getTeamList,
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
  Future<Either<MainFailure, String>> createTeamApi(
      {required String locationId, required InputEmptyOrNot teamName}) async {
    try {
      Map<String, dynamic> mapData = {
        "location_id": locationId,
        "team_name": teamName.getValue()?.trim()
      };

      final res = await apiService.postMethod(
        ApiConstants.createTeam,
        mapData,
      );

      return right(res.dioMessage ?? "");
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
  Future<Either<MainFailure, String>> createTeamMemberApi(
      {required String teamId,
      required InputEmptyOrNot teamMemberName,
      required InputEmptyOrNot position,
      required String countryCode,
      required String countryNameCode,
      required EmailAddress email,
      required MobileNumber phoneNumber}) async {
    try {
      Map<String, dynamic> mapData = {
        "team_id": teamId,
        "name": teamMemberName.getValue(),
        "position": position.getValue(),
        "country_code": countryCode,
        "country_name_code": countryNameCode,
        "phone": phoneNumber.getValue(),
        "email": email.getValue(),
      };

      final res = await apiService.postMethod(
        ApiConstants.createTeamMember,
        mapData,
      );

      return right(res.dioMessage ?? "");
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
