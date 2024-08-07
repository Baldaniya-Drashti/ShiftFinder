// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:flutter/material.dart' as _i34;
import 'package:shift/application/auth/contractor_auth/location_example.dart'
    as _i17;
import 'package:shift/presentation/auth/contractor_auth/add_bank_details.dart'
    as _i1;
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart'
    as _i3;
import 'package:shift/presentation/auth/contractor_auth/add_experience_detail.dart'
    as _i5;
import 'package:shift/presentation/auth/contractor_auth/documents/document_page.dart'
    as _i7;
import 'package:shift/presentation/auth/contractor_auth/education_details/add_education_detail.dart'
    as _i4;
import 'package:shift/presentation/auth/contractor_auth/education_details/education_detail_list.dart'
    as _i8;
import 'package:shift/presentation/auth/contractor_auth/intro_quiz.dart'
    as _i13;
import 'package:shift/presentation/auth/contractor_auth/intro_video.dart'
    as _i14;
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart'
    as _i15;
import 'package:shift/presentation/auth/contractor_auth/reference_details/add_reference_detail.dart'
    as _i6;
import 'package:shift/presentation/auth/contractor_auth/reference_details/reference_detail_list.dart'
    as _i25;
import 'package:shift/presentation/auth/contractor_auth/terms_conditions.dart'
    as _i29;
import 'package:shift/presentation/auth/employer_auth/add_card_detail.dart'
    as _i2;
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart'
    as _i16;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i18;
import 'package:shift/presentation/auth/register/register_profile.dart' as _i26;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i27;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post.dart'
    as _i9;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post_shit_type.dart'
    as _i10;
import 'package:shift/presentation/employer/home_view/view_dates.dart' as _i30;
import 'package:shift/presentation/employer/home_view/view_shift_details.dart'
    as _i31;
import 'package:shift/presentation/main/main_tab.dart' as _i19;
import 'package:shift/presentation/main/tabs/history_view.dart' as _i11;
import 'package:shift/presentation/main/tabs/home/home_view.dart' as _i12;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_single_applicants.dart'
    as _i32;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i20;
import 'package:shift/presentation/main/tabs/profile_view.dart' as _i24;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i21;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i22;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i23;
import 'package:shift/presentation/splash/splash_page.dart' as _i28;

