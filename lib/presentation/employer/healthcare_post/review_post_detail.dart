// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, unnecessary_string_interpolations, must_be_immutable, avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/review_post_bloc/review_post_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/post_shift_dto/post_shift_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'reviewPostShiftDetail')
class ReviewPostShiftDetail extends StatelessWidget {
  HealthcarePostDTO post;
  PostShiftDTO? postRequest;
  bool isUpdate;
  final bool fromSaveTemplate;
  final bool fromReview;
  final bool isCreate;

  ReviewPostShiftDetail({
    super.key,
    required this.post,
    this.isUpdate = false,
    this.postRequest,
    this.fromSaveTemplate = false,
    this.fromReview = false,
    this.isCreate = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReviewPostBloc>()
        ..add(ReviewPostEvent.getShiftData(post: post)),
      child: PopScope(
        canPop: false,
        child: BlocBuilder<ReviewPostBloc, ReviewPostState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.scaffoldColor,
              appBar: CommonAppBar(
                onBackPressed: () {
                  Navigator.pop(context);
                },
                isShowBackBtn: false,
                title: StringConstant.reviewDetails,
              ),
              bottomSheet: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getSize(10), horizontal: getSize(10)),
                child: CommonButton(
                  onPressed: () {
                    context.router.push(PageRouteInfo(PayableDetail.name,
                        args: PayableDetailArgs(
                          post: post,
                          updatedPost: postRequest,
                          isUpdate: isUpdate,
                          fromSaveTemplate: fromSaveTemplate,
                          fromReview: fromReview,
                          isCreate: isCreate,
                        )));
                  },
                  buttonText: StringConstant.txtContinue,
                ),
              ),
              body: LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: getSize(10))
                          .copyWith(bottom: getSize(80)),
                      child: Container(
                        padding: EdgeInsets.all(getSize(10)),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            userDataBox(context),
                            (post.shift_detail?.shift_type == 1)
                                ? singleShiftDateTimeBreakUI(context)
                                : multiShiftDateTimeBreakUI(
                                    context, post.shift_detail),
                            if (post.specialties_detail != null &&
                                post.specialties_detail!.isNotEmpty)
                              requiredSkillBox(
                                svgPrefixIcon: SvgImageConstant.female,
                                title: StringConstant.specialtiesRequired,
                                value: post.specialties_detail ?? "",
                              ),
                            if (post.software_skill != null &&
                                post.software_skill!.isNotEmpty)
                              requiredSkillBox(
                                svgPrefixIcon: SvgImageConstant.mouse,
                                title: StringConstant.softwareSkills,
                                value: post.software_skill ?? "",
                              ),
                            rateHoursBox(),
                            languageBox(
                              context,
                              title: StringConstant.languageRequirements,
                              value: languageList(),
                            ),
                            locationDetailBox(context,
                                title: StringConstant.locationDetails,
                                locationValue: post.location?.location ?? "",
                                units: post.location_unit ?? ""),
                            if (post.shift_detail != null &&
                                post.shift_detail?.shift_note != null &&
                                post.shift_detail!.shift_note!.isNotEmpty)
                              notesBox(
                                title: StringConstant.shiftNote,
                                value: post.shift_detail?.shift_note ?? "",
                              ),
                            if (post.shift_detail != null &&
                                post.shift_detail!.shift_type == 1 &&
                                post.shift_detail!.recurring_status == 1 &&
                                post.shift_detail!.recurrence_mode != null)
                              recurrence(),
                            if (post.shift_detail != null &&
                                post.shift_detail!.disclaimer != null &&
                                post.shift_detail!.disclaimer!.isNotEmpty)
                              notesBox(
                                  title: StringConstant.disclaimer,
                                  value: post.shift_detail?.disclaimer ?? ""),
                            if (post.shift_detail != null &&
                                post.shift_detail!.number_of_vacancie != null)
                              numberOfVacancy(
                                  value: (post.shift_detail!.number_of_vacancie
                                              .toString()
                                              .length ==
                                          1)
                                      ? "0${post.shift_detail!.number_of_vacancie}"
                                      : "${post.shift_detail!.number_of_vacancie}"),
                            SizedBox(height: getSize(5)),
                            if (post.shift_detail != null &&
                                post.shift_detail!.teams != null &&
                                post.shift_detail!.teams!.isNotEmpty)
                              chipListBox(
                                chipList: post.shift_detail!.teams!
                                    .where((item) => item.name != null)
                                    .map((item) => item.name ?? "")
                                    .toList(),
                                title: StringConstant.selectedTeams,
                                value: (post.shift_detail!.teams!.length < 10)
                                    ? "0${post.shift_detail!.teams!.length}"
                                    : "${post.shift_detail!.teams!.length}",
                              ),
                            if (post.shift_detail != null &&
                                post.shift_detail!.save_template_status !=
                                    null &&
                                post.shift_detail!.save_template_status == 1)
                              templateCheckBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  Widget recurrence() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(10)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey04,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            text: StringConstant.recurrenceDuration,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
          ),
          SizedBox(height: getSize(7)),
          Row(
            children: [
              BaseText(
                text: (post.shift_detail?.recurring_start_date != null)
                    ? "${DateFormat("d MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch((post.shift_detail?.recurring_start_date ?? -1) * 1000))}"
                    : "",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primaryColor,
              ),
              BaseText(
                text: "  to  ",
                fontSize: 11,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              BaseText(
                text: (post.shift_detail?.recurring_end_date != null)
                    ? "${DateFormat("d MMM, yyyy").format(DateTime.fromMillisecondsSinceEpoch((post.shift_detail?.recurring_end_date ?? -1) * 1000))}"
                    : "",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primaryColor,
              ),
            ],
          ),
          SizedBox(height: getSize(15)),
          if (post.shift_detail != null &&
              post.shift_detail!.shift_type == 1 &&
              post.shift_detail!.recurrence_mode != null)
            chipListBox(
              padding: EdgeInsets.zero,
              bgColor: AppColors.transparent,
              chipList: (post.shift_detail!.days != null &&
                      post.shift_detail!.days!.isNotEmpty)
                  ? post.shift_detail!.days!
                      .split(',')
                      .where((item) => item.isNotEmpty)
                      .map((item) {
                        int dayId = int.parse(item.trim());
                        SkillDTO? day = CommonList.weekList.firstWhere(
                            (element) => element.id == dayId,
                            orElse: () => SkillDTO());
                        return day.name ?? "";
                      })
                      .where((dayName) => dayName.isNotEmpty)
                      .toList()
                  : [],
              title: StringConstant.recurrenceMode,
              value: (post.shift_detail?.recurrence_mode == "2")
                  ? StringConstant.weekly
                  : StringConstant.daily,
            ),
        ],
      ),
    );
  }

  Widget languageBox(
    BuildContext context, {
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
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        subtitle: BaseText(
          text: value,
          fontSize: 14,
          fontWeight: FontWeight.w600,
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
            SizedBox(height: getSize(3)),
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
              value: "\$${post.rate_hour}",
            ),
            Container(
              width: getSize(40),
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: SvgPicture.asset(SvgImageConstant.verticalLine),
            ),
            rateWithBGIcon(
              svgIcon: SvgImageConstant.clockWithOuterLine,
              title: StringConstant.totalHours,
              value: post.shift_detail?.total_payable_hour ?? "",
            ),
          ],
        ));
  }

  Widget userDataBox(BuildContext context) {
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
              text: post.roles_list_name ?? "",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: BaseText(
              text:
                  "(${CommonList.industryList.where((item) => item.id == getCurrentIndustry()).map((item) => item.title).join(', ')} - ${post.listing_id})",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black.withOpacity(0.70),
            ),
            trailing: commonEditButton(context, type: 1),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          commonDivider(),
          GestureDetector(
            onTap: () {
              final location = post.location;
              final latitude = location?.latitude;
              final longitude = location?.longitude;
              if (latitude != null && longitude != null) {
                LocationHelper.openDirections(context,
                    endLat: latitude, endLng: longitude);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  color: AppColors.black,
                  height: getSize(25),
                  width: getSize(25),
                ),
                SizedBox(width: getSize(10)),
                Flexible(
                  child: BaseText(
                    text: post.location?.location ?? "",
                    fontSize: 10,
                    maxLines: 5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  displayDateBreak(
                    context,
                    boldValue: convertTimeStampToDate(
                        post.shift_detail?.detail?[0].date ?? -1),
                    timidValue: "",
                    title: StringConstant.shiftDate,
                    svgPrefixIcon: SvgImageConstant.calendar,
                  ),
                  displayTime(
                    title: StringConstant.time,
                    startDate: convertTimeStampToDate(
                        post.shift_detail?.detail?[0].start_time ?? -1,
                        isTime: true),
                    endDate: convertTimeStampToDate(
                        post.shift_detail?.detail?[0].end_time ?? -1,
                        isTime: true),
                    svgPrefixIcon: SvgImageConstant.clock,
                  ),
                  displayDateBreak(
                    context,
                    boldValue: post.shift_detail?.unpaid_break?.name ?? "",
                    timidValue: "",
                    title: StringConstant.unpaidBreak,
                    svgPrefixIcon: SvgImageConstant.clock,
                  ),
                ],
              ),
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

  Widget commonEditButton(BuildContext context, {required int type}) {
    return GestureDetector(
      onTap: () {
        context.router.push(PageRouteInfo(HealthCarePostForm.name,
            args: HealthCarePostFormArgs(
              postId: post.id,
              fromReview: true,
              isCreate: isCreate,
              fromSaveTemplate: fromSaveTemplate,
            )));
      },
      child: Container(
        padding: EdgeInsets.all(getSize(5)),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          SvgImageConstant.edit,
          height: getSize(16),
          width: getSize(16),
        ),
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
        return DateFormat('dd MMM, yyyy').format(dateTime);
      }
    }
  }

  Widget multiShiftDateTimeBreakUI(
      BuildContext context, ShiftDetailDTO? shiftDetail) {
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
              (post.shift_detail?.shift_type == 2
                  // && post.shift_detail?.same_or_different_time == 2
                  )
                  ? displayDateBreak(context,
                      boldValue: (post.shift_detail?.detail != null &&
                              post.shift_detail!.detail!.isNotEmpty)
                          ? "${(post.shift_detail?.detail?.length.toString().length == 2) ? post.shift_detail?.detail?.length : "0${post.shift_detail?.detail?.length}"} Shifts"
                          : "00 Shifts",
                      timidValue: "",
                      title: StringConstant.totalShifts,
                      svgPrefixIcon: SvgImageConstant.clock)
                  : displayDateBreak(context,
                      boldValue:
                          "${shiftDetail?.unpaid_break?.short_name ?? ""}",
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
                fontWeight: FontWeight.w400,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              (showBtn)
                  ? CommonButton(
                      onPressed: () {
                        if (post.shift_detail != null) {
                          context.router.push(PageRouteInfo(ViewDates.name,
                              args: ViewDatesArgs(
                                  shiftDetail: post.shift_detail!)));
                        }
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
                fontWeight: FontWeight.w400,
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
            color: AppColors.primaryColor,
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
    return Row(
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
            SizedBox(height: getSize(5)),
            BaseText(
              text: value,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textColor: AppColors.black,
            ),
          ],
        ),
        SizedBox(width: getSize(10)),
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            svgIcon,
            height: getSize(35),
            width: getSize(35),
            color: AppColors.primaryColor.withValues(alpha: 0.2),
          ),
        ),
      ],
    );
  }

  Widget locationDetailBox(
    BuildContext context, {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.7),
                ),
              ],
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
                text: "${StringConstant.unit}",
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

  Widget commonDivider() {
    return Divider(
      color: AppColors.black.withValues(alpha: 0.2),
      thickness: getSize(0.5),
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
          textColor: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget chipListBox({
    required List<String> chipList,
    required String title,
    required String value,
    Color? bgColor,
    EdgeInsets? padding,
  }) {
    return Container(
        padding: padding ??
            EdgeInsets.symmetric(
                horizontal: getSize(12), vertical: getSize(10)),
        margin: EdgeInsets.symmetric(vertical: getSize(0)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.grey04,
            borderRadius: BorderRadius.circular(10)),
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
            SizedBox(height: getSize(10)),
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

  Widget numberOfVacancy({
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
        child: paybaleTitleRate(
            title: StringConstant.numberOfVacancies, value: value));
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

  String languageList() {
    List<SkillDTO> list = List<SkillDTO>.from(post.languages_list ?? []);
    if (post.language_other != null && post.language_other!.isNotEmpty) {
      list.add(SkillDTO(name: post.language_other));
    }

    // Return the list of language names as a comma-separated string
    return list
        .where((item) => item.name != null)
        .map((item) => item.name)
        .join(', ');
  }
}
