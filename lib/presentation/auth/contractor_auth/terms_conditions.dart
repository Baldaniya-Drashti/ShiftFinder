// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/auth/contractor_auth/terms_and_condition_bloc/terms_and_condition_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'termsAndConditionsScreen')
class TermsAndConditionsScreen extends StatelessWidget {
  bool isFromSplash = false;
  TermsAndConditionsScreen({super.key, this.isFromSplash = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TermsAndConditionBloc>(),
      child: BlocConsumer<TermsAndConditionBloc, TermsAndConditionState>(
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
                context.router.push(const PageRouteInfo(IntroVideoScreen.name));
              },
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
              appBar: CommonAppBar(
                isShowBackBtn: !isFromSplash,
                onBackPressed: () {
                  context.router.maybePop();
                },
                title: StringConstant.termsAndConditions,
              ),
              body: (state.isSubmitting)
                  ? CenterLoadingIndicator()
                  : SingleChildScrollView(
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
                                  context.read<TermsAndConditionBloc>().add(
                                      TermsAndConditionEvent.submitTerms());
                                },
                                buttonText: StringConstant.txtContinue,
                              ),
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
            mainAxisSize: MainAxisSize.min,
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
                width: getHorizontalSize(200),
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
