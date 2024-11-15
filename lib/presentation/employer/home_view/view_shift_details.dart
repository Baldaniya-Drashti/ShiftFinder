// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/home/view_single_applicants/view_single_applicants_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/infrastructure/main/payable_dto.dart/payable_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/enum.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_chip_list.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewHomeShiftDetails')
class ViewHomeShiftDetails extends StatelessWidget {
  final int postId;

  final ShiftDetailRoute? route;

  const ViewHomeShiftDetails({
    super.key,
    required this.postId,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ViewSingleApplicantsBloc>()
        ..add(ViewSingleApplicantsEvent.getShiftDetailEvent(postId,
            fromDashboard: true)),
      child: BlocConsumer<ViewSingleApplicantsBloc, ViewSingleApplicantsState>(
        listener: (context, state) {
          state.shiftFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) {
                showError(
                  message: failure.maybeMap(
                    showAPIResponseMessage: (value) => value.message,
                    networkError: (value) =>
                        'Please check your internet connectivity',
                    orElse: () => "Server Error. Try again later.",
                  ),
                ).show(context);
              },
              (r) {},
            ),
          );
        },
        builder: (context, state) {
          final shift = state.shift;
          return Scaffold(
            backgroundColor: AppColors.scaffoldColor,
            appBar: CommonAppBar(
              onBackPressed: () {
                Navigator.pop(context);
              },
              title: StringConstant.viewShiftDetails,
            ),
            body: (state.isLoading)
                ? CenterLoadingIndicator()
                : (state.showErrorMessages)
                    ? Center(
                        child: BaseText(text: "No data found!"),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: getSize(10),
                        ),
                        padding: EdgeInsets.all(getSize(10)),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              userDataBox(context, shift),
                              (shift.shift_detail?.shift_type == 1)
                                  ? singleShiftDateTimeBreakUI(context, shift)
                                  : multiShiftDateTimeBreakUI(context, shift),
                              if (shift.specialties_detail != null &&
                                  shift.specialties_detail!.isNotEmpty)
                                requiredSkillBox(
                                  svgPrefixIcon: SvgImageConstant.female,
                                  title: StringConstant.specialtiesRequired,
                                  value: shift.specialties_detail ?? "",
                                ),
                              if (shift.software_skill != null &&
                                  shift.software_skill!.isNotEmpty)
                                requiredSkillBox(
                                  svgPrefixIcon: SvgImageConstant.mouse,
                                  title: StringConstant.softwareSkills,
                                  value: shift.software_skill ?? "",
                                ),
                              rateHoursBox(shift),
                              languageBox(
                                title: StringConstant.languageRequirements,
                                value: languageList(shift),
                              ),
                              if (shift.shift_detail != null &&
                                  shift.shift_detail?.shift_note != null &&
                                  shift.shift_detail!.shift_note!.isNotEmpty)
                                notesBox(
                                  title: StringConstant.shiftNote,
                                  value: shift.shift_detail?.shift_note ?? "",
                                ),
                              if (shift.shift_detail != null &&
                                  shift.shift_detail!.disclaimer != null &&
                                  shift.shift_detail!.disclaimer!.isNotEmpty)
                                notesBox(
                                    title: StringConstant.disclaimer,
                                    value:
                                        shift.shift_detail?.disclaimer ?? ""),
                              locationDetailBox(
                                  title: StringConstant.locationDetails,
                                  locationValue: shift.location?.location ?? "",
                                  // "2464 Royal Ln. Mesa, New Jersey 45463",
                                  units: shift.location_unit ?? ""),
                              if (shift.shift_detail != null &&
                                  shift.shift_detail!.shift_type == 1 &&
                                  shift.shift_detail!.recurring_status == 1 &&
                                  shift.shift_detail!.recurrence_mode != null)
                                recurrence(shift),
                              if (shift.shift_detail != null &&
                                  shift.shift_detail!.payables != null)
                                payableBox(shift, shift.shift_detail!.payables!,
                                    route),
                            ],
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }

