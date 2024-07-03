// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'onBoarding3')
class OnBoarding3 extends StatelessWidget {
  OnBoarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          SizedBox(
            height: getSize(519),
            // color: Colors.amber,
            child: Image.asset(
              PngImageConstants.onboarding3_background,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: getSize(562),
            child: Image.asset(
              PngImageConstants.onboarding3,
              fit: BoxFit.fitHeight,
            ),
          ),
          descriptionView(
            btnOnPressed: () {
              print("BTN CLICKED!!!!!!!!!");
              context.router.replaceAll([
                const PageRouteInfo(LoginPage.name),
              ]);
            },
          ),
        ],
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
          BaseText(
            text: StringConstant.findYourPerfectHealthcareShift,
            fontSize: 22,
            fontWeight: FontWeight.w400,
            fontFamily: "Aclonica",
          ),
          SizedBox(
            height: getSize(22),
          ),
          BaseText(
            text: StringConstant.onBoarding3Desc,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: getSize(50),
          ),
          MaterialButton(
            onPressed: btnOnPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
            elevation: 0,
            minWidth: getSize(143),
            height: getSize(55),
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
