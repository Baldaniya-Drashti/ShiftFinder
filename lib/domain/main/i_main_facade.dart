import 'package:dartz/dartz.dart';
import 'package:shift/application/faq/faq_bloc.dart';
import 'package:shift/domain/account/account.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/main/main_failure.dart';
import 'package:shift/infrastructure/contractor_main/profile/my_calendar_dto/my_calendar_dto.dart';
import 'package:shift/infrastructure/core/applicant_dto/applicant_dto.dart';
import 'package:shift/infrastructure/core/employer_applicant/employer_applicant_dto.dart';
import 'package:shift/infrastructure/core/employer_invoice_dto/employer_invoice_dto.dart';
import 'package:shift/infrastructure/core/monthly_statement_dto/monthly_statement_dto.dart';
import 'package:shift/infrastructure/core/network/common_response.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart';
import 'package:shift/infrastructure/main/payment_card_detail_dto/payment_card_detail_dto.dart';
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

  Future<Either<MainFailure, CommonResponse>> updatePostApi({
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

  Future<Either<MainFailure, HealthcarePostDTO>> createPostShiftApi({required MultiShiftDTO shift});

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

  Future<Either<MainFailure, String>> contractorApplyOrSendProposal({
    required Map<String, dynamic> mapData,
  });

  Future<Either<MainFailure, CommonResponse>> getContractorShifts({
    required int page,
    int? filterType,
    int? appliedType,
  });

  Future<Either<MainFailure, CommonResponse>> getPreviousPost({
    required int page,
    required int type,
    required int sortBy,
  });

  Future<Either<MainFailure, CommonResponse>> submitContractorClockInClockOut(
      {required int shiftId, required int clockTime});

  Future<Either<MainFailure, CommonResponse>> deleteUpcomingShiftApi({
    required int id,
    int? isCad,
    String reason = "",
  });

  Future<Either<MainFailure, HealthcarePostDTO>> getContractorShiftDetail({required int postId});

  Future<Either<MainFailure, String>> contractorShiftUrgentActionApi({required int postId, required int urgentAction});

  Future<Either<MainFailure, List<MyCalendarDTO>>> getMyCalendarListApi();

  Future<Either<MainFailure, ContractorMyCalendarDTO>> getContractorMyCalendarDetailApi(String id, int? date);

  Future<Either<MainFailure, CommonResponse>> getApplicantList({
    required int postId,
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> acceptApplicant({
    required int id,
  });

  Future<Either<MainFailure, CommonResponse>> rejectApplicant({
    required int id,
  });

  Future<Either<MainFailure, CommonResponse>> revokeApplicant({
    required int postId,
    required int userId,
  });

  Future<Either<MainFailure, CommonResponse>> getEmployerTotalProposal({
    required int postId,
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> addFavorite({
    required int postId,
    required int userId,
  });

  Future<Either<MainFailure, CommonResponse>> addUnFavorite({
    required int postId,
    required int userId,
  });

  Future<Either<MainFailure, CommonResponse>> employerBlockUnblock({
    required int postId,
    required int userId,
  });

  Future<Either<MainFailure, CommonResponse>> getEmployerShift({
    required int type,
    required int locationId,
    required int shortType,
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> getApplicantProfile({
    required int id,
    required int postId,
  });

  Future<Either<MainFailure, CommonResponse>> getProposalDetail({
    required int userId,
    required int postId,
  });

  Future<Either<MainFailure, CommonResponse>> proposalAcceptReject({
    required int id,
    required int request,
  });

  Future<Either<MainFailure, CommonResponse>> sendEmployerApplicantsCounterPropose({
    required int id,
    required num counterRateHour,
    required int commuteAllowanceType,
    required int accommodationAllowanceType,
    required num counterCommuteAllowance,
    required num counterAccommodationAllowance,
  });

  Future<Either<MainFailure, CommonResponse>> getHiredContractorList({
    required int postId,
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> employerAddRemark({
    required int userId,
    required int postId,
    required String remark,
  });

  Future<Either<MainFailure, CommonResponse>> deleteEmployerFilledShift({
    required int id,
    int? isCad,
    String reason = "",
  });

  Future<Either<MainFailure, CommonResponse>> hiredContractorList({
    required int postId,
    required int shortType,
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> hiredCancelledContractorList({
    required int postId,
    required int shortType,
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> deleteRemark({
    required int id,
  });

  Future<Either<MainFailure, CommonResponse>> addEmployerRating({
    required int userId,
    required int postId,
    required int rating,
  });

  Future<Either<MainFailure, CommonResponse>> submitEmployerClockInClockOut({
    required int shiftId,
    required int? clockInTime,
    required int? clockOutTime,
    required int userId,
  });

  Future<Either<MainFailure, CommonResponse>> dontShowEmployerTeamDialog();

  Future<Either<MainFailure, CommonResponse>> submitSupportTicket({
    required Map<String, dynamic> map,
  });

  Future<Either<MainFailure, CommonResponse>> getLocationListApi();

  Future<Either<MainFailure, CommonResponse>> getLocationDetail({required int id});

  Future<Either<MainFailure, CommonResponse>> updateLocation({required int id});

  Future<Either<MainFailure, CommonResponse>> deleteLocation({required int id});

  Future<Either<MainFailure, CommonResponse>> getEmployerApprovedShiftUser({
    required int postId,
    required int userId,
  });

  Future<Either<MainFailure, CommonResponse>> getContractorRatings({
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> getContractorPreviousShift({
    required int type,
    required int page,
    int? sortBy,
  });

  Future<Either<MainFailure, CommonResponse>> addCardAPI({required String paymentMethodId});

  Future<Either<MainFailure, List<PaymentCardDTO>>> getCardListAPI();

  Future<Either<MainFailure, CommonResponse>> getFaqList({
    required int page,
  });

  Future<Either<MainFailure, String>> deletePaymentCardAPI({required int id});
  Future<Either<MainFailure, CommonResponse>> getPerformanceInsightListAPI(
      {required double date});

  Future<Either<MainFailure, HealthcarePostDTO>> getSendProposalDetailApi({
    required int? id,
    required int postId,
  });

  Future<Either<MainFailure, CommonResponse>> getReferCollegueAPI({
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> employerSavedTemplate({
    required int page,
    String? search,
    required int shiftType,
    int? sameOrDifferentTime,
  });

  Future<Either<MainFailure, CommonResponse>> deleteEmployerSavedTemplate({
    required int id,
  });

  Future<Either<MainFailure, ApplicantDto>> getReferrealContractorInfoApi({
    required int id,
  });

  Future<Either<MainFailure, CommonResponse>> getPaymentHistoryAPI({
    required int page,
  });

  Future<Either<MainFailure, CommonResponse>> getEmployerInvoiceAPI({
    required int page,
  });

  Future<Either<MainFailure, MonthlyStatementDTO>> getEmployerMonthlyStatementAPI({
    required double? startDate,
    required double? endDate,
  });

  Future<Either<MainFailure, EmployerInvoiceDTO>> getInvoiceDetailAPI({
    required int id,
  });

  Future<Either<MainFailure, CommonResponse>> totalEarningStatementAPI({
    required String startDate,
    required String endDate,
  });

  Future<Either<MainFailure, List<SkillDTO>>> getScriptVolumeListApi();

  Future<Either<MainFailure, CommonResponse>> getEmployerLongTermPosition({
    required int positionType,
    required int page,
  });



  Future<Either<MainFailure, CommonResponse>> createLongFullTermPost({
    required Map<String,dynamic> data
  });

  Future<Either<MainFailure, CommonResponse>> employerLongTermDashboard({
    required int positionsType,
    required int page,
  });
}
