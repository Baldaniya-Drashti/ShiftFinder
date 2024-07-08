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
import 'package:shift/application/auth/contractor_auth/bloc/add_contractor_skill_form_bloc.dart'
    as _i5;
import 'package:shift/application/auth/forgot_password/forgot_password_bloc.dart'
    as _i3;
import 'package:shift/application/auth/login_form/login_form_bloc.dart' as _i7;
import 'package:shift/application/auth/register_form/register_form_bloc.dart'
    as _i6;
import 'package:shift/application/healthcare_post/healthcare_post_bloc.dart'
    as _i9;
import 'package:shift/application/location_details/location_details_bloc.dart'
    as _i8;
import 'package:shift/application/main_tab/main_tab_bloc.dart' as _i13;
import 'package:shift/application/splash/splash_bloc.dart' as _i14;
import 'package:shift/domain/auth/i_auth_facade.dart' as _i11;
import 'package:shift/infrastructure/auth/auth_facade.dart' as _i12;
import 'package:shift/infrastructure/core/network/injectable_module.dart'
    as _i10;

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
    gh.factory<_i5.AddContractorSkillFormBloc>(
        () => _i5.AddContractorSkillFormBloc());
    gh.factory<_i6.RegisterFormBloc>(() => _i6.RegisterFormBloc());
    gh.factory<_i7.LoginFormBloc>(() => _i7.LoginFormBloc());
    gh.factory<_i8.LocationDetailsBloc>(() => _i8.LocationDetailsBloc());
    gh.factory<_i9.HealthcarePostBloc>(() => _i9.HealthcarePostBloc());
    gh.lazySingleton<_i10.ApiService>(() => _i10.ApiService());
    gh.lazySingleton<_i11.IAuthFacade>(
        () => _i12.AuthFacade(gh<_i10.ApiService>()));
    gh.factory<_i13.MainTabBloc>(
        () => _i13.MainTabBloc(gh<_i11.IAuthFacade>()));
    gh.factory<_i14.SplashBloc>(() => _i14.SplashBloc(gh<_i11.IAuthFacade>()));
    return this;
  }
}
