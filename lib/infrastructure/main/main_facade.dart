// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/api_constants.dart';
import 'package:shift/domain/main/i_main_facade.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/account/account_repository.dart';
import 'package:shift/infrastructure/contractor_main/earning/earning_statement_dto/earning_statement_dto.dart';
import 'package:shift/infrastructure/contractor_main/earning/get_balance_dto/get_balance_dto.dart';
import 'package:shift/infrastructure/contractor_main/earning/statement_dto/statement_dto.dart';
import 'package:shift/infrastructure/contractor_main/profile/my_calendar_dto/my_calendar_dto.dart';
import 'package:shift/infrastructure/contractor_main/profile/performance_insight_dto/performance_insight_dto.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/chat/chat_response.dart';
import 'package:shift/infrastructure/core/chat/upload_media_response.dart';
import 'package:shift/infrastructure/core/employer_invoice_dto/employer_invoice_dto.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/network/injectable_module.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/payment_card_detail_dto/payment_card_detail_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';

@LazySingleton(as: IMainFacade)
class MainFacade implements IMainFacade {
  final ApiService apiService;
  static const int _perPage = 25;

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
  /*@override
  Future<Either<MainFailure, HealthcarePostDTO>> createPostApi(
      {required String roleListId,
      required String specialityDetailId,
      required String specialityDetailOther,
      required String softwareSkillId,
      required String softwareSkillOther,
      required String languageListId,
      required String languageOther,
      required String locationId,
      required String locationUnit,
      required double rateHour}) async {
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
      final res = await apiService.postMethod(ApiConstants.createPost, mapData);
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
*/

