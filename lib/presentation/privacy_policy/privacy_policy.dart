// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'privacyPolicyScreen')
class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TermsAndConditionBloc>(),
      child: BlocConsumer<TermsAndConditionBloc, TermsAndConditionState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: CommonAppBar(
                isShowBackBtn: true,
                onBackPressed: () {
                  context.router.maybePop();
                },
                title: StringConstant.privacyPolicy,
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
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget documentImage() {
    return Container(
      // height: getSize(103),
      padding:
          EdgeInsets.symmetric(vertical: getSize(20), horizontal: getSize(32)),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
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
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text:
                      "Hello,✋ ${getCurrentUser().firstName ?? ""} ${getCurrentUser().lastName ?? ""}",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.5,
                ),
                SizedBox(
                  width: getHorizontalSize(200),
                  child: BaseText(
                    text: StringConstant.privacyPolicyImageDesc,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget summaryAndTermsDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText(StringConstant.privacyPolicy),
        descriptionText(StringConstant.privacyPolicyDesc),
      ],
    );
  }

  Widget descriptionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(12),
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto Flex',
      ),
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
