// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'educationListScreen')
class EducationListScreen extends StatelessWidget {
  EducationListScreen({super.key});
  bool isNext = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EducationDetailBloc(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.back();
          },
          title: StringConstant.education,
          showSkipBtn: !isNext,
          onSkipped: isNext ? () {} : null,
        ),
        body: BlocConsumer<EducationDetailBloc, EducationDetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (isNext)
                        ? educationListUI(context)
                        : Expanded(
                            child: NoDataText(
                              title: StringConstant.noEducationAdded,
                              description: StringConstant.noEducationDesc,
                              image: SvgImageConstant.graduationCap,
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: getSize(40),
                      ),
                      child: CommonButton(
                        onPressed: () {
                          if (isNext) {
                            context.router.push(
                                PageRouteInfo(AddExperienceDetailScreen.name));
                          } else {
                            context.router
                                .push(PageRouteInfo(
                                    AddEducationDetailScreen.name))
                                .then((value) {
                              if (value != null && value == true) {
                                isNext = true;

                                /// REFRESH THE API AFTER ADD NEW EDUCATION DATA
                              }
                            });
                          }
                        },
                        buttonText: isNext
                            ? StringConstant.txtContinue
                            : StringConstant.addYourEducation,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget educationListUI(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: AppColors.grey.withOpacity(0.4),
              minTileHeight: getSize(103),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              leading: SvgPicture.asset(
                SvgImageConstant.capWithVerticalLine,
                width: getSize(59.56),
                height: getSize(63),
                fit: BoxFit.fitHeight,
              ),
              title: boxTitleUI(),
              trailing: GestureDetector(
                onTap: () {
                  AppDialog.showDelete(
                    context,
                    title: StringConstant.delete,
                    infoMessage: StringConstant.deleteEducationDesc,
                    onCancelClick: () {
                      context.router.maybePop();
                    },
                    onDeleteClick: () {
                      context.router.maybePop();
                    },
                  );
                },
                child: SvgPicture.asset(SvgImageConstant.bin),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: getSize(20)),
          child: CommonButton(
            onPressed: () {
              context.router
                  .push(PageRouteInfo(AddEducationDetailScreen.name))
                  .then((value) {
                if (value != null && value == true) {
                  /// REFRESH THE API AFTER ADD NEW EDUCATION DATA
                }
              });
            },
            buttonText: "+ ${StringConstant.addMore}",
            width: 105,
            borderRadius: 10,
            buttonFontSize: 12,
            buttonFontWeight: FontWeight.w600,
            height: 35,
            backgroundColor: AppColors.primaryColor.withOpacity(0.15),
            buttonTextColor: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget boxTitleUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: "Program Completed",
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        SizedBox(height: getSize(2)),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: AppColors.black.withOpacity(0.8),
              fontSize: getFontSize(8),
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: 'Completed in',
              ),
              TextSpan(
                text: " - 2010",
                style: TextStyle(
                  fontSize: getFontSize(12),
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: getSize(3)),
        BaseText(
          text: "Veritex Community Inst.of USA",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          textColor: AppColors.black.withOpacity(0.8),
        ),
      ],
    );
  }
}
