import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewFilledShiftsDates')
class ViewFilledShiftsDates extends StatelessWidget {
  const ViewFilledShiftsDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: StringConstant.viewShiftDates,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(10),
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          numberOfShift(
            svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
            title: "${StringConstant.totalNumberOfShifts} - 05",
          ),
          // CustomMultiDatePicker(value: [
          //   DateTime.now(),
          //   DateTime(DateTime.now().year, DateTime.now().month,
          //       DateTime.now().day + 1)
          // ]),
          ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return chipListBox(
                  date: convertTimeStampToDate(
                    DateTime.now().millisecondsSinceEpoch,
                    isDate: true,
                  ),
                  title: StringConstant.shiftTime,
                  value:
                      "${convertTimeStampToDate(DateTime.now().millisecondsSinceEpoch)} to ${convertTimeStampToDate(DateTime.now().millisecondsSinceEpoch)}",
                  unpaidBreak: "asds",
                );
              }),
        ],
      ),
    );
  }

  String convertTimeStampToDate(int timestamp, {bool isDate = false}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (isDate) {
      return DateFormat('d MMM, yyyy').format(dateTime);
    } else {
      return DateFormat('hh:mm a').format(dateTime);
    }
  }

  Widget numberOfShift({
    required String svgPrefixIcon,
    required String title,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(43),
            width: getSize(35),
            child: SvgPicture.asset(
              svgPrefixIcon,
              color: AppColors.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.verticalLine,
              height: getSize(50),
            ),
          ),
          BaseText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget chipListBox({
    required String date,
    required String title,
    required String value,
    required String unpaidBreak,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              getSize(20), getSize(10), getSize(20), getSize(5)),
          child: BaseText(
            text: date,
            textColor: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: getSize(12),
            vertical: getSize(10),
          ),
          margin: EdgeInsets.symmetric(vertical: getSize(5)),
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withOpacity(0.7),
              ),
              Container(
                margin: EdgeInsets.only(top: getSize(5)),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  dense: true,
                  title: BaseText(
                    text: value,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.black,
                  ),
                ),
              ),
              // if (shiftDetail.shift_type == 2 &&
              //     shiftDetail.same_or_different_time == 2) ...[
              // SizedBox(height: getSize(10)),
              // BaseText(
              //   text: StringConstant.unpaidBreak,
              //   fontSize: 14,
              //   fontWeight: FontWeight.w500,
              //   textColor: AppColors.black.withOpacity(0.7),
              // ),
              // Container(
              //   margin: EdgeInsets.only(top: getSize(5)),
              //   decoration: BoxDecoration(
              //       color: AppColors.white,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: ListTile(
              //     dense: true,
              //     title: BaseText(
              //       text: unpaidBreak,
              //       fontSize: 14,
              //       fontWeight: FontWeight.w500,
              //       textColor: AppColors.black,
              //     ),
              //   ),
              // ),
              //    ],
            ],
          ),
        ),
      ],
    );
  }
}