  /*Widget agreedProposal(BuildContext context, HealthcarePostDTO shift) {
    return CommonButton(
      onPressed: () {
        context.router.push(PageRouteInfo(AgreedProposal.name,
            args: AgreedProposalArgs(post: shift)));
      },
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      buttonTextColor: AppColors.black,
      buttonFontSize: 12,
      borderRadius: 7,
      height: 34,
      buttonText: StringConstant.viewAgreedProposal,
    );
  }*/

  Widget payableBox(
      HealthcarePostDTO shift, PayableDTO payable, ShiftDetailRoute? route) {
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
            title: StringConstant.totalWage,
            value: "\$${payable.total_wage ?? 00}",
          ),
          paybaleTitleRate(
            title: StringConstant.totalAllowance,
            value: "\$${payable.total_allowance ?? 00}",
          ),
          paybaleTitleRate(
            title: (shift.shift_detail?.shift_type == 2 &&
                    shift.shift_detail?.same_or_different_time == 1)
                ? StringConstant.shiftFinderServiceFee
                : StringConstant.totalShiftFinderServiceFee,
            value: "\$${double.parse(payable.service_fee ?? "00.00")}",
          ),
          SizedBox(height: getSize(10)),
          if (shift.shift_detail?.shift_type == 2 &&
              shift.shift_detail?.same_or_different_time == 1) ...[
            paybaleTitleRate(
              title: StringConstant.totalPayableForOneShift,
              value: "\$${payable.total_one_shift ?? 00}",
              isFirst: true,
            ),
            paybaleTitleRate(
              title: StringConstant.numberOfShifts,
              value:
                  "${(payable.number_of_shift.toString().length == 2) ? payable.number_of_shift : "0${payable.number_of_shift}"}",
              isFirst: true,
            ),
          ],
          paybaleTitleRate(
            title: StringConstant.numberOfVacancies,
            value:
                "${(payable.number_of_vacancie.toString().length == 2) ? payable.number_of_vacancie : "0${payable.number_of_vacancie}"}",
            isFirst: true,
          ),
          commonDivider(),
          paybaleTitleRate(
            title: StringConstant.estimatedTotalPayable,
            value: "\$${payable.total_amount_payable ?? 00}",
            isLast: true,
          ),
          /* paybaleTitleRate(
            title: StringConstant.totalNumberOfVacancy,
            value:
                "${(payable.number_of_vacancie.toString().length == 2) ? payable.number_of_vacancie : "0${payable.number_of_vacancie}"}",
            isFirst: true,
          ),
          commonDivider(),
          paybaleTitleRate(
            title: "${StringConstant.estimatedWage}:-",
            value: "\$${payable.total_wage ?? 00}",
          ),
          paybaleTitleRate(
            title: "${StringConstant.accommodationAllowance}:-",
            value: "\$${payable.accommodation_allowance ?? 00}",
          ),
          paybaleTitleRate(
            title: "${StringConstant.commuteAllowance}:-",
            value: "\$${payable.commute_allowance ?? 00}",
          ),
          if (route != ShiftDetailRoute.employerCancelledShift)
            paybaleTitleRate(
              title: "${StringConstant.shiftFinderServiceFee}:-",
              value: "\$${payable.service_fee ?? 00}",
            ),
          commonDivider(),
          paybaleTitleRate(
            title: StringConstant.estimatedTotalPayable,
            value: "\$${payable.total_amount_payable ?? 00}",
            isLast: true,
          ), */
        ],
      ),
    );
  }

  Widget commonDivider() {
    return Divider(
      color: AppColors.black.withOpacity(0.2),
      thickness: getSize(0.5),
    );
  }

  Widget recurrence(HealthcarePostDTO post) {
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
                    ? DateFormat("d MMM, yyyy").format(
                        DateTime.fromMillisecondsSinceEpoch(
                            (post.shift_detail?.recurring_start_date ?? -1) *
                                1000))
                    : "",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primaryColor,
              ),
              BaseText(
                text: "  to  ",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withOpacity(0.7),
              ),
              BaseText(
                text: (post.shift_detail?.recurring_end_date != null)
                    ? DateFormat("d MMM, yyyy").format(
                        DateTime.fromMillisecondsSinceEpoch(
                            (post.shift_detail?.recurring_end_date ?? -1) *
                                1000))
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
              // chipList: post.shift_detail!.days!.split(',')
              //   .where((item) => item != )
              //   .map((item) => item.name ?? "")
              //   .toList(),
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
                  ? "Weekly"
                  : "Daily",
            ),
        ],
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
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
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
              textColor: AppColors.black.withOpacity(0.7),
            ),
            commonDivider(),
            BaseText(
              text: value,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              lineHeight: getSize(1),
              textColor: AppColors.black.withOpacity(0.9),
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

  Widget rateHoursBox(HealthcarePostDTO post) {
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

  Widget userDataBox(BuildContext context, HealthcarePostDTO post) {
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
            trailing: BaseText(
              text: post.last_ago ?? "",
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
                height: getSize(25),
                width: getSize(25),
              ),
              SizedBox(
                width: getSize(10),
              ),
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
        ],
      ),
    );
  }

  Widget singleShiftDateTimeBreakUI(
      BuildContext context, HealthcarePostDTO post) {
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
                post,
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
              displayDateBreak(context, post,
                  boldValue: post.shift_detail?.unpaid_break?.short_name ?? "",
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
              color: AppColors.primaryColor.withOpacity(0.15),
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
        return DateFormat('dd MMMM, yyyy').format(dateTime);
      }
    }
  }

  Widget multiShiftDateTimeBreakUI(
      BuildContext context, HealthcarePostDTO post) {
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
                post,
                boldValue: "",
                timidValue: "",
                showBtn: true,
                title: StringConstant.shiftDates,
                svgPrefixIcon: SvgImageConstant.calendar,
              ),
              (post.shift_detail?.shift_type == 2 &&
                      post.shift_detail?.same_or_different_time == 2)
                  ? displayDateBreak(context, post,
                      boldValue: (post.shift_detail?.detail != null &&
                              post.shift_detail!.detail!.isNotEmpty)
                          ? "${(post.shift_detail?.detail?.length.toString().length == 2) ? post.shift_detail?.detail?.length : "0${post.shift_detail?.detail?.length}"} Shifts"
                          : "00 Shift",
                      timidValue: "",
                      title: StringConstant.totalShifts,
                      svgPrefixIcon: SvgImageConstant.clock)
                  : displayDateBreak(context, post,
                      boldValue:
                          post.shift_detail?.unpaid_break?.short_name ?? "",
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
              color: AppColors.primaryColor.withOpacity(0.15),
            ),
          ),
        ],
      ),
    );
  }

  Widget displayDateBreak(
    BuildContext context,
    HealthcarePostDTO post, {
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
                textColor: AppColors.black.withOpacity(0.7),
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
                textColor: AppColors.black.withOpacity(0.7),
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
                    textColor: AppColors.black.withOpacity(0.7),
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
        TextSpan(text: thirdValue ?? ""),
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
              textColor: AppColors.black.withOpacity(0.7),
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
            color: AppColors.primaryColor.withOpacity(0.2),
          ),
        )
      ],
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
              textColor: AppColors.black.withOpacity(0.7),
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
              textColor: AppColors.black.withOpacity(0.9),
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
                textColor: AppColors.black.withOpacity(0.9),
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
          textColor: AppColors.black.withOpacity(0.7),
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
                color: AppColors.black.withOpacity(0.5),
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

  String languageList(HealthcarePostDTO post) {
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
