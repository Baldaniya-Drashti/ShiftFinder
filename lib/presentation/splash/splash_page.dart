import 'package:auto_route/auto_route.dart';
import 'package:shift/application/splash/splash_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

@RoutePage(name: 'splashPage')
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        state.map(
            initial: (_) {},
            authenticated: (value) async {
              // await Future.delayed(
              //   const Duration(seconds: 1),
              //   () => context.router
              //       .replace(const PageRouteInfo(MainTabView.name)),
              // );
            },
            unAuthenticated: (value) async {
              await Future.delayed(
                const Duration(seconds: 1),
                () =>
                    // context.router.replace(const PageRouteInfo(Onboarding1.name)),
                    context.router
                        .push(const PageRouteInfo(DocumentPageScreen.name)),
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
          SizedBox(
            height: getSize(20),
          ),
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
