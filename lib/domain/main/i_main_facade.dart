import 'package:dartz/dartz.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/team_dto/team_dto.dart';

abstract class IMainFacade {
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
}
