// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shift/application/account_management/account_management_bloc.dart'
    as _i3;
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart'
    as _i60;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i35;
import 'package:shift/application/auth/contractor_auth/address_proof/address_proof_bloc.dart'
    as _i66;
import 'package:shift/application/auth/contractor_auth/background_doc_bloc/background_doc_bloc.dart'
    as _i72;
import 'package:shift/application/auth/contractor_auth/bank_details_bloc/bank_details_bloc.dart'
    as _i76;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i88;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i70;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i78;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i68;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i67;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i69;
import 'package:shift/application/auth/contractor_auth/proof__of_legal_status_bloc/proof_of_legal_status_bloc.dart'
    as _i73;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i79;
import 'package:shift/application/auth/contractor_auth/speciality_experience/speciality_experience_bloc.dart'
    as _i71;
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart'
    as _i61;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i59;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i63;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i62;
import 'package:shift/application/bloc/pick_location_dialog_bloc.dart' as _i10;
import 'package:shift/application/change_password/change_password_bloc.dart'
    as _i64;
import 'package:shift/application/chat_section/chat/chat_bloc.dart' as _i93;
import 'package:shift/application/chat_section/message/message_bloc.dart'
    as _i65;
import 'package:shift/application/chat_section/view_media/view_media_bloc.dart'
    as _i8;
import 'package:shift/application/consumer_support/support_ticket/support_ticket_bloc.dart'
    as _i34;
import 'package:shift/application/contractor/contractor_earning_bloc/contractor_earning_bloc.dart'
    as _i86;
import 'package:shift/application/contractor/contractor_edit_profile_bloc/contractor_edit_profile_bloc.dart'
    as _i99;
import 'package:shift/application/contractor/contractor_full_time_position/contractor_full_time_position_bloc.dart'
    as _i41;
import 'package:shift/application/contractor/contractor_long_time/contractor_long_term_bloc.dart'
    as _i44;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_home_bloc/contractor_home_bloc.dart'
    as _i83;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart'
    as _i37;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_notification_bloc/contractor_notification_bloc.dart'
    as _i84;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart'
    as _i82;
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart'
    as _i39;
import 'package:shift/application/contractor/contractor_performance_insight/contractor_performance_insight_bloc.dart'
    as _i43;
import 'package:shift/application/contractor/contractor_previous_shift/contractor_previous_shift_bloc.dart'
    as _i80;
import 'package:shift/application/contractor/contractor_rating/contractor_rating_bloc.dart'
    as _i42;
import 'package:shift/application/contractor/contractor_statement/contractor_statement_bloc.dart'
    as _i85;
import 'package:shift/application/contractor/contractor_wallet/contractor_wallet_bloc.dart'
    as _i81;
import 'package:shift/application/contractor/full_time_position/full_time_position_bloc.dart'
    as _i5;
import 'package:shift/application/contractor/full_time_position_detail/full_time_position_detail_bloc.dart'
    as _i4;
import 'package:shift/application/contractor/my_calendar_view_bloc/my_calendar_view_bloc.dart'
    as _i40;
import 'package:shift/application/contractor/refer_colleague/refer_colleague_bloc.dart'
    as _i87;
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart'
    as _i98;
import 'package:shift/application/employer/billing/payment_method_bloc/payment_method_bloc.dart'
    as _i55;
import 'package:shift/application/employer/counter_proposal_detail/counter_proposal_detail_bloc.dart'
    as _i50;
import 'package:shift/application/employer/employer_full_position_detail/employer_full_position_detail_bloc.dart'
    as _i24;
import 'package:shift/application/employer/employer_full_posting/employer_full_posting_bloc.dart'
    as _i21;
import 'package:shift/application/employer/employer_full_posting_applicant/employer_full_posting_applicant_bloc.dart'
    as _i23;
import 'package:shift/application/employer/employer_full_posting_confirm/employer_full_posting_confirm_bloc.dart'
    as _i22;
import 'package:shift/application/employer/employer_full_posting_review/employer_full_posting_review_bloc.dart'
    as _i46;
import 'package:shift/application/employer/employer_invoice_bloc/employer_invoice_bloc.dart'
    as _i90;
import 'package:shift/application/employer/employer_location/employer_location_bloc.dart'
    as _i54;
import 'package:shift/application/employer/employer_location_form/employer_location_form_bloc.dart'
    as _i33;
import 'package:shift/application/employer/employer_long_term/employer_long_term_bloc.dart'
    as _i26;
import 'package:shift/application/employer/employer_long_term_add/employer_long_term_add_bloc.dart'
    as _i31;
import 'package:shift/application/employer/employer_long_term_authorize_payment/employer_long_term_authorize_payment_bloc.dart'
    as _i27;
import 'package:shift/application/employer/employer_long_term_confirmation/employer_long_term_confirmation_bloc.dart'
    as _i49;
