// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/material.dart' as _i26;
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart'
    as _i1;
import 'package:shift/presentation/auth/contractor_auth/add_experience_detail.dart'
    as _i3;
import 'package:shift/presentation/auth/contractor_auth/documents/document_page.dart'
    as _i5;
import 'package:shift/presentation/auth/contractor_auth/education_details/add_education_detail.dart'
    as _i2;
import 'package:shift/presentation/auth/contractor_auth/education_details/education_detail_list.dart'
    as _i6;
import 'package:shift/presentation/auth/contractor_auth/intro_video.dart'
    as _i10;
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart'
    as _i11;
import 'package:shift/presentation/auth/contractor_auth/reference_details/add_reference_detail.dart'
    as _i4;
import 'package:shift/presentation/auth/contractor_auth/reference_details/reference_detail_list.dart'
    as _i20;
import 'package:shift/presentation/auth/contractor_auth/terms_conditions.dart'
    as _i24;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i13;
import 'package:shift/presentation/auth/register/location_detail_form.dart'
    as _i12;
import 'package:shift/presentation/auth/register/register_profile.dart' as _i21;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i22;
import 'package:shift/presentation/healthcare_post/healthcare_post.dart' as _i7;
import 'package:shift/presentation/main/main_tab.dart' as _i14;
import 'package:shift/presentation/main/tabs/history_view.dart' as _i8;
import 'package:shift/presentation/main/tabs/home_view.dart' as _i9;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i15;
import 'package:shift/presentation/main/tabs/profile_view.dart' as _i19;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i16;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i17;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i18;
import 'package:shift/presentation/splash/splash_page.dart' as _i23;

