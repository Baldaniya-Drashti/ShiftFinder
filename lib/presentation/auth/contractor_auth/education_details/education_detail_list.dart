// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/auth/contractor_auth/education_detail_bloc/education_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/education_dto/education_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/no_data_ui.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'educationListScreen')
class EducationListScreen extends StatelessWidget {
  bool isFromSplash = false;

  EducationListScreen({super.key, this.isFromSplash = false});
  // bool isNext = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EducationDetailBloc>()
        ..add(EducationDetailEvent.getEducationList()),
      child: BlocConsumer<EducationDetailBloc, EducationDetailState>(
        listener: (context, state) {
          state.listFailureOrSuccessOption.fold(
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
              (r) {},
            ),
          );
          state.skipFailureOrSuccessOption.fold(
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
                context.router
                    .push(PageRouteInfo(AddExperienceDetailScreen.name));
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
              title: StringConstant.education,
              showSkipBtn: (state.educationList.isEmpty) ? true : false,
              onSkipped: (state.educationList.isEmpty)
                  ? () {
                      context
                          .read<EducationDetailBloc>()
                          .add(EducationDetailEvent.skipEducation());
                      // context.router.replace(
                      //     PageRouteInfo(AddExperienceDetailScreen.name));
                    }
                  : null,
            ),
            body: (state.isSubmitting)
                ? CenterLoadingIndicator()
                : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (state.educationList.isNotEmpty)
                              ? educationListUI(context, state)
                              : Expanded(
                                  child: NoDataText(
                                    title: StringConstant.noEducationAdded,
                                    description: StringConstant.noEducationDesc,
                                    image: SvgImageConstant.graduationCap,
                                  ),
                                ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: getSize(20),
                            ),
                            child: CommonButton(
                              onPressed: () {
                                if (state.educationList.isNotEmpty) {
                                  context.router.push(PageRouteInfo(
                                      AddExperienceDetailScreen.name));
                                } else {
                                  context.router
                                      .push(PageRouteInfo(
                                          AddEducationDetailScreen.name))
                                      .then((value) {
                                    print("Value when back ---> ${value}");
                                    if (value != null && value == true) {
                                      context.read<EducationDetailBloc>().add(
                                          EducationDetailEvent
                                              .getEducationList());

                                      /// REFRESH THE API AFTER ADD NEW EDUCATION DATA
                                    }
                                  });
                                }
                              },
                              buttonText: (state.educationList.isNotEmpty)
                                  ? StringConstant.txtContinue
                                  : StringConstant.addYourEducation,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget educationListUI(BuildContext context, EducationDetailState state) {
    return SizedBox(
      height: getSize(660),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              itemCount: state.educationList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: getSize(10)),
                  child: ListTile(
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
                    title: boxTitleUI(state.educationList[index]),
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
                            context.read<EducationDetailBloc>().add(
                                EducationDetailEvent.deleteEducation(
                                    state.educationList[index].id ?? -1));
                          },
                        );
                      },
                      child: SvgPicture.asset(SvgImageConstant.bin),
                    ),
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
                    print("Value when back ---> ${value}");

                    if (value != null && value == true) {
                      context
                          .read<EducationDetailBloc>()
                          .add(EducationDetailEvent.getEducationList());

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
        ),
      ),
    );
  }

  Widget boxTitleUI(EducationDTO education) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: education.program_completed ?? "",
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
                text: 'Completed in - ',
              ),
              TextSpan(
                text: education.year_of_completion ?? "",
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
          text: education.graduating_institution ?? "",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          textColor: AppColors.black.withOpacity(0.8),
        ),
      ],
    );
  }
}
