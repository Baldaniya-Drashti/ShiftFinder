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
    as _i18;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i19;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i3;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i24;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i31;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i25;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i26;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i27;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i32;
import 'package:shift/application/auth/contractor_auth/speciality_experience/speciality_experience_bloc.dart'
    as _i28;
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart'
    as _i20;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i21;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i22;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i23;
import 'package:shift/application/google_map/google_map_bloc.dart' as _i4;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i14;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i29;
import 'package:shift/application/main_tab/home/home_bloc.dart' as _i33;
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart'
    as _i16;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i15;
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart'
    as _i34;
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart'
    as _i13;
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart' as _i17;
import 'package:shift/application/profile/account/account_cubit.dart' as _i30;
import 'package:shift/application/splash/splash_bloc.dart' as _i12;
import 'package:shift/domain/account/i_account_repository.dart' as _i8;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i6;
import 'package:shift/domain/main/i_main_facade.dart' as _i10;
import 'package:shift/infrastructure/account/account_repository.dart' as _i9;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i7;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i5;
import 'package:shift/infrastructure/main/main_facade.dart' as _i11;

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
    gh.factory<_i3.CardBloc>(() => _i3.CardBloc());
    gh.factory<_i4.GoogleMapBloc>(() => _i4.GoogleMapBloc());
    gh.lazySingleton<_i5.ApiService>(() => _i5.ApiService());
    gh.lazySingleton<_i6.IAuthFacade>(
        () => _i7.AuthFacade(gh<_i5.ApiService>()));
    gh.lazySingleton<_i8.IAccountRepository>(
        () => _i9.AccountRepository(gh<_i5.ApiService>()));
    gh.lazySingleton<_i10.IMainFacade>(
        () => _i11.MainFacade(apiService: gh<_i5.ApiService>()));
    gh.factory<_i12.SplashBloc>(() => _i12.SplashBloc(
          gh<_i6.IAuthFacade>(),
          gh<_i8.IAccountRepository>(),
        ));
    gh.factory<_i13.TeamsBloc>(() => _i13.TeamsBloc(
          gh<_i10.IMainFacade>(),
          gh<_i8.IAccountRepository>(),
        ));
    gh.factory<_i14.HealthcarePostBloc>(() => _i14.HealthcarePostBloc(
          gh<_i6.IAuthFacade>(),
          gh<_i8.IAccountRepository>(),
          gh<_i10.IMainFacade>(),
        ));
    gh.factory<_i15.MainTabBloc>(() => _i15.MainTabBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i16.ViewSingleApplicantsBloc>(
        () => _i16.ViewSingleApplicantsBloc(gh<_i10.IMainFacade>()));
    gh.factory<_i17.PostShiftBloc>(
        () => _i17.PostShiftBloc(gh<_i10.IMainFacade>()));
    gh.factory<_i18.AuthStatusBloc>(
        () => _i18.AuthStatusBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i19.AddContractorSkillFormBloc>(
        () => _i19.AddContractorSkillFormBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i20.TermsAndConditionBloc>(
        () => _i20.TermsAndConditionBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i21.ForgotPasswordBloc>(
        () => _i21.ForgotPasswordBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i22.LoginFormBloc>(
        () => _i22.LoginFormBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i23.RegisterFormBloc>(
        () => _i23.RegisterFormBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i24.DocumentBloc>(
        () => _i24.DocumentBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i24.ProfessionalLicensesBloc>(
        () => _i24.ProfessionalLicensesBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i24.ImmunizationBloc>(
        () => _i24.ImmunizationBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i24.ProfessionalLiabilityBloc>(
        () => _i24.ProfessionalLiabilityBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i24.ResumeBloc>(
        () => _i24.ResumeBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i24.EquipmentBloc>(
        () => _i24.EquipmentBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i25.ExperienceBloc>(
        () => _i25.ExperienceBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i26.IntroVideoBloc>(
        () => _i26.IntroVideoBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i27.LegalScreeningBloc>(
        () => _i27.LegalScreeningBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i28.SpecialityExperienceBloc>(
        () => _i28.SpecialityExperienceBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i29.LocationDetailsBloc>(
        () => _i29.LocationDetailsBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i30.AccountCubit>(
        () => _i30.AccountCubit(gh<_i8.IAccountRepository>()));
    gh.factory<_i31.EducationDetailBloc>(() => _i31.EducationDetailBloc(
          gh<_i8.IAccountRepository>(),
          gh<_i6.IAuthFacade>(),
        ));
    gh.factory<_i32.ReferenceBloc>(() => _i32.ReferenceBloc(
          gh<_i8.IAccountRepository>(),
          gh<_i6.IAuthFacade>(),
        ));
    gh.factory<_i33.HomeBloc>(() => _i33.HomeBloc(gh<_i10.IMainFacade>()));
    gh.factory<_i34.AddNewMemberBloc>(
        () => _i34.AddNewMemberBloc(gh<_i10.IMainFacade>()));
    return this;
  }
}
