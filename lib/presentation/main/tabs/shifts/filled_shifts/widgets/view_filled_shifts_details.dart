// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(
  name: 'ViewFilledShiftsDetails',
)
class ViewFilledShiftsDetails extends StatelessWidget {
  const ViewFilledShiftsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: StringConstant.viewShiftDetails,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: getSize(10),
              vertical: getSize(24),
            ),
            padding: EdgeInsets.all(getSize(10)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(getSize(20)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.15),
                  offset: Offset(0, 0),
                  blurRadius: 24,
                ),
              ],
            ),
            child: Column(
              children: [
                userDataBox(
                  context,
                ),
                viewAgreedPraposalView(context),
                // (shift.shift_detail?.shift_type == 1)
                //     ?
                //singleShiftDateTimeBreakUI(context),

                multiShiftDateTimeBreakUI(context),
                // if (shift.specialties_detail != null &&
                //     shift.specialties_detail!.isNotEmpty)
                requiredSkillBox(
                  svgPrefixIcon: SvgImageConstant.female,
                  title: StringConstant.specialtiesRequired,
                  value:
                      'Behavioral Health, Perinatal, Urology, Anesthesiology, NICU',
                ),
                // if (shift.software_skill != null &&
                //     shift.software_skill!.isNotEmpty)
                requiredSkillBox(
                  svgPrefixIcon: SvgImageConstant.mouse,
                  title: StringConstant.softwareSkills,
                  value: 'Solvo Portal, PointClickCare, Solvo Portal',
                ),
                rateHoursBox(),
                languageBox(
                  title: StringConstant.languageRequirements,
                  value: languageList(),
                ),
                // if (shift.shift_detail != null &&
                //     shift.shift_detail?.shift_note != null &&
                //     shift.shift_detail!.shift_note!.isNotEmpty)
                notesBox(
                  title: StringConstant.shiftNote,
                  value:
                      "Lorem ipsum dolor sit amet,gurte to consectetur adipiscing elit, sed do eghte fir eiusmod tempor incididunt ut labore et dolore magna?",
                ),
                // if (shift.shift_detail != null &&
                //     shift.shift_detail!.disclaimer != null &&
                //     shift.shift_detail!.disclaimer!.isNotEmpty)
                notesBox(
                    title: StringConstant.disclaimer,
                    value:
                        "Lorem ipsum dolor sit amet,gurte to consectetur adipiscing elit, sed do eghte fir eiusmod tempor incididunt ut labore et dolore magna?"),
                locationDetailBox(
                  title: StringConstant.locationDetails,
                  locationValue: '2464 Royal Ln. Mesa, New Jersey 45463',
                  // "2464 Royal Ln. Mesa, New Jersey 45463",
                  units: 'X-ray',
                ),
                // if (shift.shift_detail != null &&
                //     shift.shift_detail!.payables != null)
                payableBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget languageBox({
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey04,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        subtitle: BaseText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          textColor: AppColors.primaryColor,
          maxLines: 5,
        ),
        title: BaseText(
          text: title,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          lineHeight: getSize(3),
        ),
      ),
    );
  }

  Widget payableBox() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(10)),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          paybaleTitleRate(
            title: StringConstant.totalNumberOfVacancy,
            value: "08",
            isFirst: true,
          ),
          commonDivider(),
          paybaleTitleRate(
            title: "${StringConstant.accommodationAllowance}:-",
            value: "\$20",
          ),
          paybaleTitleRate(
            title: "${StringConstant.commuteAllowance}:-",
            value: "\$10",
          ),
          paybaleTitleRate(
            title: "${StringConstant.shiftFinderServiceFee}:-",
            value: "\$150",
          ),
          commonDivider(),
          paybaleTitleRate(
            title: StringConstant.estimatedTotalPayable,
            value: "\$4675",
            isLast: true,
          ),
        ],
      ),
    );
  }

  String languageList() {
    // List<SkillDTO> list = List<SkillDTO>.from(post.languages_list ?? []);
    // if (post.language_other != null && post.language_other!.isNotEmpty) {
    //   list.add(SkillDTO(name: post.language_other));
    // }

    // Return the list of language names as a comma-separated string
    return 'English, Spanish, French';
  }

  Widget requiredSkillBox({
    required String svgPrefixIcon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        leading: Row(
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
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: SvgPicture.asset(
                SvgImageConstant.verticalLine,
              ),
            ),
          ],
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            Flexible(
              child: BaseText(
                text: value,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                lineHeight: getSize(1),
                maxLines: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rateHoursBox() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          rateWithBGIcon(
            svgIcon: SvgImageConstant.clockWithBag,
            title: StringConstant.hourlyRate,
            value: "\$27",
          ),
          Container(
            width: getSize(40),
            padding: EdgeInsets.symmetric(horizontal: getSize(10)),
            child: SvgPicture.asset(SvgImageConstant.verticalLine),
          ),
          rateWithBGIcon(
            svgIcon: SvgImageConstant.clockWithOuterLine,
            title: StringConstant.totalHours,
            value: '9h 15min',
          ),
        ],
      ),
    );
  }

  Widget notesBox({
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            commonDivider(),
            BaseText(
              text: value,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              lineHeight: getSize(1),
              textColor: AppColors.black.withValues(alpha: 0.9),
            ),
          ],
        ),
      ),
    );
  }

  viewAgreedPraposalView(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (post.shift_detail != null) {
        context.router.push(
          PageRouteInfo(
            ViewAgreedPraposal.name,
          ),
        );
        // }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: getSize(6)),
        padding: EdgeInsets.symmetric(
          vertical: getSize(8),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(7)),
          color: AppColors.primaryColor.withValues(alpha: 0.10),
        ),
        child: BaseText(
          text: 'View Agreed Proposal',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget userDataBox(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.grey04,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(10)),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
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
            title: BaseText(
              text: 'CT Technologist',
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
              text: '2 Days Ago',
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          commonDivider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Flexible(
                child: BaseText(
                  text: '4517 Washington Manchester, Kentucky 39495',
                  fontSize: 10,
                  maxLines: 5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget commonDivider() {
    return Divider(
      color: AppColors.black.withValues(alpha: 0.2),
      thickness: getSize(0.5),
    );
  }

  Widget singleShiftDateTimeBreakUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.grey04,
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayDateBreak(
                context,
                boldValue: convertTimeStampToDate(
                  DateTime.now().millisecondsSinceEpoch ~/ 1000,
                ),
                timidValue: convertTimeStampToDate(
                    DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    isYear: true),
                title: StringConstant.shiftDate,
                svgPrefixIcon: SvgImageConstant.calendar,
              ),
              displayTime(
                title: StringConstant.time,
                startDate: convertTimeStampToDate(
                    DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    isTime: true),
                endDate: convertTimeStampToDate(
                    DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    isTime: true),
                svgPrefixIcon: SvgImageConstant.clock,
              ),
              displayDateBreak(context,
                  boldValue: "45 Min",
                  timidValue: "",
                  title: StringConstant.unpaidBreak,
                  svgPrefixIcon: SvgImageConstant.clock),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: getSize(10), right: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.clockWithBag,
              height: getSize(85),
              width: getSize(85),
              color: AppColors.primaryColor.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }

  String convertTimeStampToDate(int timestamp,
      {bool isYear = false, bool isTime = false}) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    if (isTime) {
      return DateFormat('hh:mm a').format(dateTime);
    } else {
      if (isYear) {
        return DateFormat('yyyy').format(dateTime);
      } else {
        return DateFormat('d MMMM, ').format(dateTime);
      }
    }
  }

  Widget multiShiftDateTimeBreakUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.grey04,
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayDateBreak(
                context,
                boldValue: "",
                timidValue: "",
                showBtn: true,
                title: StringConstant.shiftDates,
                svgPrefixIcon: SvgImageConstant.calendar,
              ),
              // (post.shift_detail?.shift_type == 2 &&
              //         post.shift_detail?.same_or_different_time == 2)
              //     ? displayDateBreak(context, post,
              //         boldValue: (post.shift_detail?.detail != null &&
              //                 post.shift_detail!.detail!.isNotEmpty)
              //             ? "${(post.shift_detail?.detail?.length.toString().length == 2) ? post.shift_detail?.detail?.length : "0${post.shift_detail?.detail?.length}"}"
              //             : "00",
              //         timidValue: "",
              //         title: StringConstant.totalNumberOfShifts,
              //         svgPrefixIcon: SvgImageConstant.clockWithOuterLine)
              //     :
              displayDateBreak(context,
                  boldValue: "45 Min",
                  timidValue: "",
                  title: StringConstant.unpaidBreak,
                  svgPrefixIcon: SvgImageConstant.clock),
              // displayDateBreak(context, post,
              //     boldValue: post.shift_detail?.unpaid_break?.short_name ?? "",
              //     timidValue: "",
              //     title: StringConstant.unpaidBreak,
              //     svgPrefixIcon: SvgImageConstant.clock),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: getSize(10), right: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.clockWithBag,
              height: getSize(85),
              width: getSize(85),
              color: AppColors.primaryColor.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }

  Widget displayDateBreak(
    BuildContext context, {
    required String title,
    required String boldValue,
    required String timidValue,
    required String svgPrefixIcon,
    bool showBtn = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            svgPrefixIcon,
            color: AppColors.black,
            height: getSize(20),
            width: getSize(16),
          ),
          SizedBox(width: getSize(10)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: title,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              (showBtn)
                  ? CommonButton(
                      onPressed: () {
                        // if (post.shift_detail != null) {
                        context.router.push(
                          PageRouteInfo(
                            ViewFilledShiftsDates.name,
                          ),
                        );
                        // }
                      },
                      width: 100,
                      height: 23,
                      borderRadius: 5,
                      buttonFontSize: 12,
                      buttonFontWeight: FontWeight.w500,
                      buttonText: StringConstant.viewDates,
                    )
                  : highLightText(boldValue: boldValue, timidValue: timidValue),
            ],
          )
        ],
      ),
    );
  }

  Widget displayTime({
    required String title,
    required String startDate,
    required String endDate,
    required String svgPrefixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            svgPrefixIcon,
            color: AppColors.black,
            height: getSize(20),
            width: getSize(16),
          ),
          SizedBox(width: getSize(10)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: StringConstant.time,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  highLightText(
                      boldValue: "${startDate.split(':')[0]}:",
                      timidValue: startDate.split(':')[1].split(' ')[0],
                      thirdValue: " ${startDate.split(':')[1].split(' ')[1]}"),
                  BaseText(
                    text: "  to  ",
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black.withValues(alpha: 0.7),
                  ),
                  highLightText(
                      boldValue: "${endDate.split(':')[0]}:",
                      timidValue: endDate.split(':')[1].split(' ')[0],
                      thirdValue: " ${endDate.split(':')[1].split(' ')[1]}"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue}) {
    return RichText(
        text: TextSpan(
      text: boldValue,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
      ),
      children: [
        TextSpan(
          text: timidValue,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor.withValues(alpha: 0.5),
          ),
        ),
        TextSpan(
          text: thirdValue ?? "",
        ),
      ],
    ));
  }

  Widget rateWithBGIcon(
      {required String svgIcon, required String title, required String value}) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              SizedBox(
                height: getSize(5),
              ),
              BaseText(
                text: value,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                textColor: AppColors.black,
              ),
            ],
          ),
          Flexible(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                svgIcon,
                height: getSize(35),
                width: getSize(35),
                color: AppColors.primaryColor.withValues(alpha: 0.2),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget locationDetailBox({
    required String title,
    required String locationValue,
    required String units,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            commonDivider(),
            BaseText(
              text: StringConstant.location,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              textColor: AppColors.primaryColor,
            ),
            BaseText(
              text: locationValue,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textColor: AppColors.black.withValues(alpha: 0.9),
            ),
            if (units.isNotEmpty) ...[
              SizedBox(
                height: getSize(10),
              ),
              BaseText(
                text: StringConstant.unit,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textColor: AppColors.primaryColor,
              ),
              BaseText(
                text: units,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                textColor: AppColors.black.withValues(alpha: 0.9),
              ),
            ],
          ],
        ),
      ),
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
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w400,
          textColor: AppColors.black.withValues(alpha: 0.7),
        ),
        BaseText(
          text: value,
          fontSize: (isLast) ? 18 : 14,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w400,
          textColor: (isFirst) ? AppColors.primaryColor : AppColors.black,
        ),
      ],
    );
  }

  Widget chipListBox({
    required List<String> chipList,
    required String title,
    required String value,
  }) {
    return Container(
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
              textColor: AppColors.black,
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
            SizedBox(
              height: getSize(10),
            ),
            CustomChipSet(
              onDelete: (v) {},
              chipList: chipList,
              deleteIcon: Container(),
              deleteIconBoxConstraints:
                  BoxConstraints(minWidth: 0, minHeight: 0),
            ),
          ],
        ));
  }

  Widget templateCheckBox() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getSize(20),
            width: getSize(16.67),
            child: Checkbox(
              value: true,
              activeColor: AppColors.primaryColor,
              side: BorderSide(
                width: getSize(1.5),
                color: AppColors.black.withValues(alpha: 0.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            width: getSize(15),
          ),
          Flexible(
            child: BaseText(
              text: StringConstant.saveThisAsATemplateForFuturePosting,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
