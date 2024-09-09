// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i54;
import 'package:flutter/material.dart' as _i55;
import 'package:shift/application/auth/contractor_auth/location_example.dart'
    as _i25;
import 'package:shift/infrastructure/core/education_dto/education_dto.dart'
    as _i56;
import 'package:shift/infrastructure/core/reference_dto/reference_dto.dart'
    as _i61;
import 'package:shift/infrastructure/main/employer_team/get_teams_dto.dart'
    as _i60;
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart'
    as _i58;
import 'package:shift/infrastructure/main/multi_shift_dto/multi_shift_dto.dart'
    as _i57;
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart'
    as _i59;
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart'
    as _i62;
import 'package:shift/presentation/auth/contractor_auth/add_bank_details.dart'
    as _i1;
import 'package:shift/presentation/auth/contractor_auth/add_contractor_skills.dart'
    as _i4;
import 'package:shift/presentation/auth/contractor_auth/add_experience_detail.dart'
    as _i6;
import 'package:shift/presentation/auth/contractor_auth/add_speciality_experience.dart'
    as _i11;
import 'package:shift/presentation/auth/contractor_auth/documents/document_page.dart'
    as _i15;
import 'package:shift/presentation/auth/contractor_auth/education_details/add_education_detail.dart'
    as _i5;
import 'package:shift/presentation/auth/contractor_auth/education_details/education_detail_list.dart'
    as _i16;
import 'package:shift/presentation/auth/contractor_auth/intro_quiz.dart'
    as _i21;
import 'package:shift/presentation/auth/contractor_auth/intro_video.dart'
    as _i22;
import 'package:shift/presentation/auth/contractor_auth/legal_screening_questions.dart'
    as _i23;
import 'package:shift/presentation/auth/contractor_auth/quiz_result.dart'
    as _i38;
import 'package:shift/presentation/auth/contractor_auth/reference_details/add_reference_detail.dart'
    as _i10;
import 'package:shift/presentation/auth/contractor_auth/reference_details/reference_detail_list.dart'
    as _i39;
import 'package:shift/presentation/auth/contractor_auth/terms_conditions.dart'
    as _i47;
import 'package:shift/presentation/auth/employer_auth/add_card_detail.dart'
    as _i2;
import 'package:shift/presentation/auth/employer_auth/location_detail_form.dart'
    as _i24;
import 'package:shift/presentation/auth/login/login_screen.dart' as _i26;
import 'package:shift/presentation/auth/register/register_profile.dart' as _i40;
import 'package:shift/presentation/auth/register/register_screen.dart' as _i41;
import 'package:shift/presentation/core/widgets/google_map/show_google_map.dart'
    as _i43;
import 'package:shift/presentation/employer/healthcare_post/add_multi_date_time.dart'
    as _i7;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post.dart'
    as _i17;
import 'package:shift/presentation/employer/healthcare_post/healthcare_post_shit_type.dart'
    as _i18;
import 'package:shift/presentation/employer/healthcare_post/payable_detail.dart'
    as _i32;
import 'package:shift/presentation/employer/healthcare_post/post_shift_recurring.dart'
    as _i34;
import 'package:shift/presentation/employer/healthcare_post/review_post_detail.dart'
    as _i42;
import 'package:shift/presentation/employer/home_view/view_dates.dart' as _i50;
import 'package:shift/presentation/employer/home_view/view_shift_details.dart'
    as _i51;
import 'package:shift/presentation/main/main_tab.dart' as _i27;
import 'package:shift/presentation/main/tabs/history_view.dart' as _i19;
import 'package:shift/presentation/main/tabs/home/home_view.dart' as _i20;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/awaiting_confirmation_view.dart'
    as _i12;
import 'package:shift/presentation/main/tabs/home/praposals/counter_prapose/counter_purpose_view.dart'
    as _i14;
import 'package:shift/presentation/main/tabs/home/praposals/total_praposal_view.dart'
    as _i48;
import 'package:shift/presentation/main/tabs/home/praposals/widgets/view_person_praposal_view.dart'
    as _i52;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/view_applicant_profile.dart'
    as _i49;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/common_document_view.dart'
    as _i13;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/personal_reference_detail.dart'
    as _i33;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_applicants/widgets/professional_reference_detail.dart'
    as _i36;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/view_single_applicants.dart'
    as _i53;
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/add_card_view.dart'
    as _i3;
import 'package:shift/presentation/main/tabs/notification_view.dart' as _i28;
import 'package:shift/presentation/main/tabs/profile/profile_view.dart' as _i37;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_member/add_new_member_view.dart'
    as _i8;
import 'package:shift/presentation/main/tabs/profile/teams/add_new_team/add_new_team_view.dart'
    as _i9;
import 'package:shift/presentation/main/tabs/profile/teams/team_detail/team_detail_view.dart'
    as _i45;
import 'package:shift/presentation/main/tabs/profile/teams/teams_view.dart'
    as _i46;
import 'package:shift/presentation/onboarding/onboarding1.dart' as _i29;
import 'package:shift/presentation/onboarding/onboarding2.dart' as _i30;
import 'package:shift/presentation/onboarding/onboarding3.dart' as _i31;
import 'package:shift/presentation/privacy_policy/privacy_policy.dart' as _i35;
import 'package:shift/presentation/splash/splash_page.dart' as _i44;

