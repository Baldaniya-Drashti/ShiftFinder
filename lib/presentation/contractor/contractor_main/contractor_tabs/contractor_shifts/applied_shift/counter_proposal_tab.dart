import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class CounterProposalTab extends StatelessWidget {
  const CounterProposalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(5)),
          child: PaginatedListView(
            onRefresh: () {
              context
                  .read<ContractorShiftBloc>()
                  .add(ContractorShiftEvent.getCounterProposalList(true));
            },
            refreshController:
                context.read<ContractorShiftBloc>().counterShiftRefreshCtrl,
            onLoading: () {
              context
                  .read<ContractorShiftBloc>()
                  .add(ContractorShiftEvent.getCounterProposalList(false));
            },
            isNoDataFound: state.isCounterNoDataFound,
            child: state.isCounterLoading
                ? CenterLoadingIndicator(isOnlyLoader: true)
                : state.isCounterErrorInAPI
                    ? Center(
                        child:
                            BaseText(text: StringConstant.somethindWentWrong))
                    : ListView.builder(
                        itemCount: state.counterList.length,
                        padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                        itemBuilder: (context, index) {
                          final shift = state.counterList[index];
                          return Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.symmetric(vertical: getSize(10)),
                                padding: EdgeInsets.all(getSize(10)),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.circular(getSize(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          AppColors.lightGrey.withOpacity(0.2),
                                      blurRadius: getSize(20),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    userDetail(context, shift),
                                    paddingBetweenFields(),
                                    dateAndTime(
                                        context, state.counterList[index]),
                                    paddingBetweenFields(),
                                    CommonButton(
                                      onPressed: () {
                                        context.router.push(
                                          PageRouteInfo(
                                            ViewContractorShift.name,
                                            args: ViewContractorShiftArgs(
                                              postId: shift.id ?? -1,
                                            ),
                                          ),
                                        );
                                      },
                                      height: getSize(40),
                                      borderRadius: 7,
                                      backgroundColor: AppColors.primaryColor
                                          .withOpacity(0.1),
                                      buttonTextColor: AppColors.black,
                                      buttonFontSize: 12,
                                      buttonText:
                                          StringConstant.viewShiftDetails,
                                    ),
                                    paddingBetweenFields(),
                                    (shift.deleteAt == true)
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: getSize(10)),
                                            child: BaseText(
                                              text: StringConstant
                                                  .youHaveDeclinedThisShift,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : (shift.revoke_status == 3)
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: getSize(10),
                                                ),
                                                child: BaseText(
                                                  text: StringConstant
                                                      .offerRevokedByTheEmployer,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  context.router
                                                      .push(PageRouteInfo(
                                                          ProposalReceived.name,
                                                          args:
                                                              ProposalReceivedArgs(
                                                                  post: shift)))
                                                      .then((value) {
                                                    if (value == true) {
                                                      context
                                                          .read<
                                                              ContractorShiftBloc>()
                                                          .add(ContractorShiftEvent
                                                              .getCounterProposalList(
                                                                  true));
                                                    }
                                                  });
                                                },
                                                child: (shift.revoke_status ==
                                                        2)
                                                    ? revokingStatus(
                                                        context, shift)
                                                    : (shift.last_request == 2)
                                                        ? proposalStatus(
                                                            title: StringConstant
                                                                .proposalReceived,
                                                            icon: SvgImageConstant
                                                                .receivedCircle,
                                                            boldValue:
                                                                convertTimeStampToDate(
                                                                    shift.applied_date ??
                                                                        -1),
                                                            timidValue:
                                                                convertTimeStampToDate(
                                                                    shift.applied_date ??
                                                                        -1,
                                                                    isYear:
                                                                        true),
                                                          )
                                                        : (shift.last_request ==
                                                                3)
                                                            ? proposalStatus(
                                                                title: StringConstant
                                                                    .proposalAccepted,
                                                                icon: SvgImageConstant
                                                                    .rightWithCircle,
                                                                boldValue:
                                                                    convertTimeStampToDate(
                                                                        shift.applied_date ??
                                                                            -1),
                                                                timidValue:
                                                                    convertTimeStampToDate(
                                                                        shift.applied_date ??
                                                                            -1,
                                                                        isYear:
                                                                            true),
                                                              )
                                                            : proposalStatus(
                                                                title: StringConstant
                                                                    .proposalSent,
                                                                icon: SvgImageConstant
                                                                    .rightWithCircle,
                                                                boldValue:
                                                                    convertTimeStampToDate(
                                                                        shift.applied_date ??
                                                                            -1),
                                                                timidValue:
                                                                    convertTimeStampToDate(
                                                                        shift.applied_date ??
                                                                            -1,
                                                                        isYear:
                                                                            true),
                                                              ),
                                              ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
          ),
        );
      },
    );
  }

  Widget revokingStatus(BuildContext context, AppliedShiftDTO shift) {
    final hours =
        shift.remainingRevokeTime?.inHours.toString().padLeft(2, '0') ?? 00;
    final minutes = shift.remainingRevokeTime?.inMinutes
            .remainder(60)
            .toString()
            .padLeft(2, '0') ??
        00;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 10,
        onTap: null,
        title: Padding(
          padding: EdgeInsets.only(left: getSize(20)),
          child: BaseText(
            text: StringConstant.revoking,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            textColor: AppColors.black.withOpacity(0.7),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: getSize(108),
              padding: EdgeInsets.symmetric(vertical: getSize(5)),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    SvgImageConstant.clock,
                    height: getSize(15),
                    width: getSize(15),
                  ),
                  BaseText(
                    text: "$hours h $minutes min",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(width: getSize(10)),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: getSize(18),
              color: AppColors.black.withOpacity(0.5),
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

  Widget userDetail(BuildContext context, AppliedShiftDTO shift) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Image.asset(
              PngImageConstants.leafWithBG,
              height: getSize(40),
              width: getSize(40),
            ),
            isThreeLine: true,
            title: BaseText(
              text: shift.role_lists_name ?? " ",
              textColor: AppColors.black,
              fontSize: 16,
              maxLines: 1,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: shift.company_name ?? " ",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text:
                      "(${getIndustry(shift.industry_id ?? 0)} - ${shift.listing_id ?? ''})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            trailing: BaseText(
              text: shift.last_ago ?? " ",
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
                        text: shift.location ?? " ",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: shift.distance ?? " ",
                        fontSize: 10,
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getSize(12)),
        ],
      ),
    );
  }

  String getIndustry(int id) {
    OnBoardingDTO industry = CommonList.industryList.firstWhere(
      (item) => item.id == id,
      orElse: () => OnBoardingDTO(),
    );
    return industry.title ?? "";
  }

  Widget dateAndTime(BuildContext context, AppliedShiftDTO shift) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 10,
          child: (shift.shift_type == 1)
              ? displayDateBreak(
                  context,
                  boldValue: convertTimeStampToDate(shift.date ?? -1),
                  timidValue:
                      convertTimeStampToDate(shift.date ?? -1, isYear: true),
                  title: StringConstant.shiftDate,
                  svgPrefixIcon: SvgImageConstant.calendar,
                )
              : displayDateBreak(
                  context,
                  boldValue:
                      "${shift.total_shift ?? 0} ${((shift.total_shift ?? 0) > 1) ? "Shifts" : "Shift"}",
                  timidValue: "",
                  title: StringConstant.totalShifts,
                  svgPrefixIcon: SvgImageConstant.calendar,
                ),
        ),
        Flexible(
          flex: 13,
          child: (shift.shift_type == 1)
              ? displayTime(
                  title: StringConstant.time,
                  startDate: (shift.start_time != null)
                      ? DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (shift.start_time ?? 0) * 1000))
                      : "",
                  endDate: (shift.end_time != null)
                      ? DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (shift.end_time ?? 0) * 1000))
                      : "",
                  svgPrefixIcon: SvgImageConstant.clock,
                )
              : displayDateBreak(
                  context,
                  boldValue: convertTimeStampToDate(shift.date ?? -1),
                  timidValue: convertTimeStampToDate(
                    shift.date ?? -1,
                    isYear: true,
                  ),
                  title: StringConstant.shiftStartDate,
                  svgPrefixIcon: SvgImageConstant.calendar,
                ),
        ),
      ],
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
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text: StringConstant.time,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                highLightText(
                    boldValue: "$startDate to $endDate", timidValue: ""),
              ],
            ),
          )
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
    Widget? titleWidget,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: (showBtn)
          ? CommonButton(
              onPressed: () {
                /*if (post.shift_detail != null) {
                          context.router.push(PageRouteInfo(ViewDates.name,
                              args: ViewDatesArgs(
                                  shiftDetail: post.shift_detail!)));
                        }*/
              },
              width: 160,
              height: 34,
              borderRadius: 5,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              buttonText: StringConstant.viewDetails,
              buttonTextColor: AppColors.black,
              backgroundColor: AppColors.scaffoldColor,
            )
          : Row(
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
                    titleWidget ??
                        BaseText(
                          text: title,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                    highLightText(boldValue: boldValue, timidValue: timidValue),
                  ],
                ),
              ],
            ),
    );
  }

  Widget proposalStatus(
      {required String title,
      required String icon,
      required String boldValue,
      required String timidValue}) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(getSize(10)),
          color: AppColors.scaffoldColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: getSize(12)),
        child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: SvgPicture.asset(
              SvgImageConstant.calendar,
              color: AppColors.black.withOpacity(0.7),
              height: getSize(20),
              width: getSize(20),
            ),
            title: Row(
              children: [
                BaseText(
                  text: title,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.primaryColor,
                ),
                SizedBox(width: getSize(05)),
                SvgPicture.asset(
                  icon,
                  height: getSize(15),
                  width: getSize(15),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                highLightText(boldValue: boldValue, timidValue: timidValue),
                SizedBox(width: getSize(10)),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: getSize(18),
                  color: AppColors.black.withOpacity(0.5),
                ),
              ],
            )),
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
        color: AppColors.black,
      ),
      children: [
        TextSpan(
          text: timidValue,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.black.withOpacity(0.5),
          ),
        ),
        TextSpan(
          text: thirdValue ?? "",
        ),
      ],
    ));
  }
}
