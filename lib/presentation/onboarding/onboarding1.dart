// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/onboarding/onboarding_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:shift/presentation/onboarding/widgets/onboard_tile.dart';

@RoutePage(name: 'onboarding1')
class OnBoarding1 extends StatelessWidget {
  OnBoarding1({super.key});

  List<OnBoardingDTO> userList = CommonList.userList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: Scaffold(
        body: BlocConsumer<OnboardingBloc, OnboardingState>(
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
                  context.router.push(const PageRouteInfo(Onboarding2.name));
                },
              ),
            );
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      PngImageConstants.onboarding1,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(45),
                        vertical: getSize(30),
                      ),
                      child: BaseText(
                        text: StringConstant.onBoarding1Desc,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black.withValues(alpha: 0.9),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: userList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    (index == 0) ? getSize(0) : getSize(20),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<OnboardingBloc>().add(
                                      OnboardingEvent.submitOnboarding1(
                                          userList[index].id ?? 1));
                                },
                                child: OnBoardTile(
                                  title: userList[index].title ?? "",
                                  designation: userList[index].description,
                                  dpImage: userList[index].image ?? "",
                                  bgImage: userList[index].backgroundImage,
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                CommonAppBar(
                  onBackPressed: () {},
                  isShowBackBtn: false,
                  title: StringConstant.letsGetStarted,
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                    fontFamily: "Aclonica",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