abstract class $AppRouter extends _i25.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i25.PageFactory> pagesMap = {
    AddContractorSkillsForm.name: (routeData) {
      final args = routeData.argsAs<AddContractorSkillsFormArgs>(
          orElse: () => const AddContractorSkillsFormArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddContractorSkillsForm(key: args.key),
      );
    },
    AddEducationDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddEducationDetailScreenArgs>(
          orElse: () => const AddEducationDetailScreenArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddEducationDetail(key: args.key),
      );
    },
    AddExperienceDetailScreen.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AddExperienceDetail(),
      );
    },
    AddReferenceDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddReferenceDetailScreenArgs>(
          orElse: () => const AddReferenceDetailScreenArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AddReferenceDetail(key: args.key),
      );
    },
    DocumentPageScreen.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.DocumentPage(),
      );
    },
    EducationListScreen.name: (routeData) {
      final args = routeData.argsAs<EducationListScreenArgs>(
          orElse: () => const EducationListScreenArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.EducationListScreen(key: args.key),
      );
    },
    HealthCarePostForm.name: (routeData) {
      final args = routeData.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.HealthCarePostForm(key: args.key),
      );
    },
    HistoryView.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HistoryView(),
      );
    },
    HomeView.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomeView(),
      );
    },
    IntroVideoScreen.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.IntroVideoScreen(),
      );
    },
    LegalScreeningQuestionsPage.name: (routeData) {
      final args = routeData.argsAs<LegalScreeningQuestionsPageArgs>(
          orElse: () => const LegalScreeningQuestionsPageArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.LegalScreeningQuestionsPage(key: args.key),
      );
    },
    LocationDetailForm.name: (routeData) {
      final args = routeData.argsAs<LocationDetailFormArgs>(
          orElse: () => const LocationDetailFormArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.LocationDetailForm(key: args.key),
      );
    },
    LoginPage.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.LoginScreen(),
      );
    },
    MainTabView.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.MainTabView(),
      );
    },
    NotificationView.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.NotificationView(),
      );
    },
    Onboarding1.name: (routeData) {
      final args = routeData.argsAs<Onboarding1Args>(
          orElse: () => const Onboarding1Args());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.OnBoarding1(key: args.key),
      );
    },
    Onboarding2.name: (routeData) {
      final args = routeData.argsAs<Onboarding2Args>(
          orElse: () => const Onboarding2Args());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.OnBoarding2(key: args.key),
      );
    },
    OnBoarding3.name: (routeData) {
      final args = routeData.argsAs<OnBoarding3Args>(
          orElse: () => const OnBoarding3Args());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.OnBoarding3(key: args.key),
      );
    },
    ProfileView.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.ProfileView(),
      );
    },
    ReferenceListScreen.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.ReferenceListScreen(),
      );
    },
    RegisterProfilePage.name: (routeData) {
      final args = routeData.argsAs<RegisterProfilePageArgs>(
          orElse: () => const RegisterProfilePageArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.RegisterProfileScreen(key: args.key),
      );
    },
    RegisterPage.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.RegisterScreen(),
      );
    },
    SplashPage.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.SplashPage(),
      );
    },
    TermsAndConditionsScreen.name: (routeData) {
      final args = routeData.argsAs<TermsAndConditionsScreenArgs>(
          orElse: () => const TermsAndConditionsScreenArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.TermsAndConditionsScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AddContractorSkillsForm]
class AddContractorSkillsForm
    extends _i25.PageRouteInfo<AddContractorSkillsFormArgs> {
  AddContractorSkillsForm({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          AddContractorSkillsForm.name,
          args: AddContractorSkillsFormArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddContractorSkillsForm';

  static const _i25.PageInfo<AddContractorSkillsFormArgs> page =
      _i25.PageInfo<AddContractorSkillsFormArgs>(name);
}

class AddContractorSkillsFormArgs {
  const AddContractorSkillsFormArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'AddContractorSkillsFormArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.AddEducationDetail]
class AddEducationDetailScreen
    extends _i25.PageRouteInfo<AddEducationDetailScreenArgs> {
  AddEducationDetailScreen({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          AddEducationDetailScreen.name,
          args: AddEducationDetailScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddEducationDetailScreen';

  static const _i25.PageInfo<AddEducationDetailScreenArgs> page =
      _i25.PageInfo<AddEducationDetailScreenArgs>(name);
}

class AddEducationDetailScreenArgs {
  const AddEducationDetailScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'AddEducationDetailScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.AddExperienceDetail]
class AddExperienceDetailScreen extends _i25.PageRouteInfo<void> {
  const AddExperienceDetailScreen({List<_i25.PageRouteInfo>? children})
      : super(
          AddExperienceDetailScreen.name,
          initialChildren: children,
        );

  static const String name = 'AddExperienceDetailScreen';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AddReferenceDetail]
class AddReferenceDetailScreen
    extends _i25.PageRouteInfo<AddReferenceDetailScreenArgs> {
  AddReferenceDetailScreen({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          AddReferenceDetailScreen.name,
          args: AddReferenceDetailScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AddReferenceDetailScreen';

  static const _i25.PageInfo<AddReferenceDetailScreenArgs> page =
      _i25.PageInfo<AddReferenceDetailScreenArgs>(name);
}

class AddReferenceDetailScreenArgs {
  const AddReferenceDetailScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'AddReferenceDetailScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.DocumentPage]
class DocumentPageScreen extends _i25.PageRouteInfo<void> {
  const DocumentPageScreen({List<_i25.PageRouteInfo>? children})
      : super(
          DocumentPageScreen.name,
          initialChildren: children,
        );

  static const String name = 'DocumentPageScreen';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EducationListScreen]
class EducationListScreen extends _i25.PageRouteInfo<EducationListScreenArgs> {
  EducationListScreen({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          EducationListScreen.name,
          args: EducationListScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'EducationListScreen';

  static const _i25.PageInfo<EducationListScreenArgs> page =
      _i25.PageInfo<EducationListScreenArgs>(name);
}

class EducationListScreenArgs {
  const EducationListScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'EducationListScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.HealthCarePostForm]
class HealthCarePostForm extends _i25.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          HealthCarePostForm.name,
          args: HealthCarePostFormArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HealthCarePostForm';

  static const _i25.PageInfo<HealthCarePostFormArgs> page =
      _i25.PageInfo<HealthCarePostFormArgs>(name);
}

class HealthCarePostFormArgs {
  const HealthCarePostFormArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.HistoryView]
class HistoryView extends _i25.PageRouteInfo<void> {
  const HistoryView({List<_i25.PageRouteInfo>? children})
      : super(
          HistoryView.name,
          initialChildren: children,
        );

  static const String name = 'HistoryView';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i9.HomeView]
class HomeView extends _i25.PageRouteInfo<void> {
  const HomeView({List<_i25.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i10.IntroVideoScreen]
class IntroVideoScreen extends _i25.PageRouteInfo<void> {
  const IntroVideoScreen({List<_i25.PageRouteInfo>? children})
      : super(
          IntroVideoScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroVideoScreen';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LegalScreeningQuestionsPage]
class LegalScreeningQuestionsPage
    extends _i25.PageRouteInfo<LegalScreeningQuestionsPageArgs> {
  LegalScreeningQuestionsPage({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          LegalScreeningQuestionsPage.name,
          args: LegalScreeningQuestionsPageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LegalScreeningQuestionsPage';

  static const _i25.PageInfo<LegalScreeningQuestionsPageArgs> page =
      _i25.PageInfo<LegalScreeningQuestionsPageArgs>(name);
}

class LegalScreeningQuestionsPageArgs {
  const LegalScreeningQuestionsPageArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'LegalScreeningQuestionsPageArgs{key: $key}';
  }
}

/// generated route for
/// [_i12.LocationDetailForm]
class LocationDetailForm extends _i25.PageRouteInfo<LocationDetailFormArgs> {
  LocationDetailForm({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          LocationDetailForm.name,
          args: LocationDetailFormArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static const _i25.PageInfo<LocationDetailFormArgs> page =
      _i25.PageInfo<LocationDetailFormArgs>(name);
}

class LocationDetailFormArgs {
  const LocationDetailFormArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'LocationDetailFormArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.LoginScreen]
class LoginPage extends _i25.PageRouteInfo<void> {
  const LoginPage({List<_i25.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i14.MainTabView]
class MainTabView extends _i25.PageRouteInfo<void> {
  const MainTabView({List<_i25.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i15.NotificationView]
class NotificationView extends _i25.PageRouteInfo<void> {
  const NotificationView({List<_i25.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i16.OnBoarding1]
class Onboarding1 extends _i25.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static const _i25.PageInfo<Onboarding1Args> page =
      _i25.PageInfo<Onboarding1Args>(name);
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i17.OnBoarding2]
class Onboarding2 extends _i25.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static const _i25.PageInfo<Onboarding2Args> page =
      _i25.PageInfo<Onboarding2Args>(name);
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i18.OnBoarding3]
class OnBoarding3 extends _i25.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static const _i25.PageInfo<OnBoarding3Args> page =
      _i25.PageInfo<OnBoarding3Args>(name);
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i19.ProfileView]
class ProfileView extends _i25.PageRouteInfo<void> {
  const ProfileView({List<_i25.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i20.ReferenceListScreen]
class ReferenceListScreen extends _i25.PageRouteInfo<void> {
  const ReferenceListScreen({List<_i25.PageRouteInfo>? children})
      : super(
          ReferenceListScreen.name,
          initialChildren: children,
        );

  static const String name = 'ReferenceListScreen';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i21.RegisterProfileScreen]
class RegisterProfilePage extends _i25.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          RegisterProfilePage.name,
          args: RegisterProfilePageArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterProfilePage';

  static const _i25.PageInfo<RegisterProfilePageArgs> page =
      _i25.PageInfo<RegisterProfilePageArgs>(name);
}

class RegisterProfilePageArgs {
  const RegisterProfilePageArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key}';
  }
}

/// generated route for
/// [_i22.RegisterScreen]
class RegisterPage extends _i25.PageRouteInfo<void> {
  const RegisterPage({List<_i25.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i23.SplashPage]
class SplashPage extends _i25.PageRouteInfo<void> {
  const SplashPage({List<_i25.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i24.TermsAndConditionsScreen]
class TermsAndConditionsScreen
    extends _i25.PageRouteInfo<TermsAndConditionsScreenArgs> {
  TermsAndConditionsScreen({
    _i26.Key? key,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          TermsAndConditionsScreen.name,
          args: TermsAndConditionsScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'TermsAndConditionsScreen';

  static const _i25.PageInfo<TermsAndConditionsScreenArgs> page =
      _i25.PageInfo<TermsAndConditionsScreenArgs>(name);
}

class TermsAndConditionsScreenArgs {
  const TermsAndConditionsScreenArgs({this.key});

  final _i26.Key? key;

  @override
  String toString() {
    return 'TermsAndConditionsScreenArgs{key: $key}';
  }
}
