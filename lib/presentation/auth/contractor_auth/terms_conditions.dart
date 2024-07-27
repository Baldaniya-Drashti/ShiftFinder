// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'termsAndConditionsScreen')
class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.termsAndConditions,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                documentImage(),
                SizedBox(
                  height: getSize(20),
                ),
                summaryAndTermsDesc(),
                SizedBox(
                  height: getSize(30),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CommonButton(
                    onPressed: () {
                      context.router
                          .push(const PageRouteInfo(IntroVideoScreen.name));
                    },
                    buttonText: StringConstant.txtContinue,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget documentImage() {
    return Container(
      height: getSize(103),
      padding:
          EdgeInsets.symmetric(vertical: getSize(20), horizontal: getSize(32)),
      decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgImageConstant.clockWithVerticalLine,
            height: getSize(63),
            width: getSize(57.95),
          ),
          SizedBox(
            width: getSize(15),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text:
                    "Hello,✋ ${getCurrentUser().firstName} ${getCurrentUser().lastName}",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                lineHeight: 1.5,
              ),
              SizedBox(
                width: getSize(200),
                child: BaseText(
                  text: StringConstant.termsScreenImageDesc,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget summaryAndTermsDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(StringConstant.summary),
        descriptionText(StringConstant.summaryDesc),
        SizedBox(
          height: getSize(20),
        ),
        titleText(StringConstant.terms),
        descriptionText(StringConstant.termsDesc1),
        descriptionText(StringConstant.termsDesc2),
        descriptionText(StringConstant.termsDesc3),
      ],
    );
  }

  Widget descriptionText(String text) {
    return BaseText(
      text: text,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      maxLines: 10,
    );
  }

  Widget titleText(String text) {
    return BaseText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      textColor: AppColors.primaryColor,
    );
  }
}
