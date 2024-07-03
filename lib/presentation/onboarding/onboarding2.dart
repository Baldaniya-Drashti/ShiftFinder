// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:shift/presentation/onboarding/widgets/onboard_tile.dart';
import 'package:shift/presentation/onboarding/widgets/onboarding_model.dart';

@RoutePage(name: 'onboarding2')
class OnBoarding2 extends StatelessWidget {
  OnBoarding2({super.key});
  List<OnBoardingModel> onboardList = [
    OnBoardingModel(
      title: "Healthcare",
      description: "",
      image: SvgImageConstant.heart,
      backgroundImage: "",
    ),
    OnBoardingModel(
      title: "Pharmacy",
      description: "",
      image: SvgImageConstant.medicine,
      backgroundImage: "",
    ),
    OnBoardingModel(
      title: "Dental",
      description: "",
      image: SvgImageConstant.teeth,
      backgroundImage: "",
    ),
    OnBoardingModel(
      title: "Hospitality",
      description: "",
      image: SvgImageConstant.nurseGreen,
      backgroundImage: "",
    ),
    OnBoardingModel(
      title: "Ophthalmology",
      description: "",
      image: SvgImageConstant.eye,
      backgroundImage: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          print("Back is Tapped");
          context.router.back();
        },
        title: StringConstant.chooseIndustry,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: getSize(15), right: getSize(15)),
        child: Column(
          children: [
            SizedBox(
              height: getSize(10),
            ),
            Image.asset(PngImageConstants.login_frame),
            SizedBox(
              height: getSize(20),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: onboardList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: getSize(20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.router
                              .push(const PageRouteInfo(OnBoarding3.name));
                        },
                        child: OnBoardTile(
                          isTile2: true,
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
    );
  }
}
