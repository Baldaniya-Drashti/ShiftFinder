import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String baseUrl = dotenv.env['DEV_API_BASE_URL']!;

  //core
  static String registerForPush = 'register-fcm-token';
  static String contactSupport = 'contact/support';

  //auth
  static String register = 'register';
  static String login = 'login';
  static String resendOtp = 'resend_otp';
  static String verifyOtp = 'verify_otp';
  static String forgotPassword = 'forgot_password';
  static String editEmailOrPhone = 'edit_email_or_phone';
  static String logout = 'logout';
  static String editLastPage = 'edit_last_page';
  static String changePassword = 'change_password';
  static String deleteAccount = 'delete_account';

  static String getUserInfo = 'get_user_info';
  static String completeProfile = 'complete_profile';
  static String editProfile = 'edit_profile';
  static String education = 'education';
  static String updateEducation = 'update_education';
  static String destroyEducation = 'destroy_education';
  static String addRoleExperience = 'experience';
  static String addSpecialityExperience = 'your_specialtie_experience';
  static String reference = 'reference';
  static String updateReference = 'update_reference';
  static String destroyReference = 'destroy_reference';
  static String getDocument = 'get_document';
  static String document = 'document';
  static String updateDocument = 'update_document';
  static String destroyDocument = 'destroy_document';
  static String quizList = 'quiz_list';
  static String quiz = 'quiz';
  static String quizResult = 'quiz_result';
  static String location = 'location';
  static String getLocation = 'get_location';
  static String facilityTypeList = 'facility_type_list';

  static String legalScreeningQuestionList = 'legal_screening_question_list';
  static String legalScreeningQuestionAnswer =
      'legal_screening_question_answer';

// Common
  static String roleList = 'role_list';
  static String specialtieList = 'specialtie_list';
  static String experienceList = 'experience_list';
  static String softwaresSkillList = 'softwares_skill_list';
  static String languageList = 'language_list';
  static String getYourRolesList = 'get_your_roles_list';
  static String getYourSpecialityList = 'get_your_specialtie_list';
  static String unpaidBreakList = 'unpaid_break_list';
  static String accomdationHourList = 'hour_list';

  /// Healthcare Post
  static String getPost = 'get_post';
  static String deletePost = 'delete_post';
  static String createPost = 'create_post';
  static String updatePost = 'update_post';
  static String createPostShift = 'create_post_shift';
  static String createPostShiftAddMore = 'create_post_shift_add_more';
  static String updatePostStatus = 'update_post_status';

  /// Teams
  static String getTeam = 'get_team';
  static String employerTeamCheck = 'employer_team_check';
  static String employerTeamDialog = 'employer_team_dialog';

  //payment methods
  static String addPaymentCard = 'employer_add_card';
  static String getPaymetCardList = 'employer_list_card';
  static String deletePaymentCard = 'employer_delete_card';
  static String employerPaymentHistory = 'employer_payment_history';
  static String employerInvoices = 'employer_invoices';
  static String employerMonthlyStatements = 'employer_monthly_statements';

  /// Stripe doc
  static String stripeDocument = 'stripe_document';
  static String contractorConnectAccount = 'contractor_connect_account';

  //chat
  static String getChatList = 'chat-list';
  static String getMessageList = 'chat';

  //employer dashboard
  static String employerDashboard = 'employer_dashboard';

  //contractor dashboard
  static String contractorDashboard = 'contractor_dashboard';
  static String contractorApplyOrSendProposal =
      'contractor_apply_or_send_proposal';

  //contractor shift
  static String contractorShifts = 'contractor_shifts';
  static String contractorShiftDetail = 'contractor_shifts_details';
  static String contractorClockInClockOut = 'contractor_clock_in_or_out';
  static String deleteUpcomingShift = 'contractor_shift';
  static String contractorShiftsUrgentAction =
      'contractor_shifts_urgent_action';
  static String contractorMyCalendar = 'contractor_my_calendar';
  static String contractorMyCalendarDetails = 'contractor_my_calendar_details';
  static String getSendProposalDetail = 'send_proposal';
  static String contractorPerformanceInsights =
      'contractor_performance_insights';
  static String contractorTotalEarningStatement =
      'contractor_total_earning_statement';

  //team
  static String getTeamList = 'get_team';
  static String createTeam = 'create_team';
  static String createTeamMember = 'create_team_member';
  static String updateTeamMember = 'update_team_member';
  static String deleteTeamMember = 'delete_team_member';
  static String updateTeam = 'update_team';
  static String deleteTeam = 'delete_team';

  static String employerPreviousShift = 'employer_previous_shift';
  static String employerApplicants = 'employer_applicants';
  static String employerApplicantsAcceptReject =
      'employer_applicants_accept_reject';
  static String employerRating = 'employer_rating';
  static String employerRemark = 'employer_remark';
  static String employerAddFavorite = 'employer_favorite';
  static String deleteRemark = 'destroy_remark';
  static String employerBlock = 'employer_block';
  static String employerFavorite = 'employer_favorite';
  static String employerRevoke = 'employer_applicants_revoke';
  static String employerShift = 'get_employer_shift';
  static String deleteEmployerShift = 'employer_shift';
  static String getEmployerShiftUser = 'get_employer_shift_user';
  static String getEmployerDeleteShiftUser = 'get_employer_delete_shift_user';
  static String employerClockInOut = 'employer_clock_in_or_out';
  static String submitTicket = 'submit_ticket';
  static String contractorUser = 'contractor_user';
  static String employerApplicantsProposal = 'employer_applicants_proposal';
  static String employerApplicantsCounterPropose =
      'employer_applicants_counter_propose';
  static String employerAddRemark = 'employer_remark';
  static String destroyRemark = 'destroy_remark';
  static String destroyLocation = 'destroy_location';
  static String updateLocation = 'update_location';
  static String getEmployerApprovedShiftUser =
      'get_employer_approved_shift_user';
  static String contractorRating = 'contractor_rating';
  static String contractorPreviousShift = 'contractor_previous_shift';
  static String contractorReferColleague = 'contractor_refer_a_colleague';
  static String faqsList = 'faqs';
}
