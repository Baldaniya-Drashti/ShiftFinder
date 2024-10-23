// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_home_bloc/contractor_home_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

@RoutePage(name: 'ContractorHomeView')
class ContractorHomeView extends StatelessWidget {
  const ContractorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorHomeBloc, ContractorHomeState>(
      builder: (context, state) {
        // return getCheckoutContainer(context);
        return PaginatedListView(
          onRefresh: () {
            context
                .read<ContractorHomeBloc>()
                .add(ContractorHomeEvent.getContractorDashboardList(true));
          },
          refreshController:
              context.read<ContractorHomeBloc>().refreshController,
          onLoading: () {
            context
                .read<ContractorHomeBloc>()
                .add(ContractorHomeEvent.getContractorDashboardList(false));
          },
          isNoDataFound: state.isNoDataFound,
          child: state.isLoading
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : state.isErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong),
                    )
                  : ListView.builder(
                      itemCount: state.contractorDashboardList.length,
                      padding: EdgeInsets.symmetric(
                        horizontal: getSize(15),
                        vertical: getSize(5),
                      ),
                      clipBehavior: Clip.none,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        return getCheckoutContainer(index, context, state);
                      },
                    ),
        );
      },
    );
  }

  getCheckoutContainer(
    int index,
    BuildContext context,
    ContractorHomeState state,
  ) {
    return Container(
      padding: EdgeInsets.all(getSize(10)),
      margin: EdgeInsets.symmetric(vertical: getSize(12)),
      width: getSize(355),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 25,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          contractorDataBox(context, index),
          SizedBox(
            height: getSize(8),
          ),
          CommonButton(
            onPressed: () {
              context.router.push(
                PageRouteInfo(
                  ViewContractorShift.name,
                  args: ViewContractorShiftArgs(
                    postId: state.contractorDashboardList[index].id ?? -1,
                    isTotalApplicants: true,
                    fromDashboard: true,
                  ),
                ),
              );
            },
            height: getSize(40),
            borderRadius: 7,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            buttonTextColor: AppColors.black,
            buttonFontSize: 12,
            buttonText: StringConstant.viewShiftDetails,
          ),
          (state.contractorDashboardList[index].shift_type == 1)
              ? singleShiftDateTimeBreakUI(context, index, state)
              : multiShiftDateTimeBreakUI(context, index, state),
          requiredSkillBox(
            svgPrefixIcon: SvgImageConstant.female,
            title: StringConstant.specialtiesRequired,
            value: state.contractorDashboardList[index].specialties_list ?? "",
          ),
          rateHoursBox(state.contractorDashboardList[index]),
          payableBox(state.contractorDashboardList[index]),
          SizedBox(height: getSize(20)),
          Row(
            children: [
              appliedProposalBtn(
                btnTitle: StringConstant.apply,
                onPressed: () {
                  AppDialog.showDelete(
                    context,
                    infoMessage:
                        StringConstant.areYouSureYouWantToApplyForTheShift,
                    title: StringConstant.apply,
                    deleteBtnText: StringConstant.apply,
                    onCancelClick: () {
                      context.router.maybePop();
                    },
                    onDeleteClick: () {
                      // context.router.maybePop();
                      context.read<ContractorHomeBloc>().add(
                          ContractorHomeEvent.applyShiftSubmittedEvent(
                              state.contractorDashboardList[index].id,
                              context));
                    },
                  );
                },
              ),
              SizedBox(width: getSize(10)),
              appliedProposalBtn(
                btnTitle: StringConstant.sendProposal,
                bgColor: AppColors.white,
                borderColor: AppColors.primaryColor,
                onPressed: () {
                  context.router
                      .push(PageRouteInfo(SendProposal.name,
                          args: SendProposalArgs(
                              postId: state.contractorDashboardList[index].id ??
                                  -1)))
                      .then((value) {
                    if (value == true) {
                      context.read<ContractorHomeBloc>().add(
                          ContractorHomeEvent.getContractorDashboardList(true));
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  appliedProposalBtn(
      {required void Function() onPressed,
      required String btnTitle,
      Color? borderColor,
      Color? bgColor}) {
    return Expanded(
      child: CommonButton(
        height: 40,
        onPressed: onPressed,
        buttonText: btnTitle,
        borderRadius: 10,
        buttonFontSize: 14,
        borderColor: borderColor,
        buttonTextColor: borderColor,
        backgroundColor: bgColor,
      ),
    );
  }

  Widget contractorDataBox(BuildContext context, int index) {
    return BlocBuilder<ContractorHomeBloc, ContractorHomeState>(
      builder: (context, state) {
        return Container(
          // height: getSize(113.41),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(10)),
            color: AppColors.scaffoldColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: getSize(12)),
          child: Column(
            children: [
              ListTile(
                dense: true,
                leading: Container(
                  height: getSize(40),
                  width: getSize(40),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                    PngImageConstants.leafWithBG,
                  ))),
                ),
                // leading: SvgPicture.asset(
                //   SvgImageConstant.leafWithBG,
                //   width: getSize(36.28),
                //   height: getSize(43.41),
                //   color: AppColors.primaryColor,
                // ),
                isThreeLine: true,
                title: BaseText(
                  text: state.contractorDashboardList[index].roles_list_name ??
                      "",
                  textColor: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BaseText(
                      text: state.contractorDashboardList[index].company_name ??
                          "",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.black.withOpacity(0.80),
                    ),
                    BaseText(
                      text:
                          "(${getIndustryText(state.contractorDashboardList[index].industry ?? 0)} - ${state.contractorDashboardList[index].listing_id ?? ""})",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.black.withOpacity(0.80),
                    ),
                  ],
                ),
                trailing: BaseText(
                  text: state.contractorDashboardList[index].last_ago ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                minTileHeight: getSize(43.41),
              ),
              Divider(
                color: AppColors.black.withOpacity(0.2),
                thickness: getSize(0.5),
              ),
              GestureDetector(
                onTap: () {
                  /*context.router.push(
                    PageRouteInfo(
                      ShowGoogleMap.name,
                      args: ShowGoogleMapArgs(
                        latitude: 21.191535534205194,
                        longitude: 72.78582206137469,
                      ),
                    ),
                  );*/
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      SvgImageConstant.location,
                      height: getSize(25),
                      width: getSize(25),
                      color: AppColors.black,
                    ),
                    SizedBox(
                      width: getSize(10),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: state.contractorDashboardList[index].location
                                    ?.location ??
                                "",
                            fontSize: 12,
                            maxLines: 1,
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.black,
                          ),
                          BaseText(
                            text:
                                state.contractorDashboardList[index].distance ??
                                    "",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(12),
              ),
            ],
          ),
        );
      },
    );
  }

  String getIndustryText(int type) {
    switch (type) {
      case 1:
        return "Healthcare";
      case 2:
        return "Pharmacy";
      case 3:
        return "Dental";
      case 4:
        return "Hospitality";
      case 5:
        return "Ophthalmology";
      default:
    }
    return "";
  }

  Widget verticalLabelValue({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: label,
          fontSize: 9,
          fontWeight: FontWeight.w400,
        ),
        BaseText(
          text: value,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      color: AppColors.black.withOpacity(0.56),
      indent: getSize(2),
      endIndent: getSize(2),
    );
  }

  Widget singleShiftDateTimeBreakUI(
      BuildContext context, int index, ContractorHomeState state) {
    final list = state.contractorDashboardList[index];
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
                list,
                boldValue: convertTimeStampToDate(list.start_date ?? -1),
                timidValue:
                    convertTimeStampToDate(list.start_date ?? -1, isYear: true),
                title: StringConstant.shiftDate,
                svgPrefixIcon: SvgImageConstant.calendar,
              ),
              displayTime(
                title: StringConstant.time,
                startDate:
                    convertTimeStampToDate(list.start_time ?? -1, isTime: true),
                endDate:
                    convertTimeStampToDate(list.end_time ?? -1, isTime: true),
                svgPrefixIcon: SvgImageConstant.clock,
              ),
              displayDateBreak(context, list,
                  boldValue: list.unpaid_break?.short_name ?? "",
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
        return DateFormat('d MMM, ').format(dateTime);
      }
    }
  }

  Widget multiShiftDateTimeBreakUI(
      BuildContext context, int index, ContractorHomeState state) {
    final list = state.contractorDashboardList[index];

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
                list,
                boldValue: "",
                timidValue: "",
                showBtn: true,
                title: StringConstant.shiftDates,
                svgPrefixIcon: SvgImageConstant.calendar,
              ),
              (list.shift_type == 2 && list.same_or_different_time == 2)
                  ? displayDateBreak(context, list,
                      boldValue: "${list.total_shift ?? -1}",
                      timidValue: "",
                      title: StringConstant.totalShifts,
                      svgPrefixIcon: SvgImageConstant.clock)
                  : displayDateBreak(context, list,
                      boldValue: list.unpaid_break?.short_name ?? "",
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

  Widget displayDateBreak(
    BuildContext context,
    ContactorDashboardDTO post, {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        if (post.shift_date != null) {
                          context.router.push(PageRouteInfo(
                              ViewContractorShiftDates.name,
                              args: ViewContractorShiftDatesArgs(
                                  shiftDetail: post)));
                        }
                      },
                      width: 100,
                      height: 27,
                      borderRadius: 5,
                      buttonFontSize: 12,
                      buttonFontWeight: FontWeight.w500,
                      buttonText: StringConstant.viewDates,
                    )
                  : highLightText(boldValue: boldValue, timidValue: timidValue),
            ],
          ),
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
            color: AppColors.primaryColor.withOpacity(0.5),
          ),
        ),
        TextSpan(
          text: thirdValue ?? "",
        ),
      ],
    ));
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
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: SvgPicture.asset(
                SvgImageConstant.greyVerticalLine,
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

  Widget rateHoursBox(ContactorDashboardDTO post) {
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
              value: (post.rate_hour != null) ? "\$${post.rate_hour}" : "\$0",
            ),
            Container(
              width: getSize(40),
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: SvgPicture.asset(SvgImageConstant.verticalLine),
            ),
            rateWithBGIcon(
              svgIcon: SvgImageConstant.clockWithOuterLine,
              title: StringConstant.totalHours,
              value: post.total_payable_hour ?? "",
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
        SizedBox(width: getSize(7)),
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

  Widget payableBox(ContactorDashboardDTO post) {
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
            value:
                "${(post.total_vacancy.toString().length == 2) ? post.total_vacancy : "0${post.total_vacancy}"}",
            isFirst: true,
          ),
          commonDivider(),
          paybaleTitleRate(
            title: "${StringConstant.accommodationAllowance}:-",
            value:
                "${((post.accommodation_allowance ?? 0) > 9) ? post.accommodation_allowance : "0${post.accommodation_allowance}"}",
          ),
          SizedBox(height: getSize(5)),
          paybaleTitleRate(
            title: "${StringConstant.commuteAllowance}:-",
            value:
                "${((post.commute_allowance ?? 0) > 9) ? post.commute_allowance : "0${post.commute_allowance}"}",
          ),
          commonDivider(),
          paybaleTitleRate(
            title: StringConstant.estimatedEarningsForShift,
            value: "\$${post.total_amount ?? 00}",
            isLast: true,
          ),
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
          fontSize: (isLast) ? 16 : 14,
          fontWeight: (isLast) ? FontWeight.w600 : FontWeight.w400,
          textColor: AppColors.black,
        ),
      ],
    );
  }
}
