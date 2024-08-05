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
    as _i3;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i14;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i4;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i21;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i24;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i19;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i18;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i20;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i25;
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart'
    as _i15;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i13;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i17;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i16;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i11;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i22;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i12;
import 'package:shift/application/profile/account/account_cubit.dart' as _i23;
import 'package:shift/application/splash/splash_bloc.dart' as _i10;
import 'package:shift/domain/account/i_account_repository.dart' as _i8;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i6;
import 'package:shift/infrastructure/account/account_repository.dart' as _i9;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i7;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i5;

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
    gh.factory<_i3.AuthStatusBloc>(() => _i3.AuthStatusBloc());
    gh.factory<_i4.CardBloc>(() => _i4.CardBloc());
    gh.lazySingleton<_i5.ApiService>(() => _i5.ApiService());
    gh.lazySingleton<_i6.IAuthFacade>(
        () => _i7.AuthFacade(gh<_i5.ApiService>()));
    gh.lazySingleton<_i8.IAccountRepository>(
        () => _i9.AccountRepository(gh<_i5.ApiService>()));
    gh.factory<_i10.SplashBloc>(() => _i10.SplashBloc(
          gh<_i6.IAuthFacade>(),
          gh<_i8.IAccountRepository>(),
        ));
    gh.factory<_i11.HealthcarePostBloc>(() => _i11.HealthcarePostBloc(
          gh<_i6.IAuthFacade>(),
          gh<_i8.IAccountRepository>(),
        ));
    gh.factory<_i12.MainTabBloc>(() => _i12.MainTabBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i13.ForgotPasswordBloc>(
        () => _i13.ForgotPasswordBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i14.AddContractorSkillFormBloc>(
        () => _i14.AddContractorSkillFormBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i15.TermsAndConditionBloc>(
        () => _i15.TermsAndConditionBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i16.RegisterFormBloc>(
        () => _i16.RegisterFormBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i17.LoginFormBloc>(
        () => _i17.LoginFormBloc(gh<_i6.IAuthFacade>()));
    gh.factory<_i18.IntroVideoBloc>(
        () => _i18.IntroVideoBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i19.ExperienceBloc>(
        () => _i19.ExperienceBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i20.LegalScreeningBloc>(
        () => _i20.LegalScreeningBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i21.DocumentBloc>(
        () => _i21.DocumentBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i21.ProfessionalLicensesBloc>(
        () => _i21.ProfessionalLicensesBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i21.ImmunizationBloc>(
        () => _i21.ImmunizationBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i21.ProfessionalLiabilityBloc>(
        () => _i21.ProfessionalLiabilityBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i21.ResumeBloc>(
        () => _i21.ResumeBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i21.EquipmentBloc>(
        () => _i21.EquipmentBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i22.LocationDetailsBloc>(
        () => _i22.LocationDetailsBloc(gh<_i8.IAccountRepository>()));
    gh.factory<_i23.AccountCubit>(
        () => _i23.AccountCubit(gh<_i8.IAccountRepository>()));
    gh.factory<_i24.EducationDetailBloc>(() => _i24.EducationDetailBloc(
          gh<_i8.IAccountRepository>(),
          gh<_i6.IAuthFacade>(),
        ));
    gh.factory<_i25.ReferenceBloc>(() => _i25.ReferenceBloc(
          gh<_i8.IAccountRepository>(),
          gh<_i6.IAuthFacade>(),
        ));
    return this;
  }
}
