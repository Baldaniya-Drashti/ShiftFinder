// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:shift/presentation/core/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashPage.page, initial: true),
        AutoRoute(page: Onboarding1.page),
        AutoRoute(page: Onboarding2.page),
        AutoRoute(page: OnBoarding3.page),
        AutoRoute(page: LoginPage.page),
        AutoRoute(page: RegisterPage.page),
        AutoRoute(page: RegisterProfilePage.page),
        AutoRoute(page: LocationDetailForm.page),
        AutoRoute(page: AddContractorSkillsForm.page),
        AutoRoute(page: EducationListScreen.page),
        AutoRoute(page: AddEducationDetailScreen.page),
        AutoRoute(page: AddExperienceDetailScreen.page),
        AutoRoute(page: ReferenceListScreen.page),
        AutoRoute(page: AddReferenceDetailScreen.page),
        AutoRoute(page: DocumentPageScreen.page),
        AutoRoute(page: LegalScreeningQuestionsPage.page),
        AutoRoute(page: TermsAndConditionsScreen.page),
        AutoRoute(page: IntroVideoScreen.page),
        AutoRoute(page: IntroQuizScreen.page),
        AutoRoute(page: AddCardDetailPage.page),
        AutoRoute(page: LocationExample.page),
        AutoRoute(page: AddBankDetailsScreen.page),
        AutoRoute(page: ViewHomeShiftDetails.page),
        AutoRoute(page: ViewDates.page),
        AutoRoute(page: HealthCarePostForm.page),
        AutoRoute(page: HealthcarePostShift.page),
        AutoRoute(page: ViewSingleApplicants.page),
        AutoRoute(page: AddCardView.page),
        AutoRoute(page: ViewApplicantProfile.page),
        AutoRoute(page: ProfessionalReferenceDetail.page),
        AutoRoute(page: PersonalReferenceDetail.page),
        AutoRoute(page: CommonDocumentView.page),
        AutoRoute(page: TotalPraposalView.page),
        AutoRoute(page: ViewPersonPraposalView.page),
        AutoRoute(page: CounterPurposeView.page),
        AutoRoute(page: AwaitingConfirmationView.page),
        AutoRoute(page: TeamsView.page),
        AutoRoute(page: AddNewTeamView.page),
        AutoRoute(page: TeamDetailView.page),
        AutoRoute(page: AddNewMemberView.page),
        AutoRoute(page: PostShiftRecurring.page),
        AutoRoute(page: ReviewPostShiftDetail.page),
        AutoRoute(page: PayableDetail.page),
        AutoRoute(page: AddMultiDateTime.page),
        AutoRoute(
          page: MainTabView.page,
          children: [
            AutoRoute(page: HomeView.page),
          ],
        ),
      ];
}
