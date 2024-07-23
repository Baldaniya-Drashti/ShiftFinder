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
    as _i4;
import 'package:shift/application/auth/contractor_auth/add_contractor_skill_form_bloc/add_contractor_skill_form_bloc.dart'
    as _i21;
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart'
    as _i9;
import 'package:shift/application/auth/contractor_auth/document_bloc/document_bloc.dart'
    as _i8;
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart'
    as _i19;
import 'package:shift/application/auth/contractor_auth/experience_bloc/experience_bloc.dart'
    as _i6;
import 'package:shift/application/auth/contractor_auth/intro_video_bloc/intro_video_bloc.dart'
    as _i5;
import 'package:shift/application/auth/contractor_auth/legal_screening_bloc/legal_screening_bloc.dart'
    as _i7;
import 'package:shift/application/auth/contractor_auth/reference_bloc/reference_bloc.dart'
    as _i10;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i3;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i23;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i22;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i12;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i11;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i20;
import 'package:shift/application/splash/splash_bloc.dart' as _i18;
import 'package:shift/domain/account/i_account_repository.dart' as _i16;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i14;
import 'package:shift/infrastructure/account/account_repository.dart' as _i17;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i15;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i13;
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
    gh.factory<_i3.ForgotPasswordBloc>(() => _i3.ForgotPasswordBloc());
    gh.factory<_i4.AuthStatusBloc>(() => _i4.AuthStatusBloc());
    gh.factory<_i5.IntroVideoBloc>(() => _i5.IntroVideoBloc());
    gh.factory<_i6.ExperienceBloc>(() => _i6.ExperienceBloc());
    gh.factory<_i7.LegalScreeningBloc>(() => _i7.LegalScreeningBloc());
    gh.factory<_i8.DocumentBloc>(() => _i8.DocumentBloc());
    gh.factory<_i9.CardBloc>(() => _i9.CardBloc());
    gh.factory<_i10.ReferenceBloc>(() => _i10.ReferenceBloc());
    gh.factory<_i11.LocationDetailsBloc>(() => _i11.LocationDetailsBloc());
    gh.factory<_i12.HealthcarePostBloc>(() => _i12.HealthcarePostBloc());
    gh.lazySingleton<_i13.ApiService>(() => _i13.ApiService());
    gh.lazySingleton<_i14.IAuthFacade>(
        () => _i15.AuthFacade(gh<_i13.ApiService>()));
    gh.lazySingleton<_i16.IAccountRepository>(
        () => _i17.AccountRepository(gh<_i13.ApiService>()));
    gh.factory<_i18.SplashBloc>(() => _i18.SplashBloc(
          gh<_i14.IAuthFacade>(),
          gh<_i16.IAccountRepository>(),
        ));
    gh.factory<_i19.EducationDetailBloc>(() => _i19.EducationDetailBloc(
          gh<_i14.IAuthFacade>(),
          gh<_i16.IAccountRepository>(),
        ));
    gh.factory<_i20.MainTabBloc>(
        () => _i20.MainTabBloc(gh<_i14.IAuthFacade>()));
    gh.factory<_i21.AddContractorSkillFormBloc>(
        () => _i21.AddContractorSkillFormBloc(gh<_i14.IAuthFacade>()));
    gh.factory<_i22.RegisterFormBloc>(
        () => _i22.RegisterFormBloc(gh<_i14.IAuthFacade>()));
    gh.factory<_i23.LoginFormBloc>(
        () => _i23.LoginFormBloc(gh<_i14.IAuthFacade>()));
    gh.factory<_i24.AccountCubit>(
        () => _i24.AccountCubit(gh<_i16.IAccountRepository>()));
    return this;
  }
}
