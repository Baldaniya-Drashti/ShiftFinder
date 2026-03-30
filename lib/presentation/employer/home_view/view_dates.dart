// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, must_be_immutable, unused_field, avoid_print, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewDates')
class ViewDates extends StatelessWidget {
  ShiftDetailDTO shiftDetail;
  final bool isUpcoming;
  ViewDates({
    super.key,
    required this.shiftDetail,
    this.isUpcoming = false,
  });

  @override
  Widget build(BuildContext context) {
    final shift = shiftDetail.detail ?? [];

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
                    "${(isUpcoming) ? StringConstant.remainingShifts : StringConstant.totalNumberOfShifts} - ${(shift.length < 10) ? "0${shift.length}" : shift.length}",
              ),
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
                      unpaidBreak: "${shift[index].unpaid_break?.short_name}",
                    );
                  }),
              SizedBox(height: getSize(50)),
            ],
          ),
        ),
      ),
    );
  }

  String convertTimeStampToDate(int timestamp, {bool isDate = false}) {
    DateTime dateTime = CustomDateTimeFormat.timeStampToDateTime(timestamp);

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
                  textColor: AppColors.black.withValues(alpha: 0.7),
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
                if (shiftDetail.shift_type == 2
                    //  &&    shiftDetail.same_or_different_time == 2
                    ) ...[
                  SizedBox(height: getSize(10)),
                  BaseText(
                    text: StringConstant.unpaidBreak,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.black.withValues(alpha: 0.7),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: getSize(5)),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      dense: true,
                      title: BaseText(
                        text: (shiftDetail.same_or_different_time == 1)
                            ? shiftDetail.unpaid_break?.name ?? ""
                            : unpaidBreak,
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
