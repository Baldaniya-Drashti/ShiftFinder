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
                () => context.router
                    .replace(const PageRouteInfo(Onboarding1.name)),
              );
            });
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              PngImageConstants.splash_bg1,
            ),
            logoWithText(),
            Image.asset(
              PngImageConstants.splash_bg2,
            ),
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
          Image.asset(
            PngImageConstants.splash_logo,
          ),
          SizedBox(
            height: getSize(20),
          ),
          SizedBox(
            width: getSize(200),
            child: const BaseText(
              text: StringConstant.bridgingEmployersAndHealthcareSpecialists,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
