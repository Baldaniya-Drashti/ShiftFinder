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
    as _i21;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i22;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i4;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i29;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i33;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i27;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i26;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i28;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i34;
import 'package:shift/application/auth/contractor_auth/speciality_experience/speciality_experience_bloc.dart'
    as _i30;
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart'
    as _i23;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i20;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i25;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i24;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_home_bloc/contractor_home_bloc.dart'
    as _i36;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart'
    as _i16;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart'
    as _i35;
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart'
    as _i3;
import 'package:shift/application/google_map/google_map_bloc.dart' as _i5;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i15;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i31;
import 'package:shift/application/main_tab/home/home_bloc.dart' as _i37;
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart'
    as _i19;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i17;
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart'
    as _i38;
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart'
    as _i14;
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart' as _i18;
import 'package:shift/application/profile/account/account_cubit.dart' as _i32;
import 'package:shift/application/splash/splash_bloc.dart' as _i13;
import 'package:shift/domain/account/i_account_repository.dart' as _i9;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i7;
import 'package:shift/domain/main/i_main_facade.dart' as _i11;
import 'package:shift/infrastructure/account/account_repository.dart' as _i10;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i8;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i6;
import 'package:shift/infrastructure/main/main_facade.dart' as _i12;

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
    gh.factory<_i3.SendProposalBloc>(() => _i3.SendProposalBloc());
    gh.factory<_i4.CardBloc>(() => _i4.CardBloc());
    gh.factory<_i5.GoogleMapBloc>(() => _i5.GoogleMapBloc());
    gh.lazySingleton<_i6.ApiService>(() => _i6.ApiService());
    gh.lazySingleton<_i7.IAuthFacade>(
        () => _i8.AuthFacade(gh<_i6.ApiService>()));
    gh.lazySingleton<_i9.IAccountRepository>(
        () => _i10.AccountRepository(gh<_i6.ApiService>()));
    gh.lazySingleton<_i11.IMainFacade>(
        () => _i12.MainFacade(apiService: gh<_i6.ApiService>()));
    gh.factory<_i13.SplashBloc>(() => _i13.SplashBloc(
          gh<_i7.IAuthFacade>(),
          gh<_i9.IAccountRepository>(),
        ));
    gh.factory<_i14.TeamsBloc>(() => _i14.TeamsBloc(
          gh<_i11.IMainFacade>(),
          gh<_i9.IAccountRepository>(),
        ));
    gh.factory<_i15.HealthcarePostBloc>(() => _i15.HealthcarePostBloc(
          gh<_i7.IAuthFacade>(),
          gh<_i9.IAccountRepository>(),
          gh<_i11.IMainFacade>(),
        ));
    gh.factory<_i16.ContractorMainTabBloc>(
        () => _i16.ContractorMainTabBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i17.MainTabBloc>(() => _i17.MainTabBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i18.PostShiftBloc>(
        () => _i18.PostShiftBloc(gh<_i11.IMainFacade>()));
    gh.factory<_i19.ViewSingleApplicantsBloc>(
        () => _i19.ViewSingleApplicantsBloc(gh<_i11.IMainFacade>()));
    gh.factory<_i20.ForgotPasswordBloc>(
        () => _i20.ForgotPasswordBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i21.AuthStatusBloc>(
        () => _i21.AuthStatusBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i22.AddContractorSkillFormBloc>(
        () => _i22.AddContractorSkillFormBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i23.TermsAndConditionBloc>(
        () => _i23.TermsAndConditionBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i24.RegisterFormBloc>(
        () => _i24.RegisterFormBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i25.LoginFormBloc>(
        () => _i25.LoginFormBloc(gh<_i7.IAuthFacade>()));
    gh.factory<_i26.IntroVideoBloc>(
        () => _i26.IntroVideoBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i27.ExperienceBloc>(
        () => _i27.ExperienceBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i28.LegalScreeningBloc>(
        () => _i28.LegalScreeningBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i29.DocumentBloc>(
        () => _i29.DocumentBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i29.ProfessionalLicensesBloc>(
        () => _i29.ProfessionalLicensesBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i29.ImmunizationBloc>(
        () => _i29.ImmunizationBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i29.ProfessionalLiabilityBloc>(
        () => _i29.ProfessionalLiabilityBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i29.ResumeBloc>(
        () => _i29.ResumeBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i29.EquipmentBloc>(
        () => _i29.EquipmentBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i30.SpecialityExperienceBloc>(
        () => _i30.SpecialityExperienceBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i31.LocationDetailsBloc>(
        () => _i31.LocationDetailsBloc(gh<_i9.IAccountRepository>()));
    gh.factory<_i32.AccountCubit>(
        () => _i32.AccountCubit(gh<_i9.IAccountRepository>()));
    gh.factory<_i33.EducationDetailBloc>(() => _i33.EducationDetailBloc(
          gh<_i9.IAccountRepository>(),
          gh<_i7.IAuthFacade>(),
        ));
    gh.factory<_i34.ReferenceBloc>(() => _i34.ReferenceBloc(
          gh<_i9.IAccountRepository>(),
          gh<_i7.IAuthFacade>(),
        ));
    gh.factory<_i35.ContractorShiftBloc>(
        () => _i35.ContractorShiftBloc(gh<_i11.IMainFacade>()));
    gh.factory<_i36.ContractorHomeBloc>(
        () => _i36.ContractorHomeBloc(gh<_i11.IMainFacade>()));
    gh.factory<_i37.HomeBloc>(() => _i37.HomeBloc(gh<_i11.IMainFacade>()));
    gh.factory<_i38.AddNewMemberBloc>(
        () => _i38.AddNewMemberBloc(gh<_i11.IMainFacade>()));
    return this;
  }
}
