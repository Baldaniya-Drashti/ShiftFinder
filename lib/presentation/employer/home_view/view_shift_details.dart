// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewHomeShiftDetails')
class ViewHomeShiftDetails extends StatelessWidget {
  const ViewHomeShiftDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: StringConstant.viewDetails,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: getSize(20),
        ),
        padding: EdgeInsets.all(getSize(10)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            userDataBox(context),
            dateTimeBreakUI(context),
          ],
        ),
      ),
    );
  }

  Widget userDataBox(BuildContext context) {
    return Container(
      // height: getSize(113.41),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.grey04,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(10)),
      child: Column(
        children: [
          ListTile(
            dense: true,
            titleAlignment: ListTileTitleAlignment.top,
            leading: SvgPicture.asset(
              SvgImageConstant.femaleGrey,
              width: getSize(36.28),
              height: getSize(43.41),
            ),
            title: const BaseText(
              text: "CT Technologist",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: BaseText(
              text: "(Healthcare - 2DFG125)",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black.withOpacity(0.70),
            ),
            trailing: BaseText(
              text: "2 Days Ago",
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          Divider(
            color: AppColors.black.withOpacity(0.2),
            thickness: getSize(0.5),
          ),
          Row(
            children: [
              SvgPicture.asset(
                SvgImageConstant.location,
                color: AppColors.black,
                height: getSize(20),
                width: getSize(20),
              ),
              SizedBox(
                width: getSize(10),
              ),
              const BaseText(
                text: "4517, Washington Manchester, Kentucky 39495",
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dateTimeBreakUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.grey04,
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(10)),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      child: Column(
        children: [
          dateTime(),
          dateTime(),
          dateTime(),
        ],
      ),
    );
  }

  Widget dateTime() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            SvgImageConstant.calendar,
            color: AppColors.black,
            height: getSize(15),
            width: getSize(16),
          ),
          SizedBox(width: getSize(10)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: "Shift Date",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textColor: AppColors.black.withOpacity(0.7),
              ),
              BaseText(
                text: "12 May, 2024",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppColors.primaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
