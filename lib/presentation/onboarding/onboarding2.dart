// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/auth/onboarding/onboarding_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';
import 'package:shift/presentation/onboarding/widgets/onboard_tile.dart';

@RoutePage(name: 'onboarding2')
class OnBoarding2 extends StatelessWidget {
  OnBoarding2({super.key});

  List<OnBoardingDTO> industryList = CommonList.industryList;

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
                context.router.push(const PageRouteInfo(OnBoarding3.name));
              },
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                print("Back is Tapped");
                context.router.maybePop();
              },
              title: StringConstant.chooseIndustry,
            ),
            body: Padding(
              padding: EdgeInsets.only(left: getSize(15), right: getSize(15)),
              child: Column(
                children: [
                  Image.asset((getCurrentRole() == 1)
                      ? PngImageConstants.onboarding2_contractor
                      : PngImageConstants.onboarding2_employer),
                  SizedBox(
                    height: getSize(20),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: industryList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: getSize(20),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<OnboardingBloc>()
                                    .add(OnboardingEvent.submitOnboarding2(
                                      industryList[index].id ?? 1,
                                    ));
                              },
                              child: OnBoardTile(
                                isTile2: true,
                                title: industryList[index].title ?? "",
                                designation: industryList[index].description,
                                dpImage: industryList[index].image ?? "",
                                bgImage: industryList[index].backgroundImage,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