abstract class $AppRouter extends _i33.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i33.PageFactory> pagesMap = {
    AddBankDetailsScreen.name: (routeData) {
      final args = routeData.argsAs<AddBankDetailsScreenArgs>(
          orElse: () => const AddBankDetailsScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AddBankDetailsScreen(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddCardDetailPage.name: (routeData) {
      final args = routeData.argsAs<AddCardDetailPageArgs>(
          orElse: () => const AddCardDetailPageArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddCardDetailPage(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddContractorSkillsForm.name: (routeData) {
      final args = routeData.argsAs<AddContractorSkillsFormArgs>(
          orElse: () => const AddContractorSkillsFormArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.AddContractorSkillsForm(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddEducationDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddEducationDetailScreenArgs>(
          orElse: () => const AddEducationDetailScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AddEducationDetail(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddExperienceDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddExperienceDetailScreenArgs>(
          orElse: () => const AddExperienceDetailScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.AddExperienceDetail(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddReferenceDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddReferenceDetailScreenArgs>(
          orElse: () => const AddReferenceDetailScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.AddReferenceDetail(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    DocumentPageScreen.name: (routeData) {
      final args = routeData.argsAs<DocumentPageScreenArgs>(
          orElse: () => const DocumentPageScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.DocumentPage(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    EducationListScreen.name: (routeData) {
      final args = routeData.argsAs<EducationListScreenArgs>(
          orElse: () => const EducationListScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.EducationListScreen(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    HealthCarePostForm.name: (routeData) {
      final args = routeData.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.HealthCarePostForm(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    HealthcarePostShift.name: (routeData) {
      final args = routeData.argsAs<HealthcarePostShiftArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.HealthcarePostShift(
          key: args.key,
          postId: args.postId,
        ),
      );
    },
    HistoryView.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.HistoryView(),
      );
    },
    HomeView.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.HomeView(),
      );
    },
    IntroQuizScreen.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.IntroQuizScreen(),
      );
    },
    IntroVideoScreen.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.IntroVideoScreen(),
      );
    },
    LegalScreeningQuestionsPage.name: (routeData) {
      final args = routeData.argsAs<LegalScreeningQuestionsPageArgs>(
          orElse: () => const LegalScreeningQuestionsPageArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.LegalScreeningQuestionsPage(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    LocationDetailForm.name: (routeData) {
      final args = routeData.argsAs<LocationDetailFormArgs>(
          orElse: () => const LocationDetailFormArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.LocationDetailForm(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    LocationExample.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.LocationExample(),
      );
    },
    LoginPage.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.LoginScreen(),
      );
    },
    MainTabView.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.MainTabView(),
      );
    },
    NotificationView.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.NotificationView(),
      );
    },
    Onboarding1.name: (routeData) {
      final args = routeData.argsAs<Onboarding1Args>(
          orElse: () => const Onboarding1Args());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.OnBoarding1(key: args.key),
      );
    },
    Onboarding2.name: (routeData) {
      final args = routeData.argsAs<Onboarding2Args>(
          orElse: () => const Onboarding2Args());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.OnBoarding2(key: args.key),
      );
    },
    OnBoarding3.name: (routeData) {
      final args = routeData.argsAs<OnBoarding3Args>(
          orElse: () => const OnBoarding3Args());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.OnBoarding3(key: args.key),
      );
    },
    ProfileView.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.ProfileView(),
      );
    },
    ReferenceListScreen.name: (routeData) {
      final args = routeData.argsAs<ReferenceListScreenArgs>(
          orElse: () => const ReferenceListScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.ReferenceListScreen(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    RegisterProfilePage.name: (routeData) {
      final args = routeData.argsAs<RegisterProfilePageArgs>();
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.RegisterProfileScreen(
          key: args.key,
          firstName: args.firstName,
          lastName: args.lastName,
          checkTermsPrivacy: args.checkTermsPrivacy,
        ),
      );
    },
    RegisterPage.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.RegisterScreen(),
      );
    },
    SplashPage.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.SplashPage(),
      );
    },
    TermsAndConditionsScreen.name: (routeData) {
      final args = routeData.argsAs<TermsAndConditionsScreenArgs>(
          orElse: () => const TermsAndConditionsScreenArgs());
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i29.TermsAndConditionsScreen(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    ViewDates.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.ViewDates(),
      );
    },
    ViewHomeShiftDetails.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.ViewHomeShiftDetails(),
      );
    },
    ViewSingleApplicants.name: (routeData) {
      return _i33.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.ViewSingleApplicants(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddBankDetailsScreen]
class AddBankDetailsScreen
    extends _i33.PageRouteInfo<AddBankDetailsScreenArgs> {
  AddBankDetailsScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddBankDetailsScreen.name,
          args: AddBankDetailsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBankDetailsScreen';

  static const _i33.PageInfo<AddBankDetailsScreenArgs> page =
      _i33.PageInfo<AddBankDetailsScreenArgs>(name);
}

class AddBankDetailsScreenArgs {
  const AddBankDetailsScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddBankDetailsScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i2.AddCardDetailPage]
class AddCardDetailPage extends _i33.PageRouteInfo<AddCardDetailPageArgs> {
  AddCardDetailPage({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddCardDetailPage.name,
          args: AddCardDetailPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCardDetailPage';

  static const _i33.PageInfo<AddCardDetailPageArgs> page =
      _i33.PageInfo<AddCardDetailPageArgs>(name);
}

class AddCardDetailPageArgs {
  const AddCardDetailPageArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddCardDetailPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i3.AddContractorSkillsForm]
class AddContractorSkillsForm
    extends _i33.PageRouteInfo<AddContractorSkillsFormArgs> {
  AddContractorSkillsForm({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddContractorSkillsForm.name,
          args: AddContractorSkillsFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddContractorSkillsForm';

  static const _i33.PageInfo<AddContractorSkillsFormArgs> page =
      _i33.PageInfo<AddContractorSkillsFormArgs>(name);
}

class AddContractorSkillsFormArgs {
  const AddContractorSkillsFormArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddContractorSkillsFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i4.AddEducationDetail]
class AddEducationDetailScreen
    extends _i33.PageRouteInfo<AddEducationDetailScreenArgs> {
  AddEducationDetailScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddEducationDetailScreen.name,
          args: AddEducationDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEducationDetailScreen';

  static const _i33.PageInfo<AddEducationDetailScreenArgs> page =
      _i33.PageInfo<AddEducationDetailScreenArgs>(name);
}

class AddEducationDetailScreenArgs {
  const AddEducationDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddEducationDetailScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i5.AddExperienceDetail]
class AddExperienceDetailScreen
    extends _i33.PageRouteInfo<AddExperienceDetailScreenArgs> {
  AddExperienceDetailScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddExperienceDetailScreen.name,
          args: AddExperienceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExperienceDetailScreen';

  static const _i33.PageInfo<AddExperienceDetailScreenArgs> page =
      _i33.PageInfo<AddExperienceDetailScreenArgs>(name);
}

class AddExperienceDetailScreenArgs {
  const AddExperienceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddExperienceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i6.AddReferenceDetail]
class AddReferenceDetailScreen
    extends _i33.PageRouteInfo<AddReferenceDetailScreenArgs> {
  AddReferenceDetailScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddReferenceDetailScreen.name,
          args: AddReferenceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddReferenceDetailScreen';

  static const _i33.PageInfo<AddReferenceDetailScreenArgs> page =
      _i33.PageInfo<AddReferenceDetailScreenArgs>(name);
}

class AddReferenceDetailScreenArgs {
  const AddReferenceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddReferenceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i7.DocumentPage]
class DocumentPageScreen extends _i33.PageRouteInfo<DocumentPageScreenArgs> {
  DocumentPageScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          DocumentPageScreen.name,
          args: DocumentPageScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'DocumentPageScreen';

  static const _i33.PageInfo<DocumentPageScreenArgs> page =
      _i33.PageInfo<DocumentPageScreenArgs>(name);
}

class DocumentPageScreenArgs {
  const DocumentPageScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'DocumentPageScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i8.EducationListScreen]
class EducationListScreen extends _i33.PageRouteInfo<EducationListScreenArgs> {
  EducationListScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          EducationListScreen.name,
          args: EducationListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationListScreen';

  static const _i33.PageInfo<EducationListScreenArgs> page =
      _i33.PageInfo<EducationListScreenArgs>(name);
}

class EducationListScreenArgs {
  const EducationListScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'EducationListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i9.HealthCarePostForm]
class HealthCarePostForm extends _i33.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          HealthCarePostForm.name,
          args: HealthCarePostFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthCarePostForm';

  static const _i33.PageInfo<HealthCarePostFormArgs> page =
      _i33.PageInfo<HealthCarePostFormArgs>(name);
}

class HealthCarePostFormArgs {
  const HealthCarePostFormArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i10.HealthcarePostShift]
class HealthcarePostShift extends _i33.PageRouteInfo<HealthcarePostShiftArgs> {
  HealthcarePostShift({
    _i34.Key? key,
    required int postId,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          HealthcarePostShift.name,
          args: HealthcarePostShiftArgs(
            key: key,
            postId: postId,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthcarePostShift';

  static const _i33.PageInfo<HealthcarePostShiftArgs> page =
      _i33.PageInfo<HealthcarePostShiftArgs>(name);
}

class HealthcarePostShiftArgs {
  const HealthcarePostShiftArgs({
    this.key,
    required this.postId,
  });

  final _i34.Key? key;

  final int postId;

  @override
  String toString() {
    return 'HealthcarePostShiftArgs{key: $key, postId: $postId}';
  }
}

/// generated route for
/// [_i11.HistoryView]
class HistoryView extends _i33.PageRouteInfo<void> {
  const HistoryView({List<_i33.PageRouteInfo>? children})
      : super(
          HistoryView.name,
          initialChildren: children,
        );

  static const String name = 'HistoryView';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i12.HomeView]
class HomeView extends _i33.PageRouteInfo<void> {
  const HomeView({List<_i33.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i13.IntroQuizScreen]
class IntroQuizScreen extends _i33.PageRouteInfo<void> {
  const IntroQuizScreen({List<_i33.PageRouteInfo>? children})
      : super(
          IntroQuizScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroQuizScreen';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i14.IntroVideoScreen]
class IntroVideoScreen extends _i33.PageRouteInfo<void> {
  const IntroVideoScreen({List<_i33.PageRouteInfo>? children})
      : super(
          IntroVideoScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroVideoScreen';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i15.LegalScreeningQuestionsPage]
class LegalScreeningQuestionsPage
    extends _i33.PageRouteInfo<LegalScreeningQuestionsPageArgs> {
  LegalScreeningQuestionsPage({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          LegalScreeningQuestionsPage.name,
          args: LegalScreeningQuestionsPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LegalScreeningQuestionsPage';

  static const _i33.PageInfo<LegalScreeningQuestionsPageArgs> page =
      _i33.PageInfo<LegalScreeningQuestionsPageArgs>(name);
}

class LegalScreeningQuestionsPageArgs {
  const LegalScreeningQuestionsPageArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LegalScreeningQuestionsPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i16.LocationDetailForm]
class LocationDetailForm extends _i33.PageRouteInfo<LocationDetailFormArgs> {
  LocationDetailForm({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          LocationDetailForm.name,
          args: LocationDetailFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static const _i33.PageInfo<LocationDetailFormArgs> page =
      _i33.PageInfo<LocationDetailFormArgs>(name);
}

class LocationDetailFormArgs {
  const LocationDetailFormArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LocationDetailFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i17.LocationExample]
class LocationExample extends _i33.PageRouteInfo<void> {
  const LocationExample({List<_i33.PageRouteInfo>? children})
      : super(
          LocationExample.name,
          initialChildren: children,
        );

  static const String name = 'LocationExample';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i18.LoginScreen]
class LoginPage extends _i33.PageRouteInfo<void> {
  const LoginPage({List<_i33.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i19.MainTabView]
class MainTabView extends _i33.PageRouteInfo<void> {
  const MainTabView({List<_i33.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i20.NotificationView]
class NotificationView extends _i33.PageRouteInfo<void> {
  const NotificationView({List<_i33.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i21.OnBoarding1]
class Onboarding1 extends _i33.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static const _i33.PageInfo<Onboarding1Args> page =
      _i33.PageInfo<Onboarding1Args>(name);
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i22.OnBoarding2]
class Onboarding2 extends _i33.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static const _i33.PageInfo<Onboarding2Args> page =
      _i33.PageInfo<Onboarding2Args>(name);
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i23.OnBoarding3]
class OnBoarding3 extends _i33.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static const _i33.PageInfo<OnBoarding3Args> page =
      _i33.PageInfo<OnBoarding3Args>(name);
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i24.ProfileView]
class ProfileView extends _i33.PageRouteInfo<void> {
  const ProfileView({List<_i33.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i25.ReferenceListScreen]
class ReferenceListScreen extends _i33.PageRouteInfo<ReferenceListScreenArgs> {
  ReferenceListScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          ReferenceListScreen.name,
          args: ReferenceListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'ReferenceListScreen';

  static const _i33.PageInfo<ReferenceListScreenArgs> page =
      _i33.PageInfo<ReferenceListScreenArgs>(name);
}

class ReferenceListScreenArgs {
  const ReferenceListScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'ReferenceListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i26.RegisterProfileScreen]
class RegisterProfilePage extends _i33.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i34.Key? key,
    required String firstName,
    required String lastName,
    required int checkTermsPrivacy,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          RegisterProfilePage.name,
          args: RegisterProfilePageArgs(
            key: key,
            firstName: firstName,
            lastName: lastName,
            checkTermsPrivacy: checkTermsPrivacy,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterProfilePage';

  static const _i33.PageInfo<RegisterProfilePageArgs> page =
      _i33.PageInfo<RegisterProfilePageArgs>(name);
}

class RegisterProfilePageArgs {
  const RegisterProfilePageArgs({
    this.key,
    required this.firstName,
    required this.lastName,
    required this.checkTermsPrivacy,
  });

  final _i34.Key? key;

  final String firstName;

  final String lastName;

  final int checkTermsPrivacy;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key, firstName: $firstName, lastName: $lastName, checkTermsPrivacy: $checkTermsPrivacy}';
  }
}

/// generated route for
/// [_i27.RegisterScreen]
class RegisterPage extends _i33.PageRouteInfo<void> {
  const RegisterPage({List<_i33.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i28.SplashPage]
class SplashPage extends _i33.PageRouteInfo<void> {
  const SplashPage({List<_i33.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i29.TermsAndConditionsScreen]
class TermsAndConditionsScreen
    extends _i33.PageRouteInfo<TermsAndConditionsScreenArgs> {
  TermsAndConditionsScreen({
    _i34.Key? key,
    bool isFromSplash = false,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          TermsAndConditionsScreen.name,
          args: TermsAndConditionsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'TermsAndConditionsScreen';

  static const _i33.PageInfo<TermsAndConditionsScreenArgs> page =
      _i33.PageInfo<TermsAndConditionsScreenArgs>(name);
}

class TermsAndConditionsScreenArgs {
  const TermsAndConditionsScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i34.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'TermsAndConditionsScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i30.ViewDates]
class ViewDates extends _i33.PageRouteInfo<void> {
  const ViewDates({List<_i33.PageRouteInfo>? children})
      : super(
          ViewDates.name,
          initialChildren: children,
        );

  static const String name = 'ViewDates';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i31.ViewHomeShiftDetails]
class ViewHomeShiftDetails extends _i33.PageRouteInfo<void> {
  const ViewHomeShiftDetails({List<_i33.PageRouteInfo>? children})
      : super(
          ViewHomeShiftDetails.name,
          initialChildren: children,
        );

  static const String name = 'ViewHomeShiftDetails';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i32.ViewSingleApplicants]
class ViewSingleApplicants extends _i33.PageRouteInfo<void> {
  const ViewSingleApplicants({List<_i33.PageRouteInfo>? children})
      : super(
          ViewSingleApplicants.name,
          initialChildren: children,
        );

  static const String name = 'ViewSingleApplicants';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}
