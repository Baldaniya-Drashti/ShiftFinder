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
    as _i22;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i23;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i4;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i30;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i34;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i28;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i27;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i29;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i35;
import 'package:shift/application/auth/contractor_auth/speciality_experience/speciality_experience_bloc.dart'
    as _i31;
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart'
    as _i24;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i21;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i26;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i25;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_home_bloc/contractor_home_bloc.dart'
    as _i37;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart'
    as _i17;
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart'
    as _i36;
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart'
    as _i3;
import 'package:shift/application/employer/profile/previous_shift_bloc.dart'
    as _i5;
import 'package:shift/application/google_map/google_map_bloc.dart' as _i6;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i16;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i32;
import 'package:shift/application/main_tab/home/home_bloc.dart' as _i38;
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart'
    as _i20;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i18;
import 'package:shift/application/main_tab/profile/profile_sections/teams/add_new_member/add_new_member_bloc.dart'
    as _i39;
import 'package:shift/application/main_tab/profile/profile_sections/teams/teams_bloc.dart'
    as _i15;
import 'package:shift/application/post_shift_bloc/post_shift_bloc.dart' as _i19;
import 'package:shift/application/profile/account/account_cubit.dart' as _i33;
import 'package:shift/application/splash/splash_bloc.dart' as _i14;
import 'package:shift/domain/account/i_account_repository.dart' as _i10;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i8;
import 'package:shift/domain/main/i_main_facade.dart' as _i12;
import 'package:shift/infrastructure/account/account_repository.dart' as _i11;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i9;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i7;
import 'package:shift/infrastructure/main/main_facade.dart' as _i13;

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
    gh.factory<_i5.PreviousShiftBloc>(() => _i5.PreviousShiftBloc());
    gh.factory<_i6.GoogleMapBloc>(() => _i6.GoogleMapBloc());
    gh.lazySingleton<_i7.ApiService>(() => _i7.ApiService());
    gh.lazySingleton<_i8.IAuthFacade>(
        () => _i9.AuthFacade(gh<_i7.ApiService>()));
    gh.lazySingleton<_i10.IAccountRepository>(
        () => _i11.AccountRepository(gh<_i7.ApiService>()));
    gh.lazySingleton<_i12.IMainFacade>(
        () => _i13.MainFacade(apiService: gh<_i7.ApiService>()));
    gh.factory<_i14.SplashBloc>(() => _i14.SplashBloc(
          gh<_i8.IAuthFacade>(),
          gh<_i10.IAccountRepository>(),
        ));
    gh.factory<_i15.TeamsBloc>(() => _i15.TeamsBloc(
          gh<_i12.IMainFacade>(),
          gh<_i10.IAccountRepository>(),
        ));
    gh.factory<_i16.HealthcarePostBloc>(() => _i16.HealthcarePostBloc(
          gh<_i8.IAuthFacade>(),
          gh<_i10.IAccountRepository>(),
          gh<_i12.IMainFacade>(),
        ));
    gh.factory<_i17.ContractorMainTabBloc>(
        () => _i17.ContractorMainTabBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i18.MainTabBloc>(() => _i18.MainTabBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i19.PostShiftBloc>(
        () => _i19.PostShiftBloc(gh<_i12.IMainFacade>()));
    gh.factory<_i20.ViewSingleApplicantsBloc>(
        () => _i20.ViewSingleApplicantsBloc(gh<_i12.IMainFacade>()));
    gh.factory<_i21.ForgotPasswordBloc>(
        () => _i21.ForgotPasswordBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i22.AuthStatusBloc>(
        () => _i22.AuthStatusBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i23.AddContractorSkillFormBloc>(
        () => _i23.AddContractorSkillFormBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i24.TermsAndConditionBloc>(
        () => _i24.TermsAndConditionBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i25.RegisterFormBloc>(
        () => _i25.RegisterFormBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i26.LoginFormBloc>(
        () => _i26.LoginFormBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i27.IntroVideoBloc>(
        () => _i27.IntroVideoBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i28.ExperienceBloc>(
        () => _i28.ExperienceBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i29.LegalScreeningBloc>(
        () => _i29.LegalScreeningBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i30.DocumentBloc>(
        () => _i30.DocumentBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i30.ProfessionalLicensesBloc>(
        () => _i30.ProfessionalLicensesBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i30.ImmunizationBloc>(
        () => _i30.ImmunizationBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i30.ProfessionalLiabilityBloc>(
        () => _i30.ProfessionalLiabilityBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i30.ResumeBloc>(
        () => _i30.ResumeBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i30.EquipmentBloc>(
        () => _i30.EquipmentBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i31.SpecialityExperienceBloc>(
        () => _i31.SpecialityExperienceBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i32.LocationDetailsBloc>(
        () => _i32.LocationDetailsBloc(gh<_i10.IAccountRepository>()));
    gh.factory<_i33.AccountCubit>(
        () => _i33.AccountCubit(gh<_i10.IAccountRepository>()));
    gh.factory<_i34.EducationDetailBloc>(() => _i34.EducationDetailBloc(
          gh<_i10.IAccountRepository>(),
          gh<_i8.IAuthFacade>(),
        ));
    gh.factory<_i35.ReferenceBloc>(() => _i35.ReferenceBloc(
          gh<_i10.IAccountRepository>(),
          gh<_i8.IAuthFacade>(),
        ));
    gh.factory<_i36.ContractorShiftBloc>(
        () => _i36.ContractorShiftBloc(gh<_i12.IMainFacade>()));
    gh.factory<_i37.ContractorHomeBloc>(
        () => _i37.ContractorHomeBloc(gh<_i12.IMainFacade>()));
    gh.factory<_i38.HomeBloc>(() => _i38.HomeBloc(gh<_i12.IMainFacade>()));
    gh.factory<_i39.AddNewMemberBloc>(
        () => _i39.AddNewMemberBloc(gh<_i12.IMainFacade>()));
    return this;
  }
}
