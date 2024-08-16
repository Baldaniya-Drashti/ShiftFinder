import 'package:dartz/dartz.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
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
  Future<Either<MainFailure, CommonResponse>> getEmployerDashboardListAPI({
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> getViewApplicantsAPI({
    required String postId,
    required bool isTotalApplicants,
  });
}
