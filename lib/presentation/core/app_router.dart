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
        AutoRoute(page: HealthCarePostForm.page),
        AutoRoute(page: AddContractorSkillsForm.page),
        AutoRoute(
          page: MainTabView.page,
          children: [
            AutoRoute(page: HomeView.page),
          ],
        ),
      ];
}
