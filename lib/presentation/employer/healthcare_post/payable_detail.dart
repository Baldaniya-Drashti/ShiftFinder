// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_string_interpolations

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
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'payableDetail')
class PayableDetail extends StatelessWidget {
  const PayableDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: StringConstant.payables,
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  singleShiftSlip(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: getSize(20)),
                    child: CommonButton(
                      onPressed: () {
                        AppDialog.showDelete(
                          context,
                          title: StringConstant.postTheShift,
                          infoMessage: StringConstant.postShiftDesc,
                          deleteBtnText: StringConstant.post,
                          onCancelClick: () {
                            Navigator.pop(context);
                          },
                          onDeleteClick: () {
                            Navigator.pop(context);
                            AppDialog.showSuccess(
                              context,
                              title: StringConstant.allSet,
                              infoMessage: StringConstant.shiftSuccessDesc,
                              onOkClick: () {
                                context.router.maybePop();
                              },
                            );
                          },
                        );
                      },
                      buttonText: StringConstant.postTheShift,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget paybaleTitleRate(
      {required String title,
      required String value,
      bool isFirst = false,
      isLast = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BaseText(
          text: title,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          textColor: AppColors.black.withOpacity(0.7),
        ),
        BaseText(
          text: value,
          fontSize: (isLast) ? 14 : 12,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w500,
          textColor: (isFirst) ? AppColors.primaryColor : AppColors.black,
        ),
      ],
    );
  }

  Widget commonDivider() {
    return Divider(
      color: AppColors.black.withOpacity(0.2),
      thickness: getSize(0.5),
    );
  }

  Widget payableBox({
    required String title1,
    String? title2,
    required String value1,
    String? value2,
    String? title3,
    String? value3,
    String? totalPayableTitle,
    String? totalPayable,
    Color? backgroundColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.grey04,
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        dense: true,
        visualDensity: VisualDensity.compact,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paybaleTitleRate(
              title: title1 ?? "",
              value: value1,
            ),
            if (title2 != null) ...[
              paddingBetweenFields(),
              paybaleTitleRate(
                title: title2,
                value: value2 ?? "",
              ),
            ],
            paddingBetweenFields(),
            if (title3 != null) ...[
              paybaleTitleRate(
                title: title3,
                value: value3 ?? "",
              ),
            ],
            if (totalPayable != null) ...[
              commonDivider(),
              paybaleTitleRate(
                title: totalPayableTitle ?? "",
                value: totalPayable,
                isLast: true,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget totalPayableBox({
    String? totalPayableTitle,
    String? totalPayable,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        dense: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            paybaleTitleRate(
              title: totalPayableTitle ?? "",
              value: totalPayable ?? "",
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget multiShiftSlip() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        payableBox(
          title1: StringConstant.totalNumberOfDays,
          title2: StringConstant.totalPayableHours,
          title3: StringConstant.hourlyRate,
          value1: "7",
          value2: "65h 30min",
          value3: "\$10.00",
          totalPayableTitle: StringConstant.totalWage,
          totalPayable: "\$655.00",
        ),
        payableBox(
          title1: StringConstant.totalCommuteAllowance,
          title2: StringConstant.totalAccommodationAllowance,
          title3: StringConstant.shiftFinderServiceFee,
          value1: "7",
          value2: "65h 30min",
          value3: "\$10.00",
          totalPayableTitle: StringConstant.totalAllowance,
          totalPayable: "\$655.00",
        ),
        payableBox(
          title1: StringConstant.sumOfAmounts,
          title2: StringConstant.numberOfVacancies,
          value1: "\$20",
          value2: "\$10",
        ),
        totalPayableBox(
          totalPayableTitle: StringConstant.totalAmount,
          totalPayable: "\$20",
        ),
      ],
    );
  }

  Widget singleShiftSlip() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        payableBox(
          title1: StringConstant.totalPayableHours,
          title2: StringConstant.hourlyRate,
          value1: "\$20",
          value2: "\$10",
          totalPayableTitle: StringConstant.totalWage,
          totalPayable: "\$4675.00",
        ),
        payableBox(
          title1: StringConstant.commuteAllowance,
          title2: StringConstant.accommodationAllowance,
          value1: "\$20",
          value2: "\$10",
          totalPayableTitle: StringConstant.totalAllowance,
          totalPayable: "\$4675.00",
        ),
        payableBox(
          title1: StringConstant.shiftFinderServiceFee,
          value1: "\$20",
        ),
        payableBox(
          title1: StringConstant.totalPayableForOneShift,
          title2: StringConstant.numberOfVacancies,
          value1: "\$20",
          value2: "\$10",
        ),
        totalPayableBox(
          totalPayableTitle: StringConstant.totalAmountPayable,
          totalPayable: "\$20",
        ),
      ],
    );
  }
}
