// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, must_be_immutable, unused_field, avoid_print, deprecated_member_use

import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewContractorShiftDates')
class ViewContractorShiftDates extends StatelessWidget {
  ContactorDashboardDTO shiftDetail;
  ViewContractorShiftDates({super.key, required this.shiftDetail});

  @override
  Widget build(BuildContext context) {
    final shift = shiftDetail.shift_date ?? [];
    print("shiftDetail ---> ${jsonEncode(shiftDetail.id)}");

    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: StringConstant.viewShiftDates,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          child: Column(
            children: [
              numberOfShift(
                svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
                title:
                    "${StringConstant.totalNumberOfShifts} - ${(shift.length < 10) ? "0${shift.length}" : shift.length}",
              ),
              /*CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.multi,
                  disableMonthPicker: true,
                  disableModePicker: true,
                  weekdayLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
                  weekdayLabelTextStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  selectedDayTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                  selectedDayHighlightColor: AppColors.primaryColor,
                  daySplashColor: AppColors.transparent,
                  disabledDayTextStyle: TextStyle(
                    color: AppColors.black,
                  ),
                  selectableDayPredicate: (value) {
                    return false;
                  },
                ),
                value: _selectedDates,
                onValueChanged: (day) {},
              ),*/
              ListView.builder(
                  itemCount: shift.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return chipListBox(
                      date: convertTimeStampToDate(
                        shift[index].date ?? -1,
                        isDate: true,
                      ),
                      title: StringConstant.shiftTime,
                      value:
                          "${convertTimeStampToDate(shift[index].start_time ?? -1)} to ${convertTimeStampToDate(shift[index].end_time ?? -1)}",
                      unpaidBreak:
                          "${shift[index].unpaid_break?.short_name ?? ""}",
                    );
                  }),
              /*startEndDate(
                hour: "09 AM",
                minute: "30 Min",
                title: StringConstant.startTime,
              ),
              SizedBox(
                height: getSize(10),
              ),
              startEndDate(
                hour: "07 AM",
                minute: "15 Min",
                title: StringConstant.endTime,
              ),*/
              SizedBox(
                height: getSize(50),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String convertTimeStampToDate(int timestamp, {bool isDate = false}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    if (isDate) {
      return DateFormat('dd MMM, yyyy').format(dateTime);
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

  // Widget startEndDate(
  //     {required String hour, required String minute, required String title}) {
  //   return Column(
  //     children: [
  //       Row(
  //         crossAxisAlignment: CrossAxisAlignment.end,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Expanded(
  //             child: CustomTextField(
  //               labelText: title,
  //               hintAsValue: true,
  //               hintText: hour,
  //               prefixIcon: Padding(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: getSize(14),
  //                   vertical: getSize(14),
  //                 ),
  //                 child: SvgPicture.asset(
  //                   SvgImageConstant.clock,
  //                   height: getSize(24),
  //                   width: getSize(24),
  //                   color: AppColors.primaryColor,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: getSize(20),
  //           ),
  //           Expanded(
  //             child: CustomTextField(
  //               hintAsValue: true,
  //               hintText: minute,
  //               prefixIcon: Padding(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: getSize(14),
  //                   vertical: getSize(14),
  //                 ),
  //                 child: SvgPicture.asset(
  //                   SvgImageConstant.clock,
  //                   height: getSize(24),
  //                   width: getSize(24),
  //                   color: AppColors.primaryColor,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
            fontWeight: FontWeight.w600,
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
                color: AppColors.grey04,
                borderRadius: BorderRadius.circular(10)),
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
                if (shiftDetail.shift_type == 2 &&
                    shiftDetail.same_or_different_time == 2) ...[
                  SizedBox(height: getSize(10)),
                  BaseText(
                    text: StringConstant.unpaidBreak,
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
                        text: unpaidBreak,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ],
            )),
      ],
    );
  }
}
