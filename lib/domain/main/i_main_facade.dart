import 'package:dartz/dartz.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';

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
}