abstract class $AppRouter extends _i54.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i54.PageFactory> pagesMap = {
    AddBankDetailsScreen.name: (routeData) {
      final args = routeData.argsAs<AddBankDetailsScreenArgs>(
          orElse: () => const AddBankDetailsScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
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
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddCardDetailPage(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddCardView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AddCardView(),
      );
    },
    AddContractorSkillsForm.name: (routeData) {
      final args = routeData.argsAs<AddContractorSkillsFormArgs>(
          orElse: () => const AddContractorSkillsFormArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AddContractorSkillsForm(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddEducationDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddEducationDetailScreenArgs>(
          orElse: () => const AddEducationDetailScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.AddEducationDetail(
          key: args.key,
          isFromSplash: args.isFromSplash,
          educationObj: args.educationObj,
        ),
      );
    },
    AddExperienceDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddExperienceDetailScreenArgs>(
          orElse: () => const AddExperienceDetailScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.AddExperienceDetail(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AddMultiDateTime.name: (routeData) {
      final args = routeData.argsAs<AddMultiDateTimeArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.AddMultiDateTime(
          key: args.key,
          selectedObj: args.selectedObj,
          updateShift: args.updateShift,
          post: args.post,
        ),
      );
    },
    AddNewMemberView.name: (routeData) {
      final args = routeData.argsAs<AddNewMemberViewArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.AddNewMemberView(
          key: args.key,
          isUpdateMember: args.isUpdateMember,
          getTeamsListDTO: args.getTeamsListDTO,
          teamID: args.teamID,
        ),
      );
    },
    AddNewTeamView.name: (routeData) {
      final args = routeData.argsAs<AddNewTeamViewArgs>(
          orElse: () => const AddNewTeamViewArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.AddNewTeamView(
          key: args.key,
          isUpdateMember: args.isUpdateMember,
          getTeamsListDTO: args.getTeamsListDTO,
        ),
      );
    },
    AddReferenceDetailScreen.name: (routeData) {
      final args = routeData.argsAs<AddReferenceDetailScreenArgs>(
          orElse: () => const AddReferenceDetailScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.AddReferenceDetail(
          key: args.key,
          isFromSplash: args.isFromSplash,
          referenceObj: args.referenceObj,
        ),
      );
    },
    AddSpecialityExperience.name: (routeData) {
      final args = routeData.argsAs<AddSpecialityExperienceArgs>(
          orElse: () => const AddSpecialityExperienceArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.AddSpecialityExperience(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    AwaitingConfirmationView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.AwaitingConfirmationView(),
      );
    },
    CommonDocumentView.name: (routeData) {
      final args = routeData.argsAs<CommonDocumentViewArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.CommonDocumentView(
          key: args.key,
          title: args.title,
          pdfUrl: args.pdfUrl,
        ),
      );
    },
    CounterPurposeView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.CounterPurposeView(),
      );
    },
    DocumentPageScreen.name: (routeData) {
      final args = routeData.argsAs<DocumentPageScreenArgs>(
          orElse: () => const DocumentPageScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.DocumentPage(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    EducationListScreen.name: (routeData) {
      final args = routeData.argsAs<EducationListScreenArgs>(
          orElse: () => const EducationListScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.EducationListScreen(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    HealthCarePostForm.name: (routeData) {
      final args = routeData.argsAs<HealthCarePostFormArgs>(
          orElse: () => const HealthCarePostFormArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.HealthCarePostForm(
          key: args.key,
          postId: args.postId,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    HealthcarePostShift.name: (routeData) {
      final args = routeData.argsAs<HealthcarePostShiftArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.HealthcarePostShift(
          key: args.key,
          postId: args.postId,
          updateShift: args.updateShift,
          post: args.post,
        ),
      );
    },
    HistoryView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.HistoryView(),
      );
    },
    HomeView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.HomeView(),
      );
    },
    IntroQuizScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.IntroQuizScreen(),
      );
    },
    IntroVideoScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.IntroVideoScreen(),
      );
    },
    LegalScreeningQuestionsPage.name: (routeData) {
      final args = routeData.argsAs<LegalScreeningQuestionsPageArgs>(
          orElse: () => const LegalScreeningQuestionsPageArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.LegalScreeningQuestionsPage(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    LocationDetailForm.name: (routeData) {
      final args = routeData.argsAs<LocationDetailFormArgs>(
          orElse: () => const LocationDetailFormArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.LocationDetailForm(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    LocationExample.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.LocationExample(),
      );
    },
    LoginPage.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.LoginScreen(),
      );
    },
    MainTabView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.MainTabView(),
      );
    },
    NotificationView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.NotificationView(),
      );
    },
    Onboarding1.name: (routeData) {
      final args = routeData.argsAs<Onboarding1Args>(
          orElse: () => const Onboarding1Args());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i29.OnBoarding1(key: args.key),
      );
    },
    Onboarding2.name: (routeData) {
      final args = routeData.argsAs<Onboarding2Args>(
          orElse: () => const Onboarding2Args());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i30.OnBoarding2(key: args.key),
      );
    },
    OnBoarding3.name: (routeData) {
      final args = routeData.argsAs<OnBoarding3Args>(
          orElse: () => const OnBoarding3Args());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.OnBoarding3(key: args.key),
      );
    },
    PayableDetail.name: (routeData) {
      final args = routeData.argsAs<PayableDetailArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i32.PayableDetail(
          key: args.key,
          post: args.post,
          isUpdate: args.isUpdate,
          updatedPost: args.updatedPost,
        ),
      );
    },
    PersonalReferenceDetail.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.PersonalReferenceDetail(),
      );
    },
    PostShiftRecurring.name: (routeData) {
      final args = routeData.argsAs<PostShiftRecurringArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i34.PostShiftRecurring(
          key: args.key,
          shiftType: args.shiftType,
          updateShift: args.updateShift,
          post: args.post,
        ),
      );
    },
    PrivacyPolicyScreen.name: (routeData) {
      final args = routeData.argsAs<PrivacyPolicyScreenArgs>(
          orElse: () => const PrivacyPolicyScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i35.PrivacyPolicyScreen(key: args.key),
      );
    },
    ProfessionalReferenceDetail.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.ProfessionalReferenceDetail(),
      );
    },
    ProfileView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.ProfileView(),
      );
    },
    QuizResultScreen.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i38.QuizResultScreen(),
      );
    },
    ReferenceListScreen.name: (routeData) {
      final args = routeData.argsAs<ReferenceListScreenArgs>(
          orElse: () => const ReferenceListScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i39.ReferenceListScreen(
          key: args.key,
          isFromSplash: args.isFromSplash,
        ),
      );
    },
    RegisterProfilePage.name: (routeData) {
      final args = routeData.argsAs<RegisterProfilePageArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i40.RegisterProfileScreen(
          key: args.key,
          firstName: args.firstName,
          lastName: args.lastName,
          checkTermsPrivacy: args.checkTermsPrivacy,
        ),
      );
    },
    RegisterPage.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i41.RegisterScreen(),
      );
    },
    ReviewPostShiftDetail.name: (routeData) {
      final args = routeData.argsAs<ReviewPostShiftDetailArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i42.ReviewPostShiftDetail(
          key: args.key,
          post: args.post,
          isUpdate: args.isUpdate,
          updatedPost: args.updatedPost,
        ),
      );
    },
    ShowGoogleMap.name: (routeData) {
      final args = routeData.argsAs<ShowGoogleMapArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i43.ShowGoogleMap(
          key: args.key,
          latitude: args.latitude,
          longitude: args.longitude,
        ),
      );
    },
    SplashPage.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i44.SplashPage(),
      );
    },
    TeamDetailView.name: (routeData) {
      final args = routeData.argsAs<TeamDetailViewArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i45.TeamDetailView(
          key: args.key,
          getTeamsListDTO: args.getTeamsListDTO,
        ),
      );
    },
    TeamsView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i46.TeamsView(),
      );
    },
    TermsAndConditionsScreen.name: (routeData) {
      final args = routeData.argsAs<TermsAndConditionsScreenArgs>(
          orElse: () => const TermsAndConditionsScreenArgs());
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i47.TermsAndConditionsScreen(
          key: args.key,
          isFromSplash: args.isFromSplash,
          isFromRegister: args.isFromRegister,
        ),
      );
    },
    TotalPraposalView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i48.TotalPraposalView(),
      );
    },
    ViewApplicantProfile.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i49.ViewApplicantProfile(),
      );
    },
    ViewDates.name: (routeData) {
      final args = routeData.argsAs<ViewDatesArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i50.ViewDates(
          key: args.key,
          shiftDetail: args.shiftDetail,
        ),
      );
    },
    ViewHomeShiftDetails.name: (routeData) {
      final args = routeData.argsAs<ViewHomeShiftDetailsArgs>();
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i51.ViewHomeShiftDetails(
          key: args.key,
          postId: args.postId,
          isTotalApplicants: args.isTotalApplicants,
        ),
      );
    },
    ViewPersonPraposalView.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i52.ViewPersonPraposalView(),
      );
    },
    ViewSingleApplicants.name: (routeData) {
      return _i54.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i53.ViewSingleApplicants(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddBankDetailsScreen]
class AddBankDetailsScreen
    extends _i54.PageRouteInfo<AddBankDetailsScreenArgs> {
  AddBankDetailsScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddBankDetailsScreen.name,
          args: AddBankDetailsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddBankDetailsScreen';

  static const _i54.PageInfo<AddBankDetailsScreenArgs> page =
      _i54.PageInfo<AddBankDetailsScreenArgs>(name);
}

class AddBankDetailsScreenArgs {
  const AddBankDetailsScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddBankDetailsScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i2.AddCardDetailPage]
class AddCardDetailPage extends _i54.PageRouteInfo<AddCardDetailPageArgs> {
  AddCardDetailPage({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddCardDetailPage.name,
          args: AddCardDetailPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCardDetailPage';

  static const _i54.PageInfo<AddCardDetailPageArgs> page =
      _i54.PageInfo<AddCardDetailPageArgs>(name);
}

class AddCardDetailPageArgs {
  const AddCardDetailPageArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddCardDetailPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i3.AddCardView]
class AddCardView extends _i54.PageRouteInfo<void> {
  const AddCardView({List<_i54.PageRouteInfo>? children})
      : super(
          AddCardView.name,
          initialChildren: children,
        );

  static const String name = 'AddCardView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AddContractorSkillsForm]
class AddContractorSkillsForm
    extends _i54.PageRouteInfo<AddContractorSkillsFormArgs> {
  AddContractorSkillsForm({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddContractorSkillsForm.name,
          args: AddContractorSkillsFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddContractorSkillsForm';

  static const _i54.PageInfo<AddContractorSkillsFormArgs> page =
      _i54.PageInfo<AddContractorSkillsFormArgs>(name);
}

class AddContractorSkillsFormArgs {
  const AddContractorSkillsFormArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddContractorSkillsFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i5.AddEducationDetail]
class AddEducationDetailScreen
    extends _i54.PageRouteInfo<AddEducationDetailScreenArgs> {
  AddEducationDetailScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    _i56.EducationDTO? educationObj,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddEducationDetailScreen.name,
          args: AddEducationDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            educationObj: educationObj,
          ),
          initialChildren: children,
        );

  static const String name = 'AddEducationDetailScreen';

  static const _i54.PageInfo<AddEducationDetailScreenArgs> page =
      _i54.PageInfo<AddEducationDetailScreenArgs>(name);
}

class AddEducationDetailScreenArgs {
  const AddEducationDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.educationObj,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  final _i56.EducationDTO? educationObj;

  @override
  String toString() {
    return 'AddEducationDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, educationObj: $educationObj}';
  }
}

/// generated route for
/// [_i6.AddExperienceDetail]
class AddExperienceDetailScreen
    extends _i54.PageRouteInfo<AddExperienceDetailScreenArgs> {
  AddExperienceDetailScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddExperienceDetailScreen.name,
          args: AddExperienceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddExperienceDetailScreen';

  static const _i54.PageInfo<AddExperienceDetailScreenArgs> page =
      _i54.PageInfo<AddExperienceDetailScreenArgs>(name);
}

class AddExperienceDetailScreenArgs {
  const AddExperienceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddExperienceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i7.AddMultiDateTime]
class AddMultiDateTime extends _i54.PageRouteInfo<AddMultiDateTimeArgs> {
  AddMultiDateTime({
    _i55.Key? key,
    required _i57.MultiShiftDTO selectedObj,
    _i58.HealthcarePostDTO? updateShift,
    required _i59.PostShiftDTO post,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddMultiDateTime.name,
          args: AddMultiDateTimeArgs(
            key: key,
            selectedObj: selectedObj,
            updateShift: updateShift,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMultiDateTime';

  static const _i54.PageInfo<AddMultiDateTimeArgs> page =
      _i54.PageInfo<AddMultiDateTimeArgs>(name);
}

class AddMultiDateTimeArgs {
  const AddMultiDateTimeArgs({
    this.key,
    required this.selectedObj,
    this.updateShift,
    required this.post,
  });

  final _i55.Key? key;

  final _i57.MultiShiftDTO selectedObj;

  final _i58.HealthcarePostDTO? updateShift;

  final _i59.PostShiftDTO post;

  @override
  String toString() {
    return 'AddMultiDateTimeArgs{key: $key, selectedObj: $selectedObj, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i8.AddNewMemberView]
class AddNewMemberView extends _i54.PageRouteInfo<AddNewMemberViewArgs> {
  AddNewMemberView({
    _i55.Key? key,
    bool isUpdateMember = false,
    required _i60.Members? getTeamsListDTO,
    required String teamID,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddNewMemberView.name,
          args: AddNewMemberViewArgs(
            key: key,
            isUpdateMember: isUpdateMember,
            getTeamsListDTO: getTeamsListDTO,
            teamID: teamID,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewMemberView';

  static const _i54.PageInfo<AddNewMemberViewArgs> page =
      _i54.PageInfo<AddNewMemberViewArgs>(name);
}

class AddNewMemberViewArgs {
  const AddNewMemberViewArgs({
    this.key,
    this.isUpdateMember = false,
    required this.getTeamsListDTO,
    required this.teamID,
  });

  final _i55.Key? key;

  final bool isUpdateMember;

  final _i60.Members? getTeamsListDTO;

  final String teamID;

  @override
  String toString() {
    return 'AddNewMemberViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO, teamID: $teamID}';
  }
}

/// generated route for
/// [_i9.AddNewTeamView]
class AddNewTeamView extends _i54.PageRouteInfo<AddNewTeamViewArgs> {
  AddNewTeamView({
    _i55.Key? key,
    bool isUpdateMember = false,
    _i60.GetTeamsListDTO? getTeamsListDTO,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddNewTeamView.name,
          args: AddNewTeamViewArgs(
            key: key,
            isUpdateMember: isUpdateMember,
            getTeamsListDTO: getTeamsListDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'AddNewTeamView';

  static const _i54.PageInfo<AddNewTeamViewArgs> page =
      _i54.PageInfo<AddNewTeamViewArgs>(name);
}

class AddNewTeamViewArgs {
  const AddNewTeamViewArgs({
    this.key,
    this.isUpdateMember = false,
    this.getTeamsListDTO,
  });

  final _i55.Key? key;

  final bool isUpdateMember;

  final _i60.GetTeamsListDTO? getTeamsListDTO;

  @override
  String toString() {
    return 'AddNewTeamViewArgs{key: $key, isUpdateMember: $isUpdateMember, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i10.AddReferenceDetail]
class AddReferenceDetailScreen
    extends _i54.PageRouteInfo<AddReferenceDetailScreenArgs> {
  AddReferenceDetailScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    _i61.ReferenceDTO? referenceObj,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddReferenceDetailScreen.name,
          args: AddReferenceDetailScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            referenceObj: referenceObj,
          ),
          initialChildren: children,
        );

  static const String name = 'AddReferenceDetailScreen';

  static const _i54.PageInfo<AddReferenceDetailScreenArgs> page =
      _i54.PageInfo<AddReferenceDetailScreenArgs>(name);
}

class AddReferenceDetailScreenArgs {
  const AddReferenceDetailScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.referenceObj,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  final _i61.ReferenceDTO? referenceObj;

  @override
  String toString() {
    return 'AddReferenceDetailScreenArgs{key: $key, isFromSplash: $isFromSplash, referenceObj: $referenceObj}';
  }
}

/// generated route for
/// [_i11.AddSpecialityExperience]
class AddSpecialityExperience
    extends _i54.PageRouteInfo<AddSpecialityExperienceArgs> {
  AddSpecialityExperience({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          AddSpecialityExperience.name,
          args: AddSpecialityExperienceArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'AddSpecialityExperience';

  static const _i54.PageInfo<AddSpecialityExperienceArgs> page =
      _i54.PageInfo<AddSpecialityExperienceArgs>(name);
}

class AddSpecialityExperienceArgs {
  const AddSpecialityExperienceArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'AddSpecialityExperienceArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i12.AwaitingConfirmationView]
class AwaitingConfirmationView extends _i54.PageRouteInfo<void> {
  const AwaitingConfirmationView({List<_i54.PageRouteInfo>? children})
      : super(
          AwaitingConfirmationView.name,
          initialChildren: children,
        );

  static const String name = 'AwaitingConfirmationView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i13.CommonDocumentView]
class CommonDocumentView extends _i54.PageRouteInfo<CommonDocumentViewArgs> {
  CommonDocumentView({
    _i55.Key? key,
    required String title,
    required String pdfUrl,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          CommonDocumentView.name,
          args: CommonDocumentViewArgs(
            key: key,
            title: title,
            pdfUrl: pdfUrl,
          ),
          initialChildren: children,
        );

  static const String name = 'CommonDocumentView';

  static const _i54.PageInfo<CommonDocumentViewArgs> page =
      _i54.PageInfo<CommonDocumentViewArgs>(name);
}

class CommonDocumentViewArgs {
  const CommonDocumentViewArgs({
    this.key,
    required this.title,
    required this.pdfUrl,
  });

  final _i55.Key? key;

  final String title;

  final String pdfUrl;

  @override
  String toString() {
    return 'CommonDocumentViewArgs{key: $key, title: $title, pdfUrl: $pdfUrl}';
  }
}

/// generated route for
/// [_i14.CounterPurposeView]
class CounterPurposeView extends _i54.PageRouteInfo<void> {
  const CounterPurposeView({List<_i54.PageRouteInfo>? children})
      : super(
          CounterPurposeView.name,
          initialChildren: children,
        );

  static const String name = 'CounterPurposeView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i15.DocumentPage]
class DocumentPageScreen extends _i54.PageRouteInfo<DocumentPageScreenArgs> {
  DocumentPageScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          DocumentPageScreen.name,
          args: DocumentPageScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'DocumentPageScreen';

  static const _i54.PageInfo<DocumentPageScreenArgs> page =
      _i54.PageInfo<DocumentPageScreenArgs>(name);
}

class DocumentPageScreenArgs {
  const DocumentPageScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'DocumentPageScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i16.EducationListScreen]
class EducationListScreen extends _i54.PageRouteInfo<EducationListScreenArgs> {
  EducationListScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          EducationListScreen.name,
          args: EducationListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'EducationListScreen';

  static const _i54.PageInfo<EducationListScreenArgs> page =
      _i54.PageInfo<EducationListScreenArgs>(name);
}

class EducationListScreenArgs {
  const EducationListScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'EducationListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i17.HealthCarePostForm]
class HealthCarePostForm extends _i54.PageRouteInfo<HealthCarePostFormArgs> {
  HealthCarePostForm({
    _i55.Key? key,
    int? postId,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          HealthCarePostForm.name,
          args: HealthCarePostFormArgs(
            key: key,
            postId: postId,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthCarePostForm';

  static const _i54.PageInfo<HealthCarePostFormArgs> page =
      _i54.PageInfo<HealthCarePostFormArgs>(name);
}

class HealthCarePostFormArgs {
  const HealthCarePostFormArgs({
    this.key,
    this.postId,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final int? postId;

  final bool isFromSplash;

  @override
  String toString() {
    return 'HealthCarePostFormArgs{key: $key, postId: $postId, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i18.HealthcarePostShift]
class HealthcarePostShift extends _i54.PageRouteInfo<HealthcarePostShiftArgs> {
  HealthcarePostShift({
    _i55.Key? key,
    required int postId,
    _i58.HealthcarePostDTO? updateShift,
    required _i59.PostShiftDTO post,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          HealthcarePostShift.name,
          args: HealthcarePostShiftArgs(
            key: key,
            postId: postId,
            updateShift: updateShift,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'HealthcarePostShift';

  static const _i54.PageInfo<HealthcarePostShiftArgs> page =
      _i54.PageInfo<HealthcarePostShiftArgs>(name);
}

class HealthcarePostShiftArgs {
  const HealthcarePostShiftArgs({
    this.key,
    required this.postId,
    this.updateShift,
    required this.post,
  });

  final _i55.Key? key;

  final int postId;

  final _i58.HealthcarePostDTO? updateShift;

  final _i59.PostShiftDTO post;

  @override
  String toString() {
    return 'HealthcarePostShiftArgs{key: $key, postId: $postId, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i19.HistoryView]
class HistoryView extends _i54.PageRouteInfo<void> {
  const HistoryView({List<_i54.PageRouteInfo>? children})
      : super(
          HistoryView.name,
          initialChildren: children,
        );

  static const String name = 'HistoryView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i20.HomeView]
class HomeView extends _i54.PageRouteInfo<void> {
  const HomeView({List<_i54.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i21.IntroQuizScreen]
class IntroQuizScreen extends _i54.PageRouteInfo<void> {
  const IntroQuizScreen({List<_i54.PageRouteInfo>? children})
      : super(
          IntroQuizScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroQuizScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i22.IntroVideoScreen]
class IntroVideoScreen extends _i54.PageRouteInfo<void> {
  const IntroVideoScreen({List<_i54.PageRouteInfo>? children})
      : super(
          IntroVideoScreen.name,
          initialChildren: children,
        );

  static const String name = 'IntroVideoScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i23.LegalScreeningQuestionsPage]
class LegalScreeningQuestionsPage
    extends _i54.PageRouteInfo<LegalScreeningQuestionsPageArgs> {
  LegalScreeningQuestionsPage({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          LegalScreeningQuestionsPage.name,
          args: LegalScreeningQuestionsPageArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LegalScreeningQuestionsPage';

  static const _i54.PageInfo<LegalScreeningQuestionsPageArgs> page =
      _i54.PageInfo<LegalScreeningQuestionsPageArgs>(name);
}

class LegalScreeningQuestionsPageArgs {
  const LegalScreeningQuestionsPageArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LegalScreeningQuestionsPageArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i24.LocationDetailForm]
class LocationDetailForm extends _i54.PageRouteInfo<LocationDetailFormArgs> {
  LocationDetailForm({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          LocationDetailForm.name,
          args: LocationDetailFormArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'LocationDetailForm';

  static const _i54.PageInfo<LocationDetailFormArgs> page =
      _i54.PageInfo<LocationDetailFormArgs>(name);
}

class LocationDetailFormArgs {
  const LocationDetailFormArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'LocationDetailFormArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i25.LocationExample]
class LocationExample extends _i54.PageRouteInfo<void> {
  const LocationExample({List<_i54.PageRouteInfo>? children})
      : super(
          LocationExample.name,
          initialChildren: children,
        );

  static const String name = 'LocationExample';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i26.LoginScreen]
class LoginPage extends _i54.PageRouteInfo<void> {
  const LoginPage({List<_i54.PageRouteInfo>? children})
      : super(
          LoginPage.name,
          initialChildren: children,
        );

  static const String name = 'LoginPage';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i27.MainTabView]
class MainTabView extends _i54.PageRouteInfo<void> {
  const MainTabView({List<_i54.PageRouteInfo>? children})
      : super(
          MainTabView.name,
          initialChildren: children,
        );

  static const String name = 'MainTabView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i28.NotificationView]
class NotificationView extends _i54.PageRouteInfo<void> {
  const NotificationView({List<_i54.PageRouteInfo>? children})
      : super(
          NotificationView.name,
          initialChildren: children,
        );

  static const String name = 'NotificationView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i29.OnBoarding1]
class Onboarding1 extends _i54.PageRouteInfo<Onboarding1Args> {
  Onboarding1({
    _i55.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          Onboarding1.name,
          args: Onboarding1Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding1';

  static const _i54.PageInfo<Onboarding1Args> page =
      _i54.PageInfo<Onboarding1Args>(name);
}

class Onboarding1Args {
  const Onboarding1Args({this.key});

  final _i55.Key? key;

  @override
  String toString() {
    return 'Onboarding1Args{key: $key}';
  }
}

/// generated route for
/// [_i30.OnBoarding2]
class Onboarding2 extends _i54.PageRouteInfo<Onboarding2Args> {
  Onboarding2({
    _i55.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          Onboarding2.name,
          args: Onboarding2Args(key: key),
          initialChildren: children,
        );

  static const String name = 'Onboarding2';

  static const _i54.PageInfo<Onboarding2Args> page =
      _i54.PageInfo<Onboarding2Args>(name);
}

class Onboarding2Args {
  const Onboarding2Args({this.key});

  final _i55.Key? key;

  @override
  String toString() {
    return 'Onboarding2Args{key: $key}';
  }
}

/// generated route for
/// [_i31.OnBoarding3]
class OnBoarding3 extends _i54.PageRouteInfo<OnBoarding3Args> {
  OnBoarding3({
    _i55.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          OnBoarding3.name,
          args: OnBoarding3Args(key: key),
          initialChildren: children,
        );

  static const String name = 'OnBoarding3';

  static const _i54.PageInfo<OnBoarding3Args> page =
      _i54.PageInfo<OnBoarding3Args>(name);
}

class OnBoarding3Args {
  const OnBoarding3Args({this.key});

  final _i55.Key? key;

  @override
  String toString() {
    return 'OnBoarding3Args{key: $key}';
  }
}

/// generated route for
/// [_i32.PayableDetail]
class PayableDetail extends _i54.PageRouteInfo<PayableDetailArgs> {
  PayableDetail({
    _i55.Key? key,
    required _i58.HealthcarePostDTO post,
    bool isUpdate = false,
    _i59.PostShiftDTO? updatedPost,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          PayableDetail.name,
          args: PayableDetailArgs(
            key: key,
            post: post,
            isUpdate: isUpdate,
            updatedPost: updatedPost,
          ),
          initialChildren: children,
        );

  static const String name = 'PayableDetail';

  static const _i54.PageInfo<PayableDetailArgs> page =
      _i54.PageInfo<PayableDetailArgs>(name);
}

class PayableDetailArgs {
  const PayableDetailArgs({
    this.key,
    required this.post,
    this.isUpdate = false,
    this.updatedPost,
  });

  final _i55.Key? key;

  final _i58.HealthcarePostDTO post;

  final bool isUpdate;

  final _i59.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'PayableDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i33.PersonalReferenceDetail]
class PersonalReferenceDetail extends _i54.PageRouteInfo<void> {
  const PersonalReferenceDetail({List<_i54.PageRouteInfo>? children})
      : super(
          PersonalReferenceDetail.name,
          initialChildren: children,
        );

  static const String name = 'PersonalReferenceDetail';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i34.PostShiftRecurring]
class PostShiftRecurring extends _i54.PageRouteInfo<PostShiftRecurringArgs> {
  PostShiftRecurring({
    _i55.Key? key,
    required int shiftType,
    required _i58.HealthcarePostDTO? updateShift,
    required _i59.PostShiftDTO post,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          PostShiftRecurring.name,
          args: PostShiftRecurringArgs(
            key: key,
            shiftType: shiftType,
            updateShift: updateShift,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'PostShiftRecurring';

  static const _i54.PageInfo<PostShiftRecurringArgs> page =
      _i54.PageInfo<PostShiftRecurringArgs>(name);
}

class PostShiftRecurringArgs {
  const PostShiftRecurringArgs({
    this.key,
    required this.shiftType,
    required this.updateShift,
    required this.post,
  });

  final _i55.Key? key;

  final int shiftType;

  final _i58.HealthcarePostDTO? updateShift;

  final _i59.PostShiftDTO post;

  @override
  String toString() {
    return 'PostShiftRecurringArgs{key: $key, shiftType: $shiftType, updateShift: $updateShift, post: $post}';
  }
}

/// generated route for
/// [_i35.PrivacyPolicyScreen]
class PrivacyPolicyScreen extends _i54.PageRouteInfo<PrivacyPolicyScreenArgs> {
  PrivacyPolicyScreen({
    _i55.Key? key,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          PrivacyPolicyScreen.name,
          args: PrivacyPolicyScreenArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyScreen';

  static const _i54.PageInfo<PrivacyPolicyScreenArgs> page =
      _i54.PageInfo<PrivacyPolicyScreenArgs>(name);
}

class PrivacyPolicyScreenArgs {
  const PrivacyPolicyScreenArgs({this.key});

  final _i55.Key? key;

  @override
  String toString() {
    return 'PrivacyPolicyScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i36.ProfessionalReferenceDetail]
class ProfessionalReferenceDetail extends _i54.PageRouteInfo<void> {
  const ProfessionalReferenceDetail({List<_i54.PageRouteInfo>? children})
      : super(
          ProfessionalReferenceDetail.name,
          initialChildren: children,
        );

  static const String name = 'ProfessionalReferenceDetail';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i37.ProfileView]
class ProfileView extends _i54.PageRouteInfo<void> {
  const ProfileView({List<_i54.PageRouteInfo>? children})
      : super(
          ProfileView.name,
          initialChildren: children,
        );

  static const String name = 'ProfileView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i38.QuizResultScreen]
class QuizResultScreen extends _i54.PageRouteInfo<void> {
  const QuizResultScreen({List<_i54.PageRouteInfo>? children})
      : super(
          QuizResultScreen.name,
          initialChildren: children,
        );

  static const String name = 'QuizResultScreen';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i39.ReferenceListScreen]
class ReferenceListScreen extends _i54.PageRouteInfo<ReferenceListScreenArgs> {
  ReferenceListScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ReferenceListScreen.name,
          args: ReferenceListScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'ReferenceListScreen';

  static const _i54.PageInfo<ReferenceListScreenArgs> page =
      _i54.PageInfo<ReferenceListScreenArgs>(name);
}

class ReferenceListScreenArgs {
  const ReferenceListScreenArgs({
    this.key,
    this.isFromSplash = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  @override
  String toString() {
    return 'ReferenceListScreenArgs{key: $key, isFromSplash: $isFromSplash}';
  }
}

/// generated route for
/// [_i40.RegisterProfileScreen]
class RegisterProfilePage extends _i54.PageRouteInfo<RegisterProfilePageArgs> {
  RegisterProfilePage({
    _i55.Key? key,
    required String firstName,
    required String lastName,
    required int checkTermsPrivacy,
    List<_i54.PageRouteInfo>? children,
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

  static const _i54.PageInfo<RegisterProfilePageArgs> page =
      _i54.PageInfo<RegisterProfilePageArgs>(name);
}

class RegisterProfilePageArgs {
  const RegisterProfilePageArgs({
    this.key,
    required this.firstName,
    required this.lastName,
    required this.checkTermsPrivacy,
  });

  final _i55.Key? key;

  final String firstName;

  final String lastName;

  final int checkTermsPrivacy;

  @override
  String toString() {
    return 'RegisterProfilePageArgs{key: $key, firstName: $firstName, lastName: $lastName, checkTermsPrivacy: $checkTermsPrivacy}';
  }
}

/// generated route for
/// [_i41.RegisterScreen]
class RegisterPage extends _i54.PageRouteInfo<void> {
  const RegisterPage({List<_i54.PageRouteInfo>? children})
      : super(
          RegisterPage.name,
          initialChildren: children,
        );

  static const String name = 'RegisterPage';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i42.ReviewPostShiftDetail]
class ReviewPostShiftDetail
    extends _i54.PageRouteInfo<ReviewPostShiftDetailArgs> {
  ReviewPostShiftDetail({
    _i55.Key? key,
    required _i58.HealthcarePostDTO post,
    bool isUpdate = false,
    _i59.PostShiftDTO? updatedPost,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ReviewPostShiftDetail.name,
          args: ReviewPostShiftDetailArgs(
            key: key,
            post: post,
            isUpdate: isUpdate,
            updatedPost: updatedPost,
          ),
          initialChildren: children,
        );

  static const String name = 'ReviewPostShiftDetail';

  static const _i54.PageInfo<ReviewPostShiftDetailArgs> page =
      _i54.PageInfo<ReviewPostShiftDetailArgs>(name);
}

class ReviewPostShiftDetailArgs {
  const ReviewPostShiftDetailArgs({
    this.key,
    required this.post,
    this.isUpdate = false,
    this.updatedPost,
  });

  final _i55.Key? key;

  final _i58.HealthcarePostDTO post;

  final bool isUpdate;

  final _i59.PostShiftDTO? updatedPost;

  @override
  String toString() {
    return 'ReviewPostShiftDetailArgs{key: $key, post: $post, isUpdate: $isUpdate, updatedPost: $updatedPost}';
  }
}

/// generated route for
/// [_i43.ShowGoogleMap]
class ShowGoogleMap extends _i54.PageRouteInfo<ShowGoogleMapArgs> {
  ShowGoogleMap({
    _i55.Key? key,
    required double latitude,
    required double longitude,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ShowGoogleMap.name,
          args: ShowGoogleMapArgs(
            key: key,
            latitude: latitude,
            longitude: longitude,
          ),
          initialChildren: children,
        );

  static const String name = 'ShowGoogleMap';

  static const _i54.PageInfo<ShowGoogleMapArgs> page =
      _i54.PageInfo<ShowGoogleMapArgs>(name);
}

class ShowGoogleMapArgs {
  const ShowGoogleMapArgs({
    this.key,
    required this.latitude,
    required this.longitude,
  });

  final _i55.Key? key;

  final double latitude;

  final double longitude;

  @override
  String toString() {
    return 'ShowGoogleMapArgs{key: $key, latitude: $latitude, longitude: $longitude}';
  }
}

/// generated route for
/// [_i44.SplashPage]
class SplashPage extends _i54.PageRouteInfo<void> {
  const SplashPage({List<_i54.PageRouteInfo>? children})
      : super(
          SplashPage.name,
          initialChildren: children,
        );

  static const String name = 'SplashPage';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i45.TeamDetailView]
class TeamDetailView extends _i54.PageRouteInfo<TeamDetailViewArgs> {
  TeamDetailView({
    _i55.Key? key,
    required _i60.GetTeamsListDTO getTeamsListDTO,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          TeamDetailView.name,
          args: TeamDetailViewArgs(
            key: key,
            getTeamsListDTO: getTeamsListDTO,
          ),
          initialChildren: children,
        );

  static const String name = 'TeamDetailView';

  static const _i54.PageInfo<TeamDetailViewArgs> page =
      _i54.PageInfo<TeamDetailViewArgs>(name);
}

class TeamDetailViewArgs {
  const TeamDetailViewArgs({
    this.key,
    required this.getTeamsListDTO,
  });

  final _i55.Key? key;

  final _i60.GetTeamsListDTO getTeamsListDTO;

  @override
  String toString() {
    return 'TeamDetailViewArgs{key: $key, getTeamsListDTO: $getTeamsListDTO}';
  }
}

/// generated route for
/// [_i46.TeamsView]
class TeamsView extends _i54.PageRouteInfo<void> {
  const TeamsView({List<_i54.PageRouteInfo>? children})
      : super(
          TeamsView.name,
          initialChildren: children,
        );

  static const String name = 'TeamsView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i47.TermsAndConditionsScreen]
class TermsAndConditionsScreen
    extends _i54.PageRouteInfo<TermsAndConditionsScreenArgs> {
  TermsAndConditionsScreen({
    _i55.Key? key,
    bool isFromSplash = false,
    bool isFromRegister = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          TermsAndConditionsScreen.name,
          args: TermsAndConditionsScreenArgs(
            key: key,
            isFromSplash: isFromSplash,
            isFromRegister: isFromRegister,
          ),
          initialChildren: children,
        );

  static const String name = 'TermsAndConditionsScreen';

  static const _i54.PageInfo<TermsAndConditionsScreenArgs> page =
      _i54.PageInfo<TermsAndConditionsScreenArgs>(name);
}

class TermsAndConditionsScreenArgs {
  const TermsAndConditionsScreenArgs({
    this.key,
    this.isFromSplash = false,
    this.isFromRegister = false,
  });

  final _i55.Key? key;

  final bool isFromSplash;

  final bool isFromRegister;

  @override
  String toString() {
    return 'TermsAndConditionsScreenArgs{key: $key, isFromSplash: $isFromSplash, isFromRegister: $isFromRegister}';
  }
}

/// generated route for
/// [_i48.TotalPraposalView]
class TotalPraposalView extends _i54.PageRouteInfo<void> {
  const TotalPraposalView({List<_i54.PageRouteInfo>? children})
      : super(
          TotalPraposalView.name,
          initialChildren: children,
        );

  static const String name = 'TotalPraposalView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i49.ViewApplicantProfile]
class ViewApplicantProfile extends _i54.PageRouteInfo<void> {
  const ViewApplicantProfile({List<_i54.PageRouteInfo>? children})
      : super(
          ViewApplicantProfile.name,
          initialChildren: children,
        );

  static const String name = 'ViewApplicantProfile';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i50.ViewDates]
class ViewDates extends _i54.PageRouteInfo<ViewDatesArgs> {
  ViewDates({
    _i55.Key? key,
    required _i62.ShiftDetailDTO shiftDetail,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ViewDates.name,
          args: ViewDatesArgs(
            key: key,
            shiftDetail: shiftDetail,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewDates';

  static const _i54.PageInfo<ViewDatesArgs> page =
      _i54.PageInfo<ViewDatesArgs>(name);
}

class ViewDatesArgs {
  const ViewDatesArgs({
    this.key,
    required this.shiftDetail,
  });

  final _i55.Key? key;

  final _i62.ShiftDetailDTO shiftDetail;

  @override
  String toString() {
    return 'ViewDatesArgs{key: $key, shiftDetail: $shiftDetail}';
  }
}

/// generated route for
/// [_i51.ViewHomeShiftDetails]
class ViewHomeShiftDetails
    extends _i54.PageRouteInfo<ViewHomeShiftDetailsArgs> {
  ViewHomeShiftDetails({
    _i55.Key? key,
    required int postId,
    bool isTotalApplicants = false,
    List<_i54.PageRouteInfo>? children,
  }) : super(
          ViewHomeShiftDetails.name,
          args: ViewHomeShiftDetailsArgs(
            key: key,
            postId: postId,
            isTotalApplicants: isTotalApplicants,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewHomeShiftDetails';

  static const _i54.PageInfo<ViewHomeShiftDetailsArgs> page =
      _i54.PageInfo<ViewHomeShiftDetailsArgs>(name);
}

class ViewHomeShiftDetailsArgs {
  const ViewHomeShiftDetailsArgs({
    this.key,
    required this.postId,
    this.isTotalApplicants = false,
  });

  final _i55.Key? key;

  final int postId;

  final bool isTotalApplicants;

  @override
  String toString() {
    return 'ViewHomeShiftDetailsArgs{key: $key, postId: $postId, isTotalApplicants: $isTotalApplicants}';
  }
}

/// generated route for
/// [_i52.ViewPersonPraposalView]
class ViewPersonPraposalView extends _i54.PageRouteInfo<void> {
  const ViewPersonPraposalView({List<_i54.PageRouteInfo>? children})
      : super(
          ViewPersonPraposalView.name,
          initialChildren: children,
        );

  static const String name = 'ViewPersonPraposalView';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}

/// generated route for
/// [_i53.ViewSingleApplicants]
class ViewSingleApplicants extends _i54.PageRouteInfo<void> {
  const ViewSingleApplicants({List<_i54.PageRouteInfo>? children})
      : super(
          ViewSingleApplicants.name,
          initialChildren: children,
        );

  static const String name = 'ViewSingleApplicants';

  static const _i54.PageInfo<void> page = _i54.PageInfo<void>(name);
}
