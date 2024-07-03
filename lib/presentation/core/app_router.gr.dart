// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i5;
import 'package:shift/presentation/auth/register/location_detail_form.dart'
    as _i4;
import 'package:shift/presentation/auth/register/register_profile.dart' as _i12;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i13;
import 'package:shift/presentation/healthcare_post/healthcare_post.dart' as _i1;
import 'package:shift/presentation/main/main_tab.dart' as _i6;
import 'package:shift/presentation/main/tabs/history_view.dart' as _i2;
import 'package:shift/presentation/main/tabs/home_view.dart' as _i3;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i7;
import 'package:shift/presentation/main/tabs/profile_view.dart' as _i11;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i8;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i9;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i10;
import 'package:shift/presentation/splash/splash_page.dart' as _i14;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    HealthCarePostForm.name: (routeData) {
      final args = routeData.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HealthCarePostForm(key: args.key),
      );
    },
    HistoryView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HistoryView(),
      );
    },
    HomeView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeView(),
      );
    },
    LocationDetailForm.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LocationDetailForm(),
      );
    },
    LoginPage.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginScreen(),
      );
    },
    MainTabView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MainTabView(),
      );
    },
    NotificationView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.NotificationView(),
      );
    },
    Onboarding1.name: (routeData) {
      final args = routeData.argsAs<Onboarding1Args>(
          orElse: () => const Onboarding1Args());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.OnBoarding1(key: args.key),
      );
    },
    Onboarding2.name: (routeData) {
      final args = routeData.argsAs<Onboarding2Args>(
          orElse: () => const Onboarding2Args());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.OnBoarding2(key: args.key),
      );
    },
    OnBoarding3.name: (routeData) {
      final args = routeData.argsAs<OnBoarding3Args>(
          orElse: () => const OnBoarding3Args());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.OnBoarding3(key: args.key),
      );
    },
    ProfileView.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ProfileView(),
      );
    },
    RegisterProfilePage.name: (routeData) {
      final args = routeData.argsAs<RegisterProfilePageArgs>(
          orElse: () => const RegisterProfilePageArgs());
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.RegisterProfileScreen(key: args.key),
      );
    },
    RegisterPage.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RegisterScreen(),
      );
    },
    SplashPage.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SplashPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.HealthCarePostForm]
class HealthCarePostForm extends _i15.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          HealthCarePostForm.name,
          args: HealthCarePostFormArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HealthCarePostForm';

  static const _i15.PageInfo<HealthCarePostFormArgs> page =
      _i15.PageInfo<HealthCarePostFormArgs>(name);
}

class HealthCarePostFormArgs {
  const HealthCarePostFormArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.HistoryView]
class HistoryView extends _i15.PageRouteInfo<void> {
  const HistoryView({List<_i15.PageRouteInfo>? children})
      : super(
          HistoryView.name,
          initialChildren: children,
        );

  static const String name = 'HistoryView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeView]
class HomeView extends _i15.PageRouteInfo<void> {
  const HomeView({List<_i15.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LocationDetailForm]
class LocationDetailForm extends _i15.PageRouteInfo<void> {
  const LocationDetailForm({List<_i15.PageRouteInfo>? children})
      : super(
          LocationDetailForm.name,
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginScreen]
class LoginPage extends _i15.PageRouteInfo<void> {
  const LoginPage({List<_i15.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MainTabView]
class MainTabView extends _i15.PageRouteInfo<void> {
  const MainTabView({List<_i15.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.NotificationView]
class NotificationView extends _i15.PageRouteInfo<void> {
  const NotificationView({List<_i15.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i8.OnBoarding1]
class Onboarding1 extends _i15.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static const _i15.PageInfo<Onboarding1Args> page =
      _i15.PageInfo<Onboarding1Args>(name);
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i9.OnBoarding2]
class Onboarding2 extends _i15.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static const _i15.PageInfo<Onboarding2Args> page =
      _i15.PageInfo<Onboarding2Args>(name);
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i10.OnBoarding3]
class OnBoarding3 extends _i15.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static const _i15.PageInfo<OnBoarding3Args> page =
      _i15.PageInfo<OnBoarding3Args>(name);
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i11.ProfileView]
class ProfileView extends _i15.PageRouteInfo<void> {
  const ProfileView({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.RegisterProfileScreen]
class RegisterProfilePage extends _i15.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i16.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          RegisterProfilePage.name,
          args: RegisterProfilePageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterProfilePage';

  static const _i15.PageInfo<RegisterProfilePageArgs> page =
      _i15.PageInfo<RegisterProfilePageArgs>(name);
}

class RegisterProfilePageArgs {
  const RegisterProfilePageArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.RegisterScreen]
class RegisterPage extends _i15.PageRouteInfo<void> {
  const RegisterPage({List<_i15.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SplashPage]
class SplashPage extends _i15.PageRouteInfo<void> {
  const SplashPage({List<_i15.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
