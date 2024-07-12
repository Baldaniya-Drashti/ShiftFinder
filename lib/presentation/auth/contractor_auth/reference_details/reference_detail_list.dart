// ignore_for_file: avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'referenceListScreen')
class ReferenceListScreen extends StatelessWidget {
  const ReferenceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: StringConstant.reference,
        showSkipBtn: true,
        onSkipped: () {},
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              referenceListUI(context),
              // Expanded(
              //   child: NoDataText(
              //     title: StringConstant.noReferenceAdded,
              //     description: StringConstant.noReferenceDesc,
              //     image: SvgImageConstant.referencePerson,
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: getSize(40),
                ),
                child: CommonButton(
                  onPressed: () {
                    context.router
                        .push(
                            const PageRouteInfo(AddReferenceDetailScreen.name))
                        .then((value) {
                      if (value != null && value == true) {
                        print("Please refresh the API");

                        /// REFRESH THE API AFTER ADD NEW EDUCATION DATA
                      }
                    });
                  },
                  buttonText: StringConstant.addYourReference,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget referenceListUI(BuildContext context) {
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
                SvgImageConstant.personWithVerticalLine,
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
                    infoMessage: StringConstant.deleteReferenceDesc,
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
                  .push(const PageRouteInfo(AddReferenceDetailScreen.name))
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
        const BaseText(
          text: "Professional",
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        BaseText(
          text: "Organization Name",
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textColor: AppColors.black.withOpacity(0.8),
        ),
        BaseText(
          text: "debra.holt@example.com",
          fontSize: 10,
          fontWeight: FontWeight.w400,
          textColor: AppColors.black.withOpacity(0.8),
        ),
      ],
    );
  }
}
