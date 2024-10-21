// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart'
    as _i1033;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i471;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i1025;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i408;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i250;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i161;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i897;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i653;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i48;
import 'package:shift/application/auth/contractor_auth/speciality_experience/speciality_experience_bloc.dart'
    as _i944;
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart'
    as _i1026;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i744;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i31;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i134;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_home_bloc/contractor_home_bloc.dart'
    as _i153;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart'
    as _i400;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart'
    as _i131;
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart'
    as _i678;
import 'package:shift/application/contractor/my_calendar_view_bloc/my_calendar_view_bloc.dart'
    as _i170;
import 'package:shift/application/employer/counter_proposal_detail/counter_proposal_detail_bloc.dart'
    as _i93;
import 'package:shift/application/employer/hired_contractor/hired_contractor_bloc.dart'
    as _i119;
import 'package:shift/application/employer/profile/edit_profile/edit_profile_bloc.dart'
    as _i234;
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart'
    as _i827;
import 'package:shift/application/employer/proposal/total_proposal_bloc.dart'
    as _i819;
import 'package:shift/application/employer/proposal_detail/proposal_detail_bloc.dart'
    as _i156;
import 'package:shift/application/google_map/google_map_bloc.dart' as _i168;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i383;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i359;
import 'package:shift/application/main_tab/home/home_bloc.dart' as _i901;
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart'
    as _i518;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i73;
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart'
    as _i946;
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart'
    as _i174;
import 'package:shift/application/main_tab/shifts/agreed_proposal_bloc/agreed_proposal_bloc.dart'
    as _i353;
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart'
    as _i979;
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart'
    as _i193;
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart'
    as _i541;
import 'package:shift/application/profile/account/account_cubit.dart' as _i911;
import 'package:shift/application/profile/applicant_profile/applicant_profile_bloc.dart'
    as _i828;
import 'package:shift/application/splash/splash_bloc.dart' as _i117;
import 'package:shift/domain/account/i_account_repository.dart' as _i253;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i277;
import 'package:shift/domain/main/i_main_facade.dart' as _i111;
import 'package:shift/infrastructure/account/account_repository.dart' as _i426;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i751;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i771;
import 'package:shift/infrastructure/main/main_facade.dart' as _i198;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1025.CardBloc>(() => _i1025.CardBloc());
    gh.factory<_i168.GoogleMapBloc>(() => _i168.GoogleMapBloc());
    gh.lazySingleton<_i771.ApiService>(() => _i771.ApiService());
    gh.lazySingleton<_i277.IAuthFacade>(
        () => _i751.AuthFacade(gh<_i771.ApiService>()));
    gh.lazySingleton<_i253.IAccountRepository>(
        () => _i426.AccountRepository(gh<_i771.ApiService>()));
    gh.lazySingleton<_i111.IMainFacade>(
        () => _i198.MainFacade(apiService: gh<_i771.ApiService>()));
    gh.factory<_i117.SplashBloc>(() => _i117.SplashBloc(
          gh<_i277.IAuthFacade>(),
          gh<_i253.IAccountRepository>(),
        ));
    gh.factory<_i174.TeamsBloc>(() => _i174.TeamsBloc(
          gh<_i111.IMainFacade>(),
          gh<_i253.IAccountRepository>(),
        ));
    gh.factory<_i383.HealthcarePostBloc>(() => _i383.HealthcarePostBloc(
          gh<_i277.IAuthFacade>(),
          gh<_i253.IAccountRepository>(),
          gh<_i111.IMainFacade>(),
        ));
    gh.factory<_i400.ContractorMainTabBloc>(
        () => _i400.ContractorMainTabBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i73.MainTabBloc>(
        () => _i73.MainTabBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i541.PostShiftBloc>(
        () => _i541.PostShiftBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i678.SendProposalBloc>(
        () => _i678.SendProposalBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i170.MyCalendarViewBloc>(
        () => _i170.MyCalendarViewBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i819.TotalProposalBloc>(
        () => _i819.TotalProposalBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i827.PreviousShiftBloc>(
        () => _i827.PreviousShiftBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i828.ApplicantProfileBloc>(
        () => _i828.ApplicantProfileBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i518.ViewSingleApplicantsBloc>(
        () => _i518.ViewSingleApplicantsBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i156.ProposalDetailBloc>(
        () => _i156.ProposalDetailBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i93.CounterProposalDetailBloc>(
        () => _i93.CounterProposalDetailBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i119.HiredContractorBloc>(
        () => _i119.HiredContractorBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i744.ForgotPasswordBloc>(
        () => _i744.ForgotPasswordBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i1033.AuthStatusBloc>(
        () => _i1033.AuthStatusBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i471.AddContractorSkillFormBloc>(
        () => _i471.AddContractorSkillFormBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i1026.TermsAndConditionBloc>(
        () => _i1026.TermsAndConditionBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i134.RegisterFormBloc>(
        () => _i134.RegisterFormBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i31.LoginFormBloc>(
        () => _i31.LoginFormBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i234.EditProfileBloc>(
        () => _i234.EditProfileBloc(gh<_i277.IAuthFacade>()));
    gh.factory<_i897.IntroVideoBloc>(
        () => _i897.IntroVideoBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i161.ExperienceBloc>(
        () => _i161.ExperienceBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i653.LegalScreeningBloc>(
        () => _i653.LegalScreeningBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i408.DocumentBloc>(
        () => _i408.DocumentBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i408.CredentialBloc>(
        () => _i408.CredentialBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i408.ProfessionalLicensesBloc>(
        () => _i408.ProfessionalLicensesBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i408.ImmunizationBloc>(
        () => _i408.ImmunizationBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i408.ProfessionalLiabilityBloc>(
        () => _i408.ProfessionalLiabilityBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i408.ResumeBloc>(
        () => _i408.ResumeBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i408.EquipmentBloc>(
        () => _i408.EquipmentBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i944.SpecialityExperienceBloc>(
        () => _i944.SpecialityExperienceBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i359.LocationDetailsBloc>(
        () => _i359.LocationDetailsBloc(gh<_i253.IAccountRepository>()));
    gh.factory<_i911.AccountCubit>(
        () => _i911.AccountCubit(gh<_i253.IAccountRepository>()));
    gh.factory<_i193.ShiftsBloc>(() => _i193.ShiftsBloc(
          gh<_i253.IAccountRepository>(),
          gh<_i111.IMainFacade>(),
        ));
    gh.factory<_i250.EducationDetailBloc>(() => _i250.EducationDetailBloc(
          gh<_i253.IAccountRepository>(),
          gh<_i277.IAuthFacade>(),
        ));
    gh.factory<_i48.ReferenceBloc>(() => _i48.ReferenceBloc(
          gh<_i253.IAccountRepository>(),
          gh<_i277.IAuthFacade>(),
        ));
    gh.factory<_i131.ContractorShiftBloc>(
        () => _i131.ContractorShiftBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i153.ContractorHomeBloc>(
        () => _i153.ContractorHomeBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i901.HomeBloc>(() => _i901.HomeBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i946.AddNewMemberBloc>(
        () => _i946.AddNewMemberBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i353.AgreedProposalBloc>(
        () => _i353.AgreedProposalBloc(gh<_i111.IMainFacade>()));
    gh.factory<_i979.HiredContractorBloc>(
        () => _i979.HiredContractorBloc(gh<_i111.IMainFacade>()));
    return this;
  }
}
