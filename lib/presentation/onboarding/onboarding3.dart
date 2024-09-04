// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/onboarding/onboarding_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

@RoutePage(name: 'onBoarding3')
class OnBoarding3 extends StatelessWidget {
  OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) {
                context.router
                    .replaceAll([const PageRouteInfo(LoginPage.name)]);
              },
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox(
                  height: getSize(478),
                  width: double.infinity,
                  child: Image.asset(
                    PngImageConstants.onboarding3,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                descriptionView(
                  btnOnPressed: () {
                    print("BTN CLICKED!!!!!!!!!");
                    context
                        .read<OnboardingBloc>()
                        .add(OnboardingEvent.submitOnboarding3());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget descriptionView({required VoidCallback btnOnPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(30),
        vertical: getSize(100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          badges.Badge(
            position: badges.BadgePosition.bottomEnd(
              bottom: getSize(-22),
              end: (getCurrentRole() == 1) ? getSize(-35) : getSize(40),
            ),
            badgeContent: SvgPicture.asset(
              SvgImageConstant.twoLines,
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: AppColors.transparent,
            ),
            child: BaseText(
              text: (getCurrentRole() == 1)
                  ? StringConstant.findYourPerfectHealthcareShift
                  : StringConstant.letsFindTheRightHealthServiceProfessional,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: getSize(15),
          ),
          BaseText(
            text: (getCurrentRole() == 1)
                ? StringConstant.onBoarding3Desc_contractor
                : StringConstant.onBoarding3Desc_employer,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black.withOpacity(0.7),
          ),
          SizedBox(
            height: getSize(35),
          ),
          MaterialButton(
            onPressed: btnOnPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: BorderSide(
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
            elevation: 0,
            minWidth: getSize(143),
            height: getSize(46),
            padding: EdgeInsets.only(left: getSize(20), right: getSize(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: StringConstant.letsStart,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  width: getSize(10),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  maxRadius: getSize(20),
                  child: SvgPicture.asset(
                    SvgImageConstant.forward,
                    color: AppColors.white,
                    height: getSize(24),
                    width: getSize(24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