import 'package:shift/application/employer/employer_long_term_detail/employer_long_term_detail_bloc.dart'
    as _i25;
import 'package:shift/application/employer/employer_long_term_payable/employer_long_term_payable_bloc.dart'
    as _i20;
import 'package:shift/application/employer/employer_long_term_position_add_detail/employer_long_term_position_add_detail_bloc.dart'
    as _i7;
import 'package:shift/application/employer/employer_long_term_view_applicant/employer_long_term_view_applicant_bloc.dart'
    as _i19;
import 'package:shift/application/employer/hired_contractor/hired_contractor_bloc.dart'
    as _i48;
import 'package:shift/application/employer/monthly_statement/monthly_statement_bloc.dart'
    as _i91;
import 'package:shift/application/employer/payment_history/payment_history_bloc.dart'
    as _i89;
import 'package:shift/application/employer/profile/edit_profile/edit_profile_bloc.dart'
    as _i100;
import 'package:shift/application/employer/profile/employer_completed_shift_bloc/employer_completed_shift_bloc.dart'
    as _i28;
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart'
    as _i52;
import 'package:shift/application/employer/proposal/total_proposal_bloc.dart'
    as _i51;
import 'package:shift/application/employer/proposal_detail/proposal_detail_bloc.dart'
    as _i47;
import 'package:shift/application/employer/save_template/save_template_bloc.dart'
    as _i53;
import 'package:shift/application/faq/faq_bloc.dart' as _i45;
import 'package:shift/application/google_map/google_map_bloc.dart' as _i9;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i32;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i74;
import 'package:shift/application/main_tab/home/home_bloc.dart' as _i94;
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart'
    as _i57;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i36;
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart'
    as _i95;
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart'
    as _i30;
import 'package:shift/application/main_tab/shifts/agreed_proposal_bloc/agreed_proposal_bloc.dart'
    as _i96;
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart'
    as _i97;
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart'
    as _i77;
import 'package:shift/application/notification/notification_bloc.dart' as _i6;
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart' as _i38;
import 'package:shift/application/profile/account/account_cubit.dart' as _i75;
import 'package:shift/application/profile/applicant_profile/applicant_profile_bloc.dart'
    as _i56;
import 'package:shift/application/review_post_bloc/review_post_bloc.dart'
    as _i92;
import 'package:shift/application/shift_action/shift_action_bloc.dart' as _i58;
import 'package:shift/application/splash/splash_bloc.dart' as _i29;
import 'package:shift/domain/account/i_account_repository.dart' as _i15;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i13;
import 'package:shift/domain/main/i_main_facade.dart' as _i17;
import 'package:shift/infrastructure/account/account_repository.dart' as _i16;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i14;
import 'package:shift/infrastructure/core/chat/socket_chat_service.dart'
    as _i11;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i12;
