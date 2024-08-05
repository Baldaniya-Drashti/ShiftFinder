// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewDates')
class ViewDates extends StatelessWidget {
  ViewDates({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime?> _selectedDates = [
      DateTime(2024, 8, 7),
      DateTime(2024, 8, 8),
      DateTime(2024, 8, 11),
      DateTime(2024, 8, 15),
      DateTime(2024, 8, 1),
    ];
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: StringConstant.viewDates,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        child: Column(
          children: [
            numberOfShift(
              svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
              title: "${StringConstant.totalNumberOfShifts} - 09",
            ),
            CalendarDatePicker2(
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
            ),
            startEndDate(
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
            ),
          ],
        ),
      ),
    );
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
            color: AppColors.white, borderRadius: BorderRadius.circular(10)),
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
        ));
  }

  Widget startEndDate(
      {required String hour, required String minute, required String title}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomTextField(
                labelText: title,
                hintAsValue: true,
                hintText: hour,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(14),
                    vertical: getSize(14),
                  ),
                  child: SvgPicture.asset(
                    SvgImageConstant.clock,
                    height: getSize(24),
                    width: getSize(24),
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: getSize(20),
            ),
            Expanded(
              child: CustomTextField(
                hintAsValue: true,
                hintText: minute,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(14),
                    vertical: getSize(14),
                  ),
                  child: SvgPicture.asset(
                    SvgImageConstant.clock,
                    height: getSize(24),
                    width: getSize(24),
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
