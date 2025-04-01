// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_previous_shift/contractor_previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_previus_shift_dto/contractor_previus_shift_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';

class ContractorCancelledShiftView extends StatelessWidget {
  const ContractorCancelledShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorPreviousShiftBloc,
        ContractorPreviousShiftState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(5)),
          child: Column(
            children: [
              sortingField(context, state),
              Expanded(
                child: state.cancelledDataListLoading
                    ? CenterLoadingIndicator(isOnlyLoader: true)
                    : state.cancelledDataIsErrorApi
                        ? Center(
                            child: BaseText(
                                text: StringConstant.somethindWentWrong))
                        : PaginatedListView(
                            onRefresh: () => context
                                .read<ContractorPreviousShiftBloc>()
                                .add(ContractorPreviousShiftEvent
                                    .getCancelledShift(
                                  isRefresh: true,
                                  sortBy: state.currentCancelFilter.id ?? 1,
                                )),
                            onLoading: () => context
                                .read<ContractorPreviousShiftBloc>()
                                .add(ContractorPreviousShiftEvent
                                    .getCancelledShift(
                                  isRefresh: false,
                                  sortBy: state.currentCancelFilter.id ?? 1,
                                )),
                            refreshController: context
                                .read<ContractorPreviousShiftBloc>()
                                .cancelledShiftController,
                            isNoDataFound: state.cancelledDataNoDataFound,
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getSize(10),
                                  vertical: getSize(20)),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  Gap(getSize(15)),
                              itemCount: state.cancelledDataList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(getSize(12)),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius:
                                        BorderRadius.circular(getSize(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.black
                                            .withValues(alpha: 0.2),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      userDetail(context,
                                          state.cancelledDataList[index]),
                                      dateAndTime(context, state,
                                          state.cancelledDataList[index]),
                                      /* Row(
                                        children: [
                                          Expanded(
                                            child: CommonInfoTile(
                                              leading: SvgPicture.asset(
                                                SvgImageConstant.calendar,
                                                height: 15,
                                                width: 15,
                                                colorFilter: ColorFilter.mode(
                                                    AppColors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.srcIn),
                                              ),
                                              title: BaseText(
                                                text: StringConstant.shiftDate,
                                                fontSize: getSize(10),
                                                textColor: AppColors.black
                                                    .withOpacity(0.6),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              subtitle: Text.rich(
                                                style: TextStyle(fontSize: 12),
                                                TextSpan(
                                                  text: "12 May, ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  children: [
                                                    TextSpan(
                                                        text: "2024",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.5))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: CommonInfoTile(
                                              key: ValueKey("time"),
                                              leading: SvgPicture.asset(
                                                SvgImageConstant.clock,
                                                height: 15,
                                                width: 15,
                                                colorFilter: ColorFilter.mode(
                                                    AppColors.black
                                                        .withOpacity(0.6),
                                                    BlendMode.srcIn),
                                              ),
                                              title: BaseText(
                                                text: "Time",
                                                fontSize: getSize(10),
                                                textColor: AppColors.black
                                                    .withOpacity(0.6),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              subtitle: BaseText(
                                                text: '09:15 AM to 07:30 PM',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                       */
                                      /* Gap(getSize(12)),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CommonInfoTile(
                                                leading: SvgPicture.asset(
                                                  SvgImageConstant.dollorRound,
                                                  height: 15,
                                                  width: 15,
                                                  colorFilter: ColorFilter.mode(
                                                      AppColors.black
                                                          .withOpacity(0.6),
                                                      BlendMode.srcIn),
                                                ),
                                                title: BaseText(
                                                  text: "Compassion",
                                                  fontSize: getSize(10),
                                                  textColor: AppColors.black
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                subtitle: BaseText(
                                                  text: '\$150',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: CommonButton(
                                                onPressed: () {},
                                                buttonText: StringConstant
                                                    .viewShiftDetails,
                                                backgroundColor:
                                                    AppColors.scaffoldColor,
                                                height: 40,
                                                buttonFontSize: 12,
                                                buttonTextColor:
                                                    AppColors.black,
                                                buttonFontWeight:
                                                    FontWeight.w600,
                                                borderRadius: 7,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(getSize(10)), */
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: getSize(10),
                                            top: getSize(10)),
                                        child: BaseText(
                                          text: StringConstant.reason,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Gap(getSize(6)),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.scaffoldColor,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(getSize(10)),
                                          child: BaseText(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            text: state.cancelledDataList[index]
                                                    .reason ??
                                                "",
                                          ),
                                        ),
                                      ),
                                      if (state.currentCancelFilter.id ==
                                          1) ...[
                                        Gap(getSize(10)),
                                        CommonButton(
                                          onPressed: () {
                                            context.router.push(
                                              PageRouteInfo(
                                                ViewContractorShift.name,
                                                args: ViewContractorShiftArgs(
                                                  postId: state
                                                          .cancelledDataList[
                                                              index]
                                                          .id ??
                                                      -1,
                                                  isTotalApplicants: true,
                                                ),
                                              ),
                                            );
                                          },
                                          buttonText:
                                              StringConstant.viewShiftDetails,
                                          backgroundColor:
                                              AppColors.scaffoldColor,
                                          buttonFontSize: 12,
                                          height: 43,
                                          buttonTextColor: AppColors.black,
                                          buttonFontWeight: FontWeight.w600,
                                          borderRadius: 7,
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget sortingField(
    BuildContext context,
    ContractorPreviousShiftState state,
  ) {
    return Padding(
      padding: EdgeInsets.only(
          top: getSize(25),
          bottom: getSize(10),
          left: getSize(10),
          right: getSize(10)),
      child: CustomDropdownField(
        label: StringConstant.sortBy,
        onChanged: (value) {
          if (value != null) {
            context.read<ContractorPreviousShiftBloc>().add(
                ContractorPreviousShiftEvent.onCancelTypeSorting(
                    value ?? SkillDTO()));
          }
        },
        hintText: StringConstant.location,
        value: state.currentCancelFilter,
        items: [
          SkillDTO(id: 1, name: StringConstant.withdrawnByYou),
          SkillDTO(id: 2, name: StringConstant.cancelledByEmployer),
        ].map((val) {
          return DropdownMenuItem<SkillDTO>(
            value: val,
            child: BaseText(
              text: val.name ?? "",
              fontSize: 14,
              textColor: AppColors.black,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget userDetail(
    BuildContext context,
    ContractorPreviousShiftDTO user,
  ) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == user.industry);
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
              text: user.roles_list_name ?? "",
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
                  text: user.company_name ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.80),
                ),
                BaseText(
                  text: "(${industry.title} - ${user.listing_id ?? ""})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withValues(alpha: 0.80),
                ),
                BaseText(
                  text: user.location?.facility_type?.name ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          Divider(
            color: AppColors.black.withValues(alpha: 0.2),
            thickness: getSize(0.5),
          ),
          GestureDetector(
            onTap: () {
              final location = user.location;
              final latitude = location?.latitude;
              final longitude = location?.longitude;
              if (latitude != null && longitude != null) {
                LocationHelper.openDirections(context,
                    endLat: latitude, endLng: longitude);
                /*  context.router.push(
                  PageRouteInfo(
                    ShowGoogleMap.name,
                    args: ShowGoogleMapArgs(
                      latitude: latitude,
                      longitude: longitude,
                    ),
                  ),
                ); */
              }
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
                        text: user.location?.location ?? "",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: user.distance ?? "",
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

  Widget dateAndTime(BuildContext context, ContractorPreviousShiftState state,
      ContractorPreviousShiftDTO shift) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (shift.shift_type == 1)
                    ? displayDateBreak(
                        context,
                        boldValue:
                            convertTimeStampToDate(shift.start_date ?? -1),
                        timidValue: convertTimeStampToDate(
                            shift.start_date ?? -1,
                            isYear: true),
                        title: StringConstant.shiftDate,
                        svgPrefixIcon: SvgImageConstant.calendar,
                      )
                    : displayDateBreak(
                        context,
                        boldValue:
                            "${shift.shift_date?.length ?? 0} ${((shift.shift_date?.length ?? 0) > 1) ? "Shifts" : "Shift"}",
                        timidValue: "",
                        title: StringConstant.totalShifts,
                        svgPrefixIcon: SvgImageConstant.calendar,
                      ),
                if (state.currentCancelFilter.id == 2)
                  displayDateBreak(
                    context,
                    boldValue: "\$${0.0}",
                    timidValue: "",
                    title: StringConstant.compassion,
                    svgPrefixIcon: SvgImageConstant.dollorRound,
                  ),
              ],
            ),
          ),
          Flexible(
            flex: 13,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                (shift.shift_type == 1)
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
                        boldValue:
                            convertTimeStampToDate(shift.start_date ?? -1),
                        timidValue: convertTimeStampToDate(
                          shift.start_date ?? -1,
                          isYear: true,
                        ),
                        title: StringConstant.shiftStartDate,
                        svgPrefixIcon: SvgImageConstant.calendar,
                      ),
                if (state.currentCancelFilter.id == 2)
                  displayDateBreak(
                    context,
                    boldValue: "",
                    timidValue: "",
                    title: "",
                    svgPrefixIcon: "",
                    showBtn: true,
                    onBtnPressed: () {
                      context.router.push(
                        PageRouteInfo(
                          ViewContractorShift.name,
                          args: ViewContractorShiftArgs(
                            postId: shift.id ?? -1,
                            isTotalApplicants: true,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
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
        mainAxisAlignment: MainAxisAlignment.end,
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
                children: [
                  BaseText(
                    text: startDate,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: ' to ',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: endDate,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
                  ),
                ],
              ),
            ],
          )
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

  Widget displayDateBreak(BuildContext context,
      {required String title,
      required String boldValue,
      required String timidValue,
      required String svgPrefixIcon,
      bool showBtn = false,
      void Function()? onBtnPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: (showBtn)
          ? CommonButton(
              onPressed: onBtnPressed ?? () {},
              // width: 160,
              height: 34,
              borderRadius: 5,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              buttonText: StringConstant.viewShiftDetails,
              buttonTextColor: AppColors.black,
              backgroundColor: AppColors.scaffoldColor,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
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
                        text: title,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.black.withValues(alpha: 0.7),
                      ),
                      highLightText(
                          boldValue: boldValue, timidValue: timidValue),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue}) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: boldValue,
          style: TextStyle(
            fontSize: getFontSize(13),
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          children: [
            TextSpan(
              text: timidValue,
              style: TextStyle(
                fontSize: getFontSize(13),
                fontWeight: FontWeight.w500,
                color: AppColors.black.withValues(alpha: 0.5),
              ),
            ),
            TextSpan(
              text: thirdValue ?? "",
            ),
          ],
        ));
  }
}
