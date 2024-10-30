import 'package:dartz/dartz.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';

abstract class IMainFacade {
  /*Future<Either<MainFailure, HealthcarePostDTO>> createPostApi({
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
  });*/
  Future<Either<MainFailure, HealthcarePostDTO>> createPostApi({
    required PostShiftDTO postShiftDetail,
  });
  Future<Either<MainFailure, HealthcarePostDTO>> updatePostApi({
    required PostShiftDTO postShiftDetail,
  });
  Future<Either<MainFailure, HealthcarePostDTO>> getPostApi({
    required int postId,
  });
  Future<Either<MainFailure, String>> deletePostApi({
    required int postId,
  });
  Future<Either<MainFailure, TeamAvailableDTO>> employerTeamCheck();

  Future<Either<MainFailure, CommonResponse>> getEmployerDashboardListAPI({
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> getContractorDashboardListAPI({
    required int page,
    int? filterType,
  });

  Future<Either<MainFailure, CommonResponse>> getViewApplicantsAPI({
    required String postId,
    required bool isTotalApplicants,
  });

  Future<Either<MainFailure, CommonResponse>> getEmployerTeamsListAPI({
    required int page,
    String? id,
  });
  Future<Either<MainFailure, List<SkillDTO>>> getUnpaidBreakListApi();
  Future<Either<MainFailure, List<SkillDTO>>> getAccomdationHoursListApi();
  Future<Either<MainFailure, HealthcarePostDTO>> createPostShiftApi(
      {required MultiShiftDTO shift});

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
  });

  Future<Either<MainFailure, List<TeamDTO>>> getTeamsList({
    int? id,
    int? page,
    int? perPage,
  });

  Future<Either<MainFailure, String>> postShiftApi({
    required int postId,
  });
  Future<Either<MainFailure, String>> createTeamApi({
    required String locationId,
    required InputEmptyOrNot teamName,
  });

  Future<Either<MainFailure, String>> updateTeamApi({
    required String locationId,
    required String teamId,
    required InputEmptyOrNot teamName,
  });

  Future<Either<MainFailure, String>> deleteTeamApi({
    required String teamId,
  });
  Future<Either<MainFailure, String>> createTeamMemberApi({
    required String teamId,
    required InputEmptyOrNot teamMemberName,
    required InputEmptyOrNot position,
    required String countryCode,
    required String countryNameCode,
    required EmailAddress email,
    required MobileNumber phoneNumber,
  });

  Future<Either<MainFailure, String>> updateTeamMemberApi({
    required String teamMemberId,
    required InputEmptyOrNot teamMemberName,
    required InputEmptyOrNot position,
    required String countryCode,
    required String countryNameCode,
    required EmailAddress email,
    required MobileNumber phoneNumber,
  });
  Future<Either<MainFailure, String>> deleteTeamMemberApi({
    required String teamMemberId,
  });

  Future<Either<MainFailure, CommonResponse>> chatListApi({
    required int page,
  });

  Future<Either<MainFailure, Map<String, dynamic>>> getMessage({
    required int page,
    required int id,
  });
}
