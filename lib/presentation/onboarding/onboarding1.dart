// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/back_ground_image.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:shift/presentation/onboarding/widgets/onboard_tile.dart';
import 'package:shift/presentation/onboarding/widgets/onboarding_model.dart';

@RoutePage(name: 'onboarding1')
class OnBoarding1 extends StatelessWidget {
  OnBoarding1({super.key});

  List<OnBoardingModel> onboardList = [
    OnBoardingModel(
      title: "Healthcare \nProfessional\n",
      description: "Contractor",
      image: PngImageConstants.doctors,
      backgroundImage: SvgImageConstant.personSetting,
    ),
    OnBoardingModel(
      title: "Healthcare \nFacilities\n",
      description: "Employer",
      image: PngImageConstants.patient,
      backgroundImage: SvgImageConstant.nurse,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundImage(
            imageString: PngImageConstants.login_frame,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(52),
                      vertical: getSize(40),
                    ),
                    child: BaseText(
                      text: StringConstant.onBoarding1Desc,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black.withOpacity(0.9),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: onboardList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: (index == 0) ? getSize(0) : getSize(20),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context.router.push(
                                    const PageRouteInfo(Onboarding2.name));
                              },
                              child: OnBoardTile(
                                title: onboardList[index].title,
                                designation: onboardList[index].description,
                                dpImage: onboardList[index].image,
                                bgImage: onboardList[index].backgroundImage,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            width: getSize(375),
            top: getSize(20),
            left: getSize(20),
            child: CommonAppBar(
              onBackPressed: () {},
              // iconColor: AppColors.white,
              isShowBackBtn: false,
              title: StringConstant.selectYourRole,
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
                fontFamily: "Aclonica",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appbarView() {
    return Row(
      children: [
        SvgPicture.asset(
          SvgImageConstant.back,
        ),
        SizedBox(
          width: getSize(73),
        ),
        BaseText(
          text: StringConstant.selectYourRole,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          textColor: AppColors.white,
          fontFamily: "Aclonica",
        ),
      ],
    );
  }
}
