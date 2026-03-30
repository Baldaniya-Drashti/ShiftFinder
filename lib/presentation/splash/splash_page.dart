// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:shift/application/splash/splash_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/internet_connectivity_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

@RoutePage(name: 'splashPage')
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Future<void> preloadImages(
    BuildContext context,
  ) async {
    for (String path in PngImageConstants.allImages) {
      await precacheImage(AssetImage(path), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (_, state) async {
        preloadImages(context);

        await NetworkListener().navigateWhenOnline(() async {
          await Future.delayed(const Duration(seconds: 1));
          await state.map(
            initial: (_) {},
            authenticated: (value) async {
              if (value.isProfileComplete == 1) {
                if (getCurrentRole() == 2) {
                  await context.router.replace(PageRouteInfo(MainTabView.name));
                } else {
                  await context.router
                      .replace(PageRouteInfo(ContractorMainTabView.name));
                }
              } else {
                await context.router.replace(getCurrentPage(
                  value.lastPage,
                  fromSplash: true,
                ));
              }
            },
            unAuthenticated: (value) async {
              await context.router.replace(const PageRouteInfo(LoginPage.name));
            },
            introScreenVisibilty: (IntroScreenVisibilty value) async {
              await context.router
                  .replace(const PageRouteInfo(Onboarding1.name));
            },
          );
        });
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoWithText(),
          ],
        ),
      ),
    );
  }

  Widget logoWithText() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getSize(85),
            width: getSize(105),
            child: Image.asset(
              PngImageConstants.splash_logo,
            ),
          ),
          SizedBox(height: getSize(20)),
          const BaseText(
            text: StringConstant.shiftFinder,
            fontSize: 30,
            fontWeight: FontWeight.w400,
            textColor: AppColors.black,
            fontFamily: "Aclonica",
          ),
          SizedBox(
            height: getSize(10),
          ),
          SizedBox(
            width: getSize(250),
            child: const BaseText(
              text: StringConstant
                  .bridgingHealthServiceFacilitiesAndProfessionals,
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}

PageRouteInfo getCurrentPage(String lastPage, {bool fromSplash = true}) {
  switch (lastPage) {
    case "Login":
      return PageRouteInfo(
        LoginPage.name,
      );
    case "EmployerLocation":
      return PageRouteInfo(
        LocationDetailForm.name,
        args: LocationDetailFormArgs(isFromSplash: fromSplash),
      );
    case "AddCardDetail":
      return PageRouteInfo(
        AddCardDetailPage.name,
        args: AddCardDetailPageArgs(isFromSplash: fromSplash),
      );
    case "ContractorSkill":
      return PageRouteInfo(
        AddContractorSkillsForm.name,
        args: AddContractorSkillsFormArgs(isFromSplash: fromSplash),
      );
    case "Education":
      return PageRouteInfo(
        EducationListScreen.name,
        args: EducationListScreenArgs(isFromSplash: fromSplash),
      );
    case "Experience":
      return PageRouteInfo(
        AddExperienceDetailScreen.name,
        args: AddExperienceDetailScreenArgs(isFromSplash: fromSplash),
      );
    case "SpecialityExperience":
      return PageRouteInfo(
        AddSpecialityExperience.name,
        args: AddSpecialityExperienceArgs(isFromSplash: fromSplash),
      );
    case "Reference":
      return PageRouteInfo(
        ReferenceListScreen.name,
        args: ReferenceListScreenArgs(isFromSplash: fromSplash),
      );
    case "Document":
      return PageRouteInfo(
        DocumentPageScreen.name,
        args: DocumentPageScreenArgs(isFromSplash: fromSplash),
      );
    case "AddressProofScreen":
      return PageRouteInfo(
        AddressProofScreen.name,
        args: AddressProofScreenArgs(isFromSplash: fromSplash),
      );
    case "BackgroundCheckDocument":
      return PageRouteInfo(
        BackgroundDocument.name,
        args: BackgroundDocumentArgs(isFromSplash: fromSplash),
      );
    case "ProofOfLegalStatus":
      return PageRouteInfo(
        ProofOfLegalStatus.name,
        args: ProofOfLegalStatusArgs(isFromSplash: fromSplash),
      );
    case "BankDetail":
      return PageRouteInfo(
        AddBankDetailsScreen.name,
        args: AddBankDetailsScreenArgs(isFromSplash: fromSplash),
      );
    case "LegalScreening":
      return PageRouteInfo(
        LegalScreeningQuestionsPage.name,
        args: LegalScreeningQuestionsPageArgs(isFromSplash: fromSplash),
      );
    case "TermsAndCondition":
      return PageRouteInfo(
        TermsAndConditionsScreen.name,
        args: TermsAndConditionsScreenArgs(isFromSplash: fromSplash),
      );
    case "IntroVideo":
      return PageRouteInfo(
        IntroVideoScreen.name,
        args: GeneralScreenArgs(fromSplash: fromSplash),
      );
    default:
      return PageRouteInfo(LoginPage.name);
  }
}

class GeneralScreenArgs {
  final bool fromSplash;

  GeneralScreenArgs({
    required this.fromSplash,
  });
}