  @override
  Future<Either<MainFailure, CommonResponse>> updateLongFullTermPost(
      {required Map<String, dynamic> data}) async {
    try {
      if (data["terms_document"] != null && data["post_type"] == 1) {
        if (data["terms_document"].contains("https")) {
          data.remove("terms_document");
        }
      }

      final formData = FormData.fromMap(data);

      if (data["terms_document"] != null) {
        var multipartFile =
            await MultipartFile.fromFile(data["terms_document"]);
        formData.files.add(MapEntry("terms_document", multipartFile));
      }

      final res = await apiService.postMethod(
        ApiConstants.updateLongFullTermPost,
        {},
        formData: formData,
        isMultipart: true,
      );

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> getEmployerPositionDetail(
      {required int id, required int postType}) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.getEmployerLongFullTermPost,
        queryParameters: {
          "id": id,
          "post_type": postType,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> getEmployerFullPosition(
      {required int page}) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerDashboardLongFullTermPost,
        queryParameters: {
          "post_type": 2,
          "page": page,
          "perPage": 10,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> employerApplicantsReject(
      {required int id}) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerLongTermApplicantsAcceptReject,
        queryParameters: {"id": id, "request": 2},
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> employerApplicantsAccept(
      {required int id}) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerLongTermApplicantsAcceptReject,
        queryParameters: {"id": id, "request": 1},
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> contractorDashboardLongPost({
    required int page,
    required int positionsType,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorDashboardLongFullTermPost,
        queryParameters: {
          "post_type": 1,
          "page": page,
          "perPage": 10,
          "positions_type": positionsType
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, List<SkillDTO>>> getScriptVolumeListApi() async {
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
      {required MultiShiftDTO shift}) async {
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
      final res = await apiService.getMethod(
        "${ApiConstants.updatePostStatus}/$postId",
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
  Future<Either<MainFailure, HealthcarePostDTO>> createPostApi({
    required PostShiftDTO postShiftDetail,
  }) async {
    try {
      Map<String, dynamic> mapData = postShiftDetail.toJson();

      print("Sending Multi Date->  ${jsonEncode(postShiftDetail.multi_date)}");
      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.postMethod(ApiConstants.createPost, mapData);
      final data = HealthcarePostDTO.fromJson(res.data);
      print("Healthercare Post Response->  ${data.shift_detail}");
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
  Future<Either<MainFailure, CommonResponse>> updatePostApi({
    required PostShiftDTO postShiftDetail,
  }) async {
    try {
      Map<String, dynamic> mapData = postShiftDetail.toJson();

      print("Sending Multi Date->  ${postShiftDetail}");
      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.postMethod(ApiConstants.updatePost, mapData);
      print("Posttt Healthcare->  ${res}");

      final data = HealthcarePostDTO.fromJson(res.data);
      print("Healthercare Update Post Response->  ${data}");
      // return right(data);
      return right(res);
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
  Future<Either<MainFailure, HealthcarePostDTO>> getPostApi({
    required int postId,
  }) async {
    try {
      Map<String, dynamic> mapData = {'id': postId};

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.getMethod(ApiConstants.getPost,
          queryParameters: mapData);
      if (res != null) {
        final data = HealthcarePostDTO.fromJson(res.data);
        print("Healthercare Post Response->  ${data}");
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
  Future<Either<MainFailure, String>> deletePostApi({
    required int postId,
  }) async {
    try {
      // Map<String, dynamic> mapData = {'id': postId};

      print("Sending Data->  ${postId}");
      final res =
          await apiService.deleteMethod("${ApiConstants.deletePost}/$postId");
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
  Future<Either<MainFailure, TeamAvailableDTO>> employerTeamCheck() async {
    try {
      final res = await apiService.getMethod(ApiConstants.employerTeamCheck);
      if (res != null) {
        final data = TeamAvailableDTO.fromJson(res.data);
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
  Future<Either<MainFailure, CommonResponse>>
      dontShowEmployerTeamDialog() async {
    try {
      final res = await apiService.getMethod(ApiConstants.employerTeamDialog);
      if (res != null) {
        await AccountRepository(ApiService()).getCurrentUserApi();

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
      {required int page, String? id}) async {
    try {
      Map<String, dynamic> mapData = {
        'page': page,
        'perPage': _perPage,
      };

      if (id != null) {
        mapData.addAll({
          'id': id,
        });
      }

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

  @override
  Future<Either<MainFailure, String>> updateTeamMemberApi({
    required String teamMemberId,
    required InputEmptyOrNot teamMemberName,
    required InputEmptyOrNot position,
    required String countryCode,
    required String countryNameCode,
    required EmailAddress email,
    required MobileNumber phoneNumber,
    required String teamId,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        "name": teamMemberName.getValue(),
        "position": position.getValue(),
        "country_code": countryCode,
        "country_name_code": countryNameCode,
        "phone": phoneNumber.getValue(),
        "email": email.getValue(),
        "team_id": teamId,
      };

      final res = await apiService.putMethod(
        "${ApiConstants.updateTeamMember}/$teamMemberId",
        data: mapData,
      );

      return right(res?.dioMessage ?? "");
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
  Future<Either<MainFailure, String>> deleteTeamMemberApi(
      {required String teamMemberId}) async {
    try {
      final res = await apiService.deleteMethod(
        "${ApiConstants.deleteTeamMember}/$teamMemberId",
      );

      return right(res?.dioMessage ?? "");
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
  Future<Either<MainFailure, String>> updateTeamApi(
      {required String locationId,
      required String teamId,
      required InputEmptyOrNot teamName}) async {
    try {
      Map<String, dynamic> mapData = {
        "location_id": locationId,
        "team_name": teamName.getValue()?.trim()
      };

      final res = await apiService.putMethod(
        "${ApiConstants.updateTeam}/$teamId",
        data: mapData,
      );

      return right(res?.dioMessage ?? "");
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
  Future<Either<MainFailure, String>> deleteTeamApi(
      {required String teamId}) async {
    try {
      final res = await apiService.deleteMethod(
        "${ApiConstants.deleteTeam}/$teamId",
      );

      return right(res?.dioMessage ?? "");
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
  Future<Either<MainFailure, CommonResponse>> getContractorDashboardListAPI({
    required int page,
    int? filterType,
    String? search,
  }) async {
    try {
      DateTime now = DateTime.now();
      Map<String, dynamic> mapData = {
        'filter_type': filterType ?? 0,
        'page': page,
        'perPage': _perPage,
        "start_date": DateTime(now.year, now.month, now.day, 0, 0, 0)
                .toUtc()
                .millisecondsSinceEpoch /
            1000,
        "end_date": DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
                .toUtc()
                .millisecondsSinceEpoch /
            1000,
        if (search != null && search.isNotEmpty) "search": search,
      };

      final res = await apiService.getMethod(ApiConstants.contractorDashboard,
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
  Future<Either<MainFailure, String>> contractorApplyOrSendProposal({
    required Map<String, dynamic> mapData,
  }) async {
    try {
      print("Sending Data---> ${jsonEncode(mapData)}");
      // Map<String, dynamic> mapData = {
      //   'post_id': postId,
      //   'shift_type': shiftType,
      // };

      // if (shiftType == 2) {
      //   mapData.addAll({
      //     'rate_hour': rateHour,
      //     'commute_allowance': commuteAllowance,
      //     'accommodation_allowance': accommodationAllowance,
      //     'date': date,
      //     'start_time': startTime,
      //     'end_time': endTime,
      //     'multi_date': multiDate,
      //     'unavailability_date': unavailabilityDate,
      //   });
      // }

      final res = await apiService.postMethod(
        ApiConstants.contractorApplyOrSendProposal,
        mapData,
      );
      print("res.dioMessage---> ${res.dioMessage}");

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
  Future<Either<MainFailure, CommonResponse>> getContractorShifts({
    required int page,
    int? filterType,
    int? appliedType,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'filter_type': filterType ?? 0,
        if (filterType == 3) 'applied_type': appliedType,
        'page': page,
        'perPage': _perPage,
      };

      if (filterType == 1 || filterType == 2) {
        DateTime now = DateTime.now();

        mapData.addAll({
          // "start_date": DateTime(now.year, now.month, now.day, 5, 30, 0).toUtc().millisecondsSinceEpoch /1000,
          // "end_date": DateTime(now.year, now.month, now.day, 18, 29, 59).toUtc().millisecondsSinceEpoch /1000,
          "start_date": DateTime(now.year, now.month, now.day, 0, 0, 0)
                  .toUtc()
                  .millisecondsSinceEpoch /
              1000,
          "end_date": DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
                  .toUtc()
                  .millisecondsSinceEpoch /
              1000,
        });
      }

      final res = await apiService.getMethod(ApiConstants.contractorShifts,
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
  Future<Either<MainFailure, CommonResponse>> chatListApi(
      {required int page}) async {
    try {
      Map<String, dynamic> mapData = {
        'page': page,
        'perPage': 50,
      };

      final res = await apiService.getMethod(
        ApiConstants.getChatList,
        queryParameters: mapData,
      );
      if (res != null) {
        final list = res.data as List<dynamic>;
        res.data == null;
        res.listData = list
            .map((e) => ChatUser.fromJson(e as Map<String, dynamic>))
            .toList();
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
  Future<Either<MainFailure, CommonResponse<dynamic>>> getMessage(
      {required int page, required int id}) async {
    try {
      Map<String, dynamic> mapData = {
        'page': page,
        'perPage': 20,
        'id': id,
      };
      log('Page: $page');
      final res = await apiService.getMethod(
        ApiConstants.getMessageList,
        queryParameters: mapData,
      );
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
  Future<Either<MainFailure, CommonResponse>> submitContractorClockInClockOut(
      {required int shiftId, required int clockTime}) async {
    try {
      Map<String, dynamic> mapData = {
        'id': shiftId,
        'time': clockTime,
      };

      final res = await apiService.postMethod(
        ApiConstants.contractorClockInClockOut,
        mapData,
      );

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> deleteUpcomingShiftApi({
    required int id,
    int? isCad,
    String reason = "",
  }) async {
    try {
      Map<String, dynamic> mapData = {
        if (isCad != null) 'isCad': isCad,
        'reason': reason,
      };

      print("Sending Data->  ${mapData}");

      final res = await apiService.deleteMethod(
        "${ApiConstants.deleteUpcomingShift}/$id",
        queryParameters: mapData,
      );

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
  Future<Either<MainFailure, CommonResponse>> deleteEmployerFilledShift({
    required int id,
    int? isCad,
    String reason = "",
  }) async {
    try {
      Map<String, dynamic> mapData = {
        if (isCad != null) 'isCad': isCad,
        'reason': reason
      };

      print("Sending Data->  ${id}");

      final res = await apiService.deleteMethod(
        "${ApiConstants.deleteEmployerShift}/$id",
        queryParameters: mapData,
      );

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
  Future<Either<MainFailure, HealthcarePostDTO>> getContractorShiftDetail(
      {required int postId}) async {
    try {
      final res = await apiService.getMethod(
        "${ApiConstants.contractorShiftDetail}/$postId",
      );
      if (res != null) {
        final data = HealthcarePostDTO.fromJson(res.data);
        print("Contractor Post Response->  ${data}");
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
  Future<Either<MainFailure, CommonResponse>> getPreviousPost({
    required int type,
    required int page,
    required int sortBy,
  }) async {
    try {
      DateTime now = DateTime.now();

      Map<String, dynamic> mapData = {
        "type": type,
        "sort_by": sortBy,
        "page": page,
        "perPage": _perPage,
        "start_date": DateTime(now.year, now.month, now.day, 0, 0, 0)
                .toUtc()
                .millisecondsSinceEpoch /
            1000,
        "end_date": DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
                .toUtc()
                .millisecondsSinceEpoch /
            1000,
      };

      final res = await apiService.getMethod(ApiConstants.employerPreviousShift,
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
  Future<Either<MainFailure, CommonResponse>> getApplicantList(
      {required int postId, required int page}) async {
    try {
      final res = await apiService
          .getMethod(ApiConstants.employerApplicants, queryParameters: {
        "post_id": postId,
        "type": 1,
        "page": page,
        "perPage": 10,
      });

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
  Future<Either<MainFailure, CommonResponse>> acceptApplicant(
      {required int id}) async {
    try {
      final res = await apiService.getMethod(
          ApiConstants.employerApplicantsAcceptReject,
          queryParameters: {
            "id": id,
            "request": 1,
            'type': 1,
          });

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
  Future<Either<MainFailure, CommonResponse>> rejectApplicant(
      {required int id}) async {
    try {
      final res = await apiService.getMethod(
          ApiConstants.employerApplicantsAcceptReject,
          queryParameters: {"id": id, "request": 2, 'type': 1});

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
  Future<Either<MainFailure, CommonResponse>> revokeApplicant(
      {required int postId, required int userId}) async {
    try {
      final res = await apiService
          .getMethod(ApiConstants.employerRevoke, queryParameters: {
        "post_id": postId,
        "user_id": userId,
      });

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
  Future<Either<MainFailure, CommonResponse>> getEmployerTotalProposal(
      {required int postId, required int page}) async {
    try {
      final res = await apiService
          .getMethod(ApiConstants.employerApplicantsProposal, queryParameters: {
        "post_id": postId,
      });

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
  Future<Either<MainFailure, CommonResponse>> addFavorite({
    required int postId,
    required int userId,
  }) async {
    try {
      final res =
          await apiService.postMethod(ApiConstants.employerAddFavorite, {
        "post_id": postId,
        "user_id": userId,
      });

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> addUnFavorite({
    required int postId,
    required int userId,
  }) async {
    try {
      final res =
          await apiService.postMethod(ApiConstants.employerAddFavorite, {
        "post_id": postId,
        "user_id": userId,
      });

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> employerBlockUnblock(
      {required int postId, required int userId}) async {
    try {
      final res = await apiService.postMethod(ApiConstants.employerBlock, {
        "post_id": postId,
        "user_id": userId,
      });

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> getEmployerShift({
    required int type,
    required int locationId,
    required int shortType,
    required int page,
  }) async {
    Map<String, dynamic> mapData = {
      "type": type,
      "page": page,
      "perPage": _perPage,
      "location_id": locationId,
      "short_type": shortType,
    };
    if (type == 2 || type == 1) {
      DateTime now = DateTime.now();

      mapData.addAll({
        // "start_date": DateTime(now.year, now.month, now.day, 5, 30, 0).toUtc().millisecondsSinceEpoch /1000,
        // "end_date": DateTime(now.year, now.month, now.day, 18, 29, 59).toUtc().millisecondsSinceEpoch /1000,
        "start_date": DateTime(now.year, now.month, now.day, 0, 0, 0)
                .toUtc()
                .millisecondsSinceEpoch /
            1000,
        "end_date": DateTime(now.year, now.month, now.day, 23, 59, 59, 999)
                .toUtc()
                .millisecondsSinceEpoch /
            1000,
      });
    }

    try {
      final res = await apiService.getMethod(ApiConstants.employerShift,
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
  Future<Either<MainFailure, String>> contractorShiftUrgentActionApi({
    required int postId,
    required int urgentAction,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'id': postId,
        'urgent_action': urgentAction,
      };

      final res = await apiService.getMethod(
        ApiConstants.contractorShiftsUrgentAction,
        queryParameters: mapData,
      );
      if (res != null) {
        print("Contractor Post Response-> ${res}");
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
  Future<Either<MainFailure, CommonResponse>> getApplicantProfile(
      {required int id, required int postId, int? isLongOrFull}) async {
    try {
      final res = await apiService.getMethod(
        ApiConstants.contractorUser,
        queryParameters: {
          "user_id": id,
          "post_id": postId,
          if (isLongOrFull != null) "isLongOrFull": isLongOrFull
        },
      );
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
  Future<Either<MainFailure, List<MyCalendarDTO>>>
      getMyCalendarListApi() async {
    try {
      final res = await apiService.getMethod(
        ApiConstants.contractorMyCalendar,
      );
      if (res != null) {
        var account = res.data as List<dynamic>;
        var data = account.map((e) => MyCalendarDTO.fromJson(e)).toList();
        print("My Calendar List Response->  $data");

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
  Future<Either<MainFailure, ContractorMyCalendarDTO>>
      getContractorMyCalendarDetailApi(String id, int? date) async {
    try {
      Map<String, dynamic> mapData = {
        'id': id,
      };

      if (date != null) {
        mapData.addAll({
          'date': date,
        });
      }
      final res = await apiService.getMethod(
        ApiConstants.contractorMyCalendarDetails,
        queryParameters: mapData,
      );
      if (res != null) {
        print("My Calendar Contractor Detail Response-> ${res.data}");
        final data = ContractorMyCalendarDTO.fromJson(res.data);
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
  Future<Either<MainFailure, CommonResponse>> getProposalDetail(
      {required int userId, required int postId}) async {
    try {
      final res = await apiService.getMethod(
        ApiConstants.employerApplicantsProposal,
        queryParameters: {"post_id": postId, "user_id": userId},
      );
      if (res != null) {
        // final data = TotalProposalDto.fromJson(res.data);
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
  Future<Either<MainFailure, CommonResponse>> proposalAcceptReject(
      {required int id, required int request}) async {
    ///request = [1 -> Accept, 2 -> Reject]
    try {
      final res = await apiService.getMethod(
        ApiConstants.employerApplicantsAcceptReject,
        queryParameters: {"id": id, "request": request, 'type': 2},
      );
      if (res != null) {
        // final data = TotalProposalDto.fromJson(res.data);
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
  Future<Either<MainFailure, CommonResponse>>
      sendEmployerApplicantsCounterPropose({
    required int id,
    required num counterRateHour,
    required int commuteAllowanceType,
    required int accommodationAllowanceType,
    required num counterCommuteAllowance,
    required num counterAccommodationAllowance,
  }) async {
    try {
      final res = await apiService
          .postMethod(ApiConstants.employerApplicantsCounterPropose, {
        "id": id,
        "counter_rate_hour": counterRateHour,
        "commute_allowance_type": commuteAllowanceType,
        "accommodation_allowance_type": accommodationAllowanceType,
        "counter_commute_allowance": counterCommuteAllowance,
        "counter_accommodation_allowance": counterAccommodationAllowance,
      });
      // final data = TotalProposalDto.fromJson(res.data);
      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> getHiredContractorList(
      {required int postId, required int page}) async {
    ///TOdo: Set Api EndPoint
    try {
      final res = await apiService.getMethod("", queryParameters: {
        "post_id": postId,
        "page": page,
        "perPage": _perPage,
      });
      // final data = TotalProposalDto.fromJson(res.data);
      if (res != null) {
        return right(res);
      }
      return left(const MainFailure.serverError());
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
  Future<Either<MainFailure, CommonResponse>> employerAddRemark({
    required int userId,
    required int postId,
    required String remark,
  }) async {
    try {
      final res = await apiService.postMethod(ApiConstants.employerAddRemark, {
        "user_id": userId,
        "post_id": postId,
        "remark": remark,
      });
      // final data = TotalProposalDto.fromJson(res.data);
      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> hiredContractorList({
    required int postId,
    required int shortType,
    required int page,
  }) async {
    try {
      final res = await apiService.getMethod(
          "${ApiConstants.getEmployerShiftUser}/$postId",
          queryParameters: {
            "page": page,
            "perPage": _perPage,
            "short_type": shortType,
          });

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
  Future<Either<MainFailure, CommonResponse>> hiredCancelledContractorList({
    required int postId,
    required int shortType,
    required int page,
  }) async {
    try {
      final res = await apiService.getMethod(
          "${ApiConstants.getEmployerDeleteShiftUser}/$postId",
          queryParameters: {
            "page": page,
            "perPage": _perPage,
            "short_type": shortType
          });

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
  Future<Either<MainFailure, CommonResponse>> deleteRemark(
      {required int id}) async {
    try {
      final res = await apiService.deleteMethod(
        "${ApiConstants.destroyRemark}/$id",
      );

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
  Future<Either<MainFailure, CommonResponse>> addEmployerRating({
    required int userId,
    required int postId,
    required int rating,
  }) async {
    try {
      final res = await apiService.postMethod(
        ApiConstants.employerRating,
        {"user_id": userId, "post_id": postId, "rating": rating},
      );

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> submitEmployerClockInClockOut({
    required int shiftId,
    required int? clockInTime,
    required int? clockOutTime,
    required int userId,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'id': shiftId,
        'user_id': userId,
        'clock_in': clockInTime,
        'clock_out': clockOutTime,
      };

      final res =
          await apiService.postMethod(ApiConstants.employerClockInOut, mapData);

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> submitSupportTicket(
      {required Map<String, dynamic> map}) async {
    try {
      final formData = FormData.fromMap(map);
      if (map.containsKey("attachment")) {
        var multipartFile = await MultipartFile.fromFile(map['attachment']);
        formData.files.add(MapEntry('attachment', multipartFile));
      }
      final res = await apiService.postMethod(
        ApiConstants.submitTicket,
        {},
        formData: formData,
        isMultipart: true,
      );

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> getLocationListApi() async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.getLocation,
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> getLocationDetail(
      {required int id}) async {
    try {
      final response = await apiService
          .getMethod(ApiConstants.getLocation, queryParameters: {"id": id});

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> deleteLocation(
      {required int id}) async {
    try {
      final response = await apiService.deleteMethod(
        ApiConstants.destroyLocation,
        queryParameters: {"id": id},
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> updateLocation(
      {required int id}) async {
    try {
      final response = await apiService.deleteMethod(
        ApiConstants.destroyLocation,
        queryParameters: {"id": id},
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> getEmployerApprovedShiftUser({
    required int postId,
    required int userId,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.getEmployerApprovedShiftUser,
        queryParameters: {"post_id": postId, "user_id": userId},
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> getContractorRatings(
      {required int page}) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorRating,
        queryParameters: {"page": page, "perPage": 10},
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> getContractorPreviousShift({
    required int type,
    required int page,
    int? sortBy,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorPreviousShift,
        queryParameters: {
          'type': type,
          if (sortBy != null) 'sort_by': sortBy,
          "page": page,
          "perPage": _perPage,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> addCardAPI(
      {required String paymentMethodId}) async {
    try {
      Map<String, dynamic> mapData = {
        "payment_method_id": paymentMethodId,
      };
      final response = await apiService.postMethod(
        ApiConstants.addPaymentCard,
        mapData,
      );

      return right(response);
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
  Future<Either<MainFailure, CommonResponse>> employerSavedTemplate({
    required int page,
    String? search,
    required int shiftType,
    int? sameOrDifferentTime,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        "page": page,
        "perPage": 10,
        if (search != null) "search": search,
        "shift_type": shiftType,
        if (sameOrDifferentTime != null)
          "same_or_different_time": sameOrDifferentTime
      };
      final response = await apiService.getMethod(
        ApiConstants.employerSavedTemplates,
        queryParameters: mapData,
      );
      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> deleteEmployerSavedTemplate({
    required int id,
    required int shiftType,
  }) async {
    try {
      final response = await apiService.deleteMethod(
        "${ApiConstants.destroyEmployerSavedTemplates}/$id",
        queryParameters: {
          'shift_type': shiftType,
        },
      );
      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, List<PaymentCardDTO>>> getCardListAPI() async {
    try {
      final res = await apiService.getMethod(
        ApiConstants.getPaymetCardList,
      );
      if (res != null) {
        var account = res.data as List<dynamic>;
        var data = account.map((e) => PaymentCardDTO.fromJson(e)).toList();
        print("Payment Card List Response->  $data");

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
  Future<Either<MainFailure, CommonResponse>> getFaqList({
    required int page,
  }) async {
    Map<String, dynamic> mapData = {
      "page": page,
      "perPage": _perPage,
    };
    try {
      final res = await apiService.getMethod(
        ApiConstants.faqsList,
        queryParameters: mapData,
      );
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
  Future<Either<MainFailure, String>> deletePaymentCardAPI(
      {required int id}) async {
    try {
      final res = await apiService.deleteMethod(
        "${ApiConstants.deletePaymentCard}/$id",
      );
      return right(res?.dioMessage ?? "");
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
  Future<Either<MainFailure, PerformanceInsightDTO>>
      getPerformanceInsightListAPI({required int date}) async {
    try {
      Map<String, dynamic> mapData = {
        "period": date,
      };

      final res = await apiService.getMethod(
        ApiConstants.contractorPerformanceInsights,
        queryParameters: mapData,
      );
      print("Response of insights---> ${res}");

      if (res != null) {
        final data = PerformanceInsightDTO.fromJson(res.data);

        // print("Response of insightss---> ${data}");
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
  Future<Either<MainFailure, HealthcarePostDTO>> getSendProposalDetailApi({
    required int? id,
    required int postId,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        if (id != null) 'id': id,
        'post_id': postId,
      };

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.getMethod(ApiConstants.getSendProposalDetail,
          queryParameters: mapData);
      if (res != null) {
        final data = HealthcarePostDTO.fromJson(res.data);
        print("Healthercare Post Response->  ${data}");
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
  Future<Either<MainFailure, CommonResponse>> getReferCollegueAPI({
    required int page,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorReferColleague,
        queryParameters: {
          "page": page,
          "perPage": _perPage,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, ApplicantDto>> getReferrealContractorInfoApi({
    required int id,
  }) async {
    try {
      final response = await apiService
          .getMethod(ApiConstants.getUserInfo, queryParameters: {"id": id});
      if (response != null && response.data != null) {
        final account = ApplicantDto.fromJson(response.data);
        return right(account);
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
      }
      return left(const MainFailure.serverError());
    }
  }

  @override
  Future<Either<MainFailure, CommonResponse>> getPaymentHistoryAPI({
    required int page,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerPaymentHistory,
        queryParameters: {
          "page": page,
          "perPage": _perPage,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> getEmployerInvoiceAPI({
    required int page,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerInvoices,
        queryParameters: {
          "page": page,
          "perPage": _perPage,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, MonthlyStatementDTO>>
      getEmployerMonthlyStatementAPI({
    required double? startDate,
    required double? endDate,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'start_date': (startDate != null)
            ? startDate
            : DateTime.now().toUtc().millisecondsSinceEpoch / 1000,
        'end_date': (endDate != null)
            ? endDate
            : DateTime.now().toUtc().millisecondsSinceEpoch / 1000,
      };

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.getMethod(
        ApiConstants.employerMonthlyStatements,
        queryParameters: mapData,
      );
      if (res != null) {
        final data = MonthlyStatementDTO.fromJson(res.data);
        print("Monthly Statement Response->  ${data}");
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
  Future<Either<MainFailure, EmployerInvoiceDTO>> getInvoiceDetailAPI({
    required int id,
  }) async {
    try {
      Map<String, dynamic> mapData = {'id': id};

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.getMethod(
        ApiConstants.employerInvoices,
        queryParameters: mapData,
      );
      if (res != null) {
        final data = EmployerInvoiceDTO.fromJson(res.data);
        print("Invoice Response->  ${data}");
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
  Future<Either<MainFailure, EarningStatementDTO>> totalEarningStatementAPI({
    int? statementFilter,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorTotalEarningStatement,
        queryParameters: {
          if (statementFilter != null) "statements_filter": statementFilter,
          "start_date": startDate,
          "end_date": endDate,
        },
      );

      if (response != null) {
        final data = EarningStatementDTO.fromJson(response.data);
        print("Monthly Statement Response->  ${data}");
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
  Future<Either<MainFailure, StatementDTO>> statementAPI({
    required int? statementFilter,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorTotalEarningStatement,
        queryParameters: {
          "statements_filter": statementFilter,
          "start_date": startDate,
          "end_date": endDate,
        },
      );

      if (response != null) {
        final data = StatementDTO.fromJson(response.data);
        print("Statement Response-> ${data}");
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
  Future<Either<MainFailure, CommonResponse>> getEmployerLongTermPosition(
      {required int positionType, required int page}) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerDashboardLongFullTermPost,
        queryParameters: {
          "post_type": 1,
          "positions_type": positionType,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> createLongFullTermPost(
      {required Map<String, dynamic> data}) async {
    try {
      final formData = FormData.fromMap(data);
      if (data["terms_document"] != null &&
          data["terms_document"].isNotEmpty &&
          !data["terms_document"].contains('http')) {
        print("id from template----> ${data['terms_document']}");

        var multipartFile =
            await MultipartFile.fromFile(data['terms_document']);
        formData.files.add(MapEntry('terms_document', multipartFile));
      } else if (data["terms_document"] != null &&
          data["terms_document"].isNotEmpty &&
          data["terms_document"].contains('http')) {
        print("id from template---->111 ${data['terms_document']}");

        formData.fields.add(MapEntry('terms_document', data["terms_document"]));
      }

      print("====>formData${formData.fields.map((e) {
        if (e.key == 'save_template_status') {
          print("File Key of terms: ${e.key}, File Value: ${e.value}");
        }
        return e;
      }).toList()}");

      /*  if (documentFile.isNotEmpty && !documentFile.contains('http')) {
        var multipartFile = await MultipartFile.fromFile(
          documentFile,
        );
        formData.files.add(MapEntry('file', multipartFile));
      } */
      final res = await apiService.postMethod(
        ApiConstants.createLongFullTermPost,
        {},
        formData: formData,
        isMultipart: true,
      );

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> employerLongTermDashboard({
    required int positionsType,
    required int page,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerDashboardLongFullTermPost,
        queryParameters: {
          "post_type": 1,
          "positions_type": positionsType,
          "page": page,
          "perPage": 10,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> updateLongTermStatus(
      {required int id}) async {
    try {
      final response = await apiService.getMethod(
        "${ApiConstants.employerUpdateLongFullPostTermStatus}/$id",
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>>
      getEmployerLongTermPositionApplicants(
          {required int id, required int page}) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.employerLongFullTermApplicants,
        queryParameters: {
          "post_id": id,
          "page": page,
          "perPage": 10,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> deleteLongTermPost(
      {required int id}) async {
    try {
      final response = await apiService.deleteMethod(
        "${ApiConstants.deleteLongFullTermPost}/$id",
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, GetBalanceDTO>> getAvailableBalanceApi() async {
    try {
      final res = await apiService.getMethod(
        ApiConstants.contractorGetBalance,
      );
      if (res != null) {
        final data = GetBalanceDTO.fromJson(res.data);
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
  Future<Either<MainFailure, CommonResponse>> getWalletListAPI({
    int? filterType,
    String? startDate,
    String? endDate,
    int? page,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'filter_type': filterType,
        'start_date': startDate,
        'end_date': endDate,
        'page': page,
        'perPage': _perPage,
      };

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.getMethod(ApiConstants.contractorWallet,
          queryParameters: mapData);
      if (res != null) {
        // var account = res.data as List<dynamic>;
        // var data = account.map((e) => ContractorWalletDTO.fromJson(e)).toList();
        // print("Get Wallet List Response->  $data");

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
  Future<Either<MainFailure, CommonResponse>> contractorWithdrawAmount({
    double? amount,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        'amount': amount,
      };

      print("Sending Data->  ${jsonEncode(mapData)}");
      final res = await apiService.postMethod(
          ApiConstants.contractorWithdrawAmount, mapData);

      // var account = res.data as List<dynamic>;
      // var data = account.map((e) => ContractorWalletDTO.fromJson(e)).toList();
      // print("Get Wallet List Response->  $data");

      return right(res);
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
  Future<Either<MainFailure, CommonResponse>> contractorDashboardFullPost({
    required int page,
    required int positionsType,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.contractorDashboardLongFullTermPost,
        queryParameters: {
          "post_type": 2,
          "page": page,
          "perPage": 10,
          "positions_type": positionsType
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> contractorApplyLongFullPost({
    required int id,
  }) async {
    try {
      final response = await apiService.getMethod(
        "${ApiConstants.contractorApplyForLongFullTermPost}/${id}",
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>>
      contractorLongFullConfirmAccpetence(
          {required int id, required int urgent_action}) async {
    try {
      final response = await apiService.getMethod(
          ApiConstants.contractorLongFulTermShiftConfirmAcceptance,
          queryParameters: {
            "id": id,
            "urgent_action": urgent_action,
          });

      if (response != null) {
        return right(response);
      }
      return left(const MainFailure.serverError());
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
  Future<Either<MainFailure, UploadMediaResponse>> getDocumentLink({
    required FormData formData,
  }) async {
    try {
      final res = await apiService.postMethod(
        ApiConstants.chatUploadMedia,
        {},
        formData: formData,
        isMultipart: true,
      );
      if (res.data != null) {
        return right(UploadMediaResponse.fromJson(res.data));
      } else {
        return left(const MainFailure.serverError());
      }
    } catch (e) {
      return left(const MainFailure.serverError());
    }
  }

  @override
  Future<Either<MainFailure, CommonResponse>> getNotificationAPI({
    required int page,
  }) async {
    try {
      final response = await apiService.getMethod(
        ApiConstants.notifications,
        queryParameters: {
          "page": page,
          "perPage": 100,
        },
      );

      if (response != null) {
        return right(response);
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
  Future<Either<MainFailure, CommonResponse>> getEmployerCompletedPost({
    required int type,
    required int page,
    required int sortBy,
  }) async {
    try {
      Map<String, dynamic> mapData = {
        "location_id": sortBy,
        "page": page,
        "perPage": _perPage,
      };

      final res = await apiService.getMethod(ApiConstants.employerCompleteShift,
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
}
