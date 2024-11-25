import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "BankListView")
class BankListView extends StatelessWidget {
  const BankListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(bottom: 40),
        child: CommonButton(
          onPressed: () {},
          buttonText: "Add Bank Details",
        ),
      ),
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: "Bank Details",
      ),
      body: Visibility(
        visible: true,
        replacement: _NoBankAddedView(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _ListTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoBankAddedView extends StatelessWidget {
  const _NoBankAddedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            height: 90,
            width: 90,
            SvgImageConstant.bankDollar,
            colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.7), BlendMode.srcIn),
          ),
          Gap(30),
          BaseText(text: "No Bank Details Added", fontFamily: "Aclonica", fontSize: 20, fontWeight: FontWeight.w400),
          Gap(5),
          BaseText(
            fontSize: 14,
            text: "To ensure uninterrupted service and prompt payment deposits, please add your bank account details.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            SvgPicture.asset(
              SvgImageConstant.bankDollar,
              height: getSize(45),
              width: getSize(45),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Image.asset(
              PngImageConstants.line,
              height: getSize(80),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: "Misty Evans",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      Gap(5),
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(SvgImageConstant.verify, height: 14),
                            Gap(5),
                            BaseText(
                              text: "Verified",
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              textColor: AppColors.green,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(text: "Transit Number", fontSize: 10, fontWeight: FontWeight.w500),
                  SizedBox(
                    height: getSize(10),
                  ),
                  BaseText(
                    text: "********2548",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(6),
              color: AppColors.red.withOpacity(0.15),
              child: InkWell(
                onTap: () {
                  AppDialog.showDelete(
                    context,
                    title: "Delete Account",
                    infoMessage: "Are you sure you want to delete this bank account?",
                    onCancelClick: () {
                      context.router.maybePop();
                    },
                    onDeleteClick: () {},
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    SvgImageConstant.delete,
                    color: AppColors.red,
                    height: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
