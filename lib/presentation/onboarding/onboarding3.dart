// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
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
            height: getSize(478),
            width: getSize(453),
            child: Image.asset(
              PngImageConstants.onboarding3,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: getSize(150),
            left: getSize((getCurrentUser() == 0) ? 200 : 250),
            child: Align(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset(
                SvgImageConstant.twoLines,
              ),
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
            text: (getCurrentUser() == 0)
                ? StringConstant.findYourPerfectHealthcareShift
                : StringConstant.letsFindTheRightHealthServiceProfessional,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: "Aclonica",
            maxLines: 2,
          ),
          SizedBox(
            height: getSize(15),
          ),
          BaseText(
            text: (getCurrentUser() == 0)
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
