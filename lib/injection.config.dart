// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shift/application/auth/auth_status/auth_status_bloc.dart'
    as _i23;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i24;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i5;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i32;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i36;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i30;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i29;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i31;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i37;
import 'package:shift/application/auth/contractor_auth/speciality_experience/speciality_experience_bloc.dart'
    as _i33;
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart'
    as _i25;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i22;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i27;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i26;
import 'package:shift/application/chat_section/chat/chat_bloc.dart' as _i39;
import 'package:shift/application/chat_section/message/message_bloc.dart'
    as _i28;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_home_bloc/contractor_home_bloc.dart'
    as _i38;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart'
    as _i18;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart'
    as _i3;
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart'
    as _i4;
import 'package:shift/application/google_map/google_map_bloc.dart' as _i6;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i17;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i34;
import 'package:shift/application/main_tab/home/home_bloc.dart' as _i40;
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart'
    as _i21;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i19;
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart'
    as _i41;
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart'
    as _i16;
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart' as _i20;
import 'package:shift/application/profile/account/account_cubit.dart' as _i35;
import 'package:shift/application/splash/splash_bloc.dart' as _i15;
import 'package:shift/domain/account/i_account_repository.dart' as _i11;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i9;
import 'package:shift/domain/main/i_main_facade.dart' as _i13;
import 'package:shift/infrastructure/account/account_repository.dart' as _i12;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i10;
import 'package:shift/infrastructure/core/chat/socket_chat_service.dart' as _i7;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i8;
import 'package:shift/infrastructure/main/main_facade.dart' as _i14;

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
    gh.factory<_i3.ContractorShiftBloc>(() => _i3.ContractorShiftBloc());
    gh.factory<_i4.SendProposalBloc>(() => _i4.SendProposalBloc());
    gh.factory<_i5.CardBloc>(() => _i5.CardBloc());
    gh.factory<_i6.GoogleMapBloc>(() => _i6.GoogleMapBloc());
    gh.factory<_i7.SocketChatService>(() => _i7.SocketChatService());
    gh.lazySingleton<_i8.ApiService>(() => _i8.ApiService());
    gh.lazySingleton<_i9.IAuthFacade>(
        () => _i10.AuthFacade(gh<_i8.ApiService>()));
    gh.lazySingleton<_i11.IAccountRepository>(
        () => _i12.AccountRepository(gh<_i8.ApiService>()));
    gh.lazySingleton<_i13.IMainFacade>(
        () => _i14.MainFacade(apiService: gh<_i8.ApiService>()));
    gh.factory<_i15.SplashBloc>(() => _i15.SplashBloc(
          gh<_i9.IAuthFacade>(),
          gh<_i11.IAccountRepository>(),
        ));
    gh.factory<_i16.TeamsBloc>(() => _i16.TeamsBloc(
          gh<_i13.IMainFacade>(),
          gh<_i11.IAccountRepository>(),
        ));
    gh.factory<_i17.HealthcarePostBloc>(() => _i17.HealthcarePostBloc(
          gh<_i9.IAuthFacade>(),
          gh<_i11.IAccountRepository>(),
          gh<_i13.IMainFacade>(),
        ));
    gh.factory<_i18.ContractorMainTabBloc>(
        () => _i18.ContractorMainTabBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i19.MainTabBloc>(() => _i19.MainTabBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i20.PostShiftBloc>(
        () => _i20.PostShiftBloc(gh<_i13.IMainFacade>()));
    gh.factory<_i21.ViewSingleApplicantsBloc>(
        () => _i21.ViewSingleApplicantsBloc(gh<_i13.IMainFacade>()));
    gh.factory<_i22.ForgotPasswordBloc>(
        () => _i22.ForgotPasswordBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i23.AuthStatusBloc>(
        () => _i23.AuthStatusBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i24.AddContractorSkillFormBloc>(
        () => _i24.AddContractorSkillFormBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i25.TermsAndConditionBloc>(
        () => _i25.TermsAndConditionBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i26.RegisterFormBloc>(
        () => _i26.RegisterFormBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i27.LoginFormBloc>(
        () => _i27.LoginFormBloc(gh<_i9.IAuthFacade>()));
    gh.factory<_i28.MessageBloc>(() => _i28.MessageBloc(
          gh<_i13.IMainFacade>(),
          gh<_i7.SocketChatService>(),
        ));
    gh.factory<_i29.IntroVideoBloc>(
        () => _i29.IntroVideoBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i30.ExperienceBloc>(
        () => _i30.ExperienceBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i31.LegalScreeningBloc>(
        () => _i31.LegalScreeningBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i32.DocumentBloc>(
        () => _i32.DocumentBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i32.ProfessionalLicensesBloc>(
        () => _i32.ProfessionalLicensesBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i32.ImmunizationBloc>(
        () => _i32.ImmunizationBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i32.ProfessionalLiabilityBloc>(
        () => _i32.ProfessionalLiabilityBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i32.ResumeBloc>(
        () => _i32.ResumeBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i32.EquipmentBloc>(
        () => _i32.EquipmentBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i33.SpecialityExperienceBloc>(
        () => _i33.SpecialityExperienceBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i34.LocationDetailsBloc>(
        () => _i34.LocationDetailsBloc(gh<_i11.IAccountRepository>()));
    gh.factory<_i35.AccountCubit>(
        () => _i35.AccountCubit(gh<_i11.IAccountRepository>()));
    gh.factory<_i36.EducationDetailBloc>(() => _i36.EducationDetailBloc(
          gh<_i11.IAccountRepository>(),
          gh<_i9.IAuthFacade>(),
        ));
    gh.factory<_i37.ReferenceBloc>(() => _i37.ReferenceBloc(
          gh<_i11.IAccountRepository>(),
          gh<_i9.IAuthFacade>(),
        ));
    gh.factory<_i38.ContractorHomeBloc>(
        () => _i38.ContractorHomeBloc(gh<_i13.IMainFacade>()));
    gh.factory<_i39.ChatBloc>(() => _i39.ChatBloc(gh<_i13.IMainFacade>()));
    gh.factory<_i40.HomeBloc>(() => _i40.HomeBloc(gh<_i13.IMainFacade>()));
    gh.factory<_i41.AddNewMemberBloc>(
        () => _i41.AddNewMemberBloc(gh<_i13.IMainFacade>()));
    return this;
  }
}
