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
    as _i18;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i4;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i5;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i21;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i22;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i6;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i7;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i23;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i8;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i19;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i20;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i9;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i10;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i17;
import 'package:shift/application/splash/splash_bloc.dart' as _i16;
import 'package:shift/domain/account/i_account_repository.dart' as _i14;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i12;
import 'package:shift/infrastructure/account/account_repository.dart' as _i15;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i13;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i11;
import 'package:shift/presentation/profile/account/account_cubit.dart' as _i24;

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
    gh.factory<_i5.DocumentBloc>(() => _i5.DocumentBloc());
    gh.factory<_i6.IntroVideoBloc>(() => _i6.IntroVideoBloc());
    gh.factory<_i7.LegalScreeningBloc>(() => _i7.LegalScreeningBloc());
    gh.factory<_i8.ForgotPasswordBloc>(() => _i8.ForgotPasswordBloc());
    gh.factory<_i9.HealthcarePostBloc>(() => _i9.HealthcarePostBloc());
    gh.factory<_i10.LocationDetailsBloc>(() => _i10.LocationDetailsBloc());
    gh.lazySingleton<_i11.ApiService>(() => _i11.ApiService());
    gh.lazySingleton<_i12.IAuthFacade>(
        () => _i13.AuthFacade(gh<_i11.ApiService>()));
    gh.lazySingleton<_i14.IAccountRepository>(
        () => _i15.AccountRepository(gh<_i11.ApiService>()));
    gh.factory<_i16.SplashBloc>(() => _i16.SplashBloc(
          gh<_i12.IAuthFacade>(),
          gh<_i14.IAccountRepository>(),
        ));
    gh.factory<_i17.MainTabBloc>(
        () => _i17.MainTabBloc(gh<_i12.IAuthFacade>()));
    gh.factory<_i18.AddContractorSkillFormBloc>(
        () => _i18.AddContractorSkillFormBloc(gh<_i12.IAuthFacade>()));
    gh.factory<_i19.LoginFormBloc>(
        () => _i19.LoginFormBloc(gh<_i12.IAuthFacade>()));
    gh.factory<_i20.RegisterFormBloc>(
        () => _i20.RegisterFormBloc(gh<_i12.IAuthFacade>()));
    gh.factory<_i21.EducationDetailBloc>(
        () => _i21.EducationDetailBloc(gh<_i14.IAccountRepository>()));
    gh.factory<_i22.ExperienceBloc>(
        () => _i22.ExperienceBloc(gh<_i14.IAccountRepository>()));
    gh.factory<_i23.ReferenceBloc>(
        () => _i23.ReferenceBloc(gh<_i14.IAccountRepository>()));
    gh.factory<_i24.AccountCubit>(
        () => _i24.AccountCubit(gh<_i14.IAccountRepository>()));
    return this;
  }
}