import 'package:shift/infrastructure/main/main_facade.dart' as _i18;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AccountManagementBloc>(() => _i3.AccountManagementBloc());
    gh.factory<_i4.FullTimePositionDetailBloc>(
        () => _i4.FullTimePositionDetailBloc());
    gh.factory<_i5.FullTimePositionBloc>(() => _i5.FullTimePositionBloc());
    gh.factory<_i6.NotificationBloc>(() => _i6.NotificationBloc());
    gh.factory<_i7.EmployerLongTermPositionAddDetailBloc>(
        () => _i7.EmployerLongTermPositionAddDetailBloc());
    gh.factory<_i8.ViewMediaBloc>(() => _i8.ViewMediaBloc());
    gh.factory<_i9.GoogleMapBloc>(() => _i9.GoogleMapBloc());
    gh.factory<_i10.PickLocationDialogBloc>(
        () => _i10.PickLocationDialogBloc());
    gh.factory<_i11.SocketChatService>(() => _i11.SocketChatService());
    gh.lazySingleton<_i12.ApiService>(() => _i12.ApiService());
    gh.lazySingleton<_i13.IAuthFacade>(
        () => _i14.AuthFacade(gh<_i12.ApiService>()));
    gh.lazySingleton<_i15.IAccountRepository>(
        () => _i16.AccountRepository(gh<_i12.ApiService>()));
    gh.lazySingleton<_i17.IMainFacade>(
        () => _i18.MainFacade(apiService: gh<_i12.ApiService>()));
    gh.factory<_i19.EmployerLongTermViewApplicantBloc>(
        () => _i19.EmployerLongTermViewApplicantBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i20.EmployerLongTermPayableBloc>(
        () => _i20.EmployerLongTermPayableBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i21.EmployerFullPostingBloc>(
        () => _i21.EmployerFullPostingBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i22.EmployerFullPostingConfirmBloc>(
        () => _i22.EmployerFullPostingConfirmBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i23.EmployerFullPostingApplicantBloc>(
        () => _i23.EmployerFullPostingApplicantBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i24.EmployerFullPositionDetailBloc>(
        () => _i24.EmployerFullPositionDetailBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i25.EmployerLongTermDetailBloc>(
        () => _i25.EmployerLongTermDetailBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i26.EmployerLongTermBloc>(
        () => _i26.EmployerLongTermBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i27.EmployerLongTermAuthorizePaymentBloc>(() =>
        _i27.EmployerLongTermAuthorizePaymentBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i28.EmployerCompletedShiftBloc>(
        () => _i28.EmployerCompletedShiftBloc(
              gh<_i17.IMainFacade>(),
              gh<_i15.IAccountRepository>(),
            ));
    gh.factory<_i29.SplashBloc>(() => _i29.SplashBloc(
          gh<_i13.IAuthFacade>(),
          gh<_i15.IAccountRepository>(),
        ));
    gh.factory<_i30.TeamsBloc>(() => _i30.TeamsBloc(
          gh<_i17.IMainFacade>(),
          gh<_i15.IAccountRepository>(),
        ));
    gh.factory<_i31.EmployerLongTermAddBloc>(() => _i31.EmployerLongTermAddBloc(
          gh<_i13.IAuthFacade>(),
          gh<_i15.IAccountRepository>(),
          gh<_i17.IMainFacade>(),
        ));
    gh.factory<_i32.HealthcarePostBloc>(() => _i32.HealthcarePostBloc(
          gh<_i13.IAuthFacade>(),
          gh<_i15.IAccountRepository>(),
          gh<_i17.IMainFacade>(),
        ));
    gh.factory<_i33.EmployerLocationFormBloc>(
        () => _i33.EmployerLocationFormBloc(
              gh<_i15.IAccountRepository>(),
              gh<_i17.IMainFacade>(),
            ));
    gh.factory<_i34.SupportTicketBloc>(() => _i34.SupportTicketBloc(
          gh<_i15.IAccountRepository>(),
          gh<_i17.IMainFacade>(),
        ));
    gh.factory<_i35.AddContractorSkillFormBloc>(
        () => _i35.AddContractorSkillFormBloc(
              gh<_i13.IAuthFacade>(),
              gh<_i15.IAccountRepository>(),
            ));
    gh.factory<_i36.MainTabBloc>(() => _i36.MainTabBloc(
          gh<_i13.IAuthFacade>(),
          gh<_i17.IMainFacade>(),
        ));
    gh.factory<_i37.ContractorMainTabBloc>(
        () => _i37.ContractorMainTabBloc(gh<_i13.IAuthFacade>()));
    gh.factory<_i38.PostShiftBloc>(
        () => _i38.PostShiftBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i39.SendProposalBloc>(
        () => _i39.SendProposalBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i40.MyCalendarViewBloc>(
        () => _i40.MyCalendarViewBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i41.ContractorFullTimePositionBloc>(
        () => _i41.ContractorFullTimePositionBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i42.ContractorRatingBloc>(
        () => _i42.ContractorRatingBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i43.ContractorPerformanceInsightBloc>(
        () => _i43.ContractorPerformanceInsightBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i44.ContractorLongTermBloc>(
        () => _i44.ContractorLongTermBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i45.FaqBloc>(() => _i45.FaqBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i46.EmployerFullPostingReviewBloc>(
        () => _i46.EmployerFullPostingReviewBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i47.ProposalDetailBloc>(
        () => _i47.ProposalDetailBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i48.HiredContractorBloc>(
        () => _i48.HiredContractorBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i49.EmployerLongTermConfirmationBloc>(
        () => _i49.EmployerLongTermConfirmationBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i50.CounterProposalDetailBloc>(
        () => _i50.CounterProposalDetailBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i51.TotalProposalBloc>(
        () => _i51.TotalProposalBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i52.PreviousShiftBloc>(
        () => _i52.PreviousShiftBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i53.SaveTemplateBloc>(
        () => _i53.SaveTemplateBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i54.EmployerLocationBloc>(
        () => _i54.EmployerLocationBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i55.PaymentMethodBloc>(
        () => _i55.PaymentMethodBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i56.ApplicantProfileBloc>(
        () => _i56.ApplicantProfileBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i57.ViewSingleApplicantsBloc>(
        () => _i57.ViewSingleApplicantsBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i58.ShiftActionBloc>(
        () => _i58.ShiftActionBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i59.ForgotPasswordBloc>(
        () => _i59.ForgotPasswordBloc(gh<_i13.IAuthFacade>()));
    gh.factory<_i60.AuthStatusBloc>(
        () => _i60.AuthStatusBloc(gh<_i13.IAuthFacade>()));
    gh.factory<_i61.TermsAndConditionBloc>(
        () => _i61.TermsAndConditionBloc(gh<_i13.IAuthFacade>()));
    gh.factory<_i62.RegisterFormBloc>(
        () => _i62.RegisterFormBloc(gh<_i13.IAuthFacade>()));
    gh.factory<_i63.LoginFormBloc>(
        () => _i63.LoginFormBloc(gh<_i13.IAuthFacade>()));
    gh.factory<_i64.ChangePasswordBloc>(
        () => _i64.ChangePasswordBloc(gh<_i13.IAuthFacade>()));
    gh.factory<_i65.MessageBloc>(() => _i65.MessageBloc(
          gh<_i17.IMainFacade>(),
          gh<_i11.SocketChatService>(),
        ));
    gh.factory<_i66.AddressProofBloc>(
        () => _i66.AddressProofBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i67.IntroVideoBloc>(
        () => _i67.IntroVideoBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i68.ExperienceBloc>(
        () => _i68.ExperienceBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i69.LegalScreeningBloc>(
        () => _i69.LegalScreeningBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i70.DocumentBloc>(
        () => _i70.DocumentBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i70.CredentialBloc>(
        () => _i70.CredentialBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i70.ProfessionalLicensesBloc>(
        () => _i70.ProfessionalLicensesBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i70.ImmunizationBloc>(
        () => _i70.ImmunizationBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i70.ProfessionalLiabilityBloc>(
        () => _i70.ProfessionalLiabilityBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i70.ResumeBloc>(
        () => _i70.ResumeBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i70.EquipmentBloc>(
        () => _i70.EquipmentBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i71.SpecialityExperienceBloc>(
        () => _i71.SpecialityExperienceBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i72.BackgroundDocBloc>(
        () => _i72.BackgroundDocBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i73.ProofOfLegalStatusBloc>(
        () => _i73.ProofOfLegalStatusBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i74.LocationDetailsBloc>(
        () => _i74.LocationDetailsBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i75.AccountCubit>(
        () => _i75.AccountCubit(gh<_i15.IAccountRepository>()));
    gh.factory<_i76.BankDetailsBloc>(
        () => _i76.BankDetailsBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i77.ShiftsBloc>(() => _i77.ShiftsBloc(
          gh<_i15.IAccountRepository>(),
          gh<_i17.IMainFacade>(),
        ));
    gh.factory<_i78.EducationDetailBloc>(() => _i78.EducationDetailBloc(
          gh<_i15.IAccountRepository>(),
          gh<_i13.IAuthFacade>(),
        ));
    gh.factory<_i79.ReferenceBloc>(() => _i79.ReferenceBloc(
          gh<_i15.IAccountRepository>(),
          gh<_i13.IAuthFacade>(),
        ));
    gh.factory<_i80.ContractorPreviousShiftBloc>(
        () => _i80.ContractorPreviousShiftBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i81.ContractorWalletBloc>(
        () => _i81.ContractorWalletBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i82.ContractorShiftBloc>(
        () => _i82.ContractorShiftBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i83.ContractorHomeBloc>(
        () => _i83.ContractorHomeBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i84.ContractorNotificationBloc>(
        () => _i84.ContractorNotificationBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i85.ContractorStatementBloc>(
        () => _i85.ContractorStatementBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i86.ContractorEarningBloc>(
        () => _i86.ContractorEarningBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i87.ReferColleagueBloc>(
        () => _i87.ReferColleagueBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i88.CardBloc>(() => _i88.CardBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i89.PaymentHistoryBloc>(
        () => _i89.PaymentHistoryBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i90.EmployerInvoiceBloc>(
        () => _i90.EmployerInvoiceBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i91.MonthlyStatementBloc>(
        () => _i91.MonthlyStatementBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i92.ReviewPostBloc>(
        () => _i92.ReviewPostBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i93.ChatBloc>(() => _i93.ChatBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i94.HomeBloc>(() => _i94.HomeBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i95.AddNewMemberBloc>(
        () => _i95.AddNewMemberBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i96.AgreedProposalBloc>(
        () => _i96.AgreedProposalBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i97.HiredContractorBloc>(
        () => _i97.HiredContractorBloc(gh<_i17.IMainFacade>()));
    gh.factory<_i98.AddFullPositionBloc>(() => _i98.AddFullPositionBloc(
          gh<_i15.IAccountRepository>(),
          gh<_i17.IMainFacade>(),
          gh<_i13.IAuthFacade>(),
        ));
    gh.factory<_i99.ContractorEditProfileBloc>(
        () => _i99.ContractorEditProfileBloc(gh<_i15.IAccountRepository>()));
    gh.factory<_i100.EditProfileBloc>(
        () => _i100.EditProfileBloc(gh<_i15.IAccountRepository>()));
    return this;
  }
}
