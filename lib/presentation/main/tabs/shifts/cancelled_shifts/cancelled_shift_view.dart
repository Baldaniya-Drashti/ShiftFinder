import 'package:auto_route/auto_route.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_shift/employer_shift_dto.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/infrastructure/core/skill_list_model/skill_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/enum.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CancelledShiftView extends StatelessWidget {
  const CancelledShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        return state.cancelLoading
            ? CenterLoadingIndicator(isOnlyLoader: true)
            : state.cancelErrorApi
                ? Center(
                    child: BaseText(text: StringConstant.somethindWentWrong))
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getSize(18))
                              .copyWith(top: getSize(10)),
                          child: BaseText(
                            text: StringConstant.sortBy,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        sortingField(context, state),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: getSize(18))
                              .copyWith(),
                          child: BaseText(
                            text: StringConstant.sortBy,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        locationSortingField(context, state),
                        SizedBox(height: getSize(12)),
                        Expanded(
                          child: PaginatedListView(
                            onRefresh: () => context.read<ShiftsBloc>().add(
                                ShiftsBlocEvent.fetchCancelledShiftList(
                                    refresh: true)),
                            onLoading: () => context.read<ShiftsBloc>().add(
                                ShiftsBlocEvent.fetchCancelledShiftList(
                                    refresh: false)),
                            refreshController: context
                                .read<ShiftsBloc>()
                                .cancelledRefreshController,
                            isNoDataFound: state.noCancelDataFound,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: state.cancelledShiftList.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: getSize(12)),
                              itemBuilder: (context, index) => cancelShiftUI(
                                  context,
                                  state,
                                  state.cancelledShiftList[index]),
                            ),
                          ),
                        ),
                        /*if (state.currentCancelFilter.id == 1) ...[] else ...[
                          Expanded(
                            child: PaginatedListView(
                              onRefresh: () {},
                              onLoading: () {},
                              refreshController: RefreshController(),
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: 5,
                                separatorBuilder: (context, index) => SizedBox(
                                  height: getSize(12),
                                ),
                                itemBuilder: (context, index) =>
                                    _WithdrawnByContractorTile(),
                              ),
                            ),
                          )
                        ]*/
                      ],
                    ),
                  );
      },
    );
  }

  Widget sortingField(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: CustomDropdownField(
        onChanged: (value) {
          if (value != null) {
            context
                .read<ShiftsBloc>()
                .add(ShiftsBlocEvent.onCancelTypeSorting(value ?? SkillDTO()));
          }
        },
        hintText: StringConstant.location,
        value: state.currentCancelFilter,
        items: CommonList.cancelSortingList.map((val) {
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

  Widget locationSortingField(
    BuildContext context,
    ShiftsBlocState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: CustomDropdownField(
        onChanged: (value) {
          // if (value != null) {
          context.read<ShiftsBloc>().add(
              ShiftsBlocEvent.onCancelLocationSorting(value ?? LocationDTO()));
          // }
        },
        hintText: StringConstant.location,
        value: (state.currentCancelLocationFilter.location != null &&
                state.currentCancelLocationFilter.location!.isNotEmpty)
            ? state.currentCancelLocationFilter
            : null,
        items: state.locationList.map((val) {
          return DropdownMenuItem<LocationDTO>(
            value: val,
            child: BaseText(
              text: val.location ?? "",
              fontSize: 14,
              maxLines: 1,
              textColor: AppColors.black,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget cancelShiftUI(
      BuildContext context, ShiftsBlocState state, EmployerShiftDto shift) {
    return Container(
      padding: EdgeInsets.all(getSize(14)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(20)),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          userDetail(context, shift),
          SizedBox(height: getSize(12)),
          if (state.currentCancelFilter.id == 2)
            CommonButton(
              onPressed: () {
                context.router.push(
                  PageRouteInfo(
                    ViewHomeShiftDetails.name,
                    args: ViewHomeShiftDetailsArgs(
                      postId: shift.id ?? -1,
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
          dateAndTime(context, state, shift),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getSize(10),
              horizontal: getSize(15),
            ),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(getSize(10)),
            ),
            child: InkWell(
              onTap: () {
                context.router.push(PageRouteInfo(CancelledContractorList.name,
                    args: CancelledContractorListArgs(
                      title: (state.currentCancelFilter.id == 2)
                          ? StringConstant.withdralContractors
                          : StringConstant.cancelledContractors,
                      postId: shift.id ?? -1,
                    )));
              },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.transparent,
                    radius: getSize(20),
                    child: SvgPicture.asset(
                      SvgImageConstant.threePersonCircle,
                    ),
                  ),
                  SizedBox(width: getSize(10)),
                  BaseText(
                    text:
                        "${(state.currentCancelFilter.id == 2) ? StringConstant.withdralContractors : StringConstant.cancelledContractors} (${shift.total_user ?? 00}/2)",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: getSize(16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userDetail(BuildContext context, EmployerShiftDto shift) {
    final industry = CommonList.industryList
        .firstWhere((element) => element.id == shift.industry);
    return Container(
      padding: EdgeInsets.all(getSize(12)),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: getSize(25),
                backgroundColor: Colors.transparent,
                child: Image.asset(PngImageConstants.nurse2),
              ),
              SizedBox(width: getSize(15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: shift.roles_list_name ?? "",
                      fontSize: 16,
                      maxLines: 1,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: getSize(3)),
                    BaseText(
                      text:
                          '(${industry.title ?? ""} - ${shift.listing_id ?? ""})',
                      fontSize: 12,
                      textColor: AppColors.black.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getSize(10)),
          Divider(
            height: 0,
            color: AppColors.black.withOpacity(0.2),
            thickness: 0.5,
          ),
          SizedBox(height: getSize(10)),
          Row(
            children: [
              SvgPicture.asset(
                SvgImageConstant.location,
                colorFilter: ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcATop,
                ),
              ),
              SizedBox(width: getSize(5)),
              Expanded(
                child: BaseText(
                  text: shift.location?.location ?? "",
                  fontSize: 10,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dateAndTime(
      BuildContext context, ShiftsBlocState state, EmployerShiftDto shift) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (shift.shift_type == 1)
                ? displayDateBreak(
                    context,
                    boldValue: convertTimeStampToDate(shift.start_date ?? -1),
                    timidValue: convertTimeStampToDate(shift.start_date ?? -1,
                        isYear: true),
                    title: StringConstant.shiftDate,
                    svgPrefixIcon: SvgImageConstant.calendar,
                  )
                : displayDateBreak(
                    context,
                    boldValue: "${shift.shift_type ?? 0} Shifts",
                    timidValue: "",
                    title: StringConstant.totalShifts,
                    svgPrefixIcon: SvgImageConstant.calendar,
                  ),
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
                    boldValue: convertTimeStampToDate(shift.start_date ?? -1),
                    timidValue: convertTimeStampToDate(shift.start_date ?? -1,
                        isYear: true),
                    title: StringConstant.shiftStartDate,
                    svgPrefixIcon: SvgImageConstant.calendar,
                  )
          ],
        ),
        if (state.currentCancelFilter.id == 2) ...[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getSize(18), vertical: getSize(8)),
            child: BaseText(
              text: StringConstant.reason,
              fontSize: 12,
              textColor: AppColors.black.withOpacity(0.7),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getSize(12), vertical: getSize(10)),
            margin: EdgeInsets.only(bottom: getSize(15)),
            decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(getSize(10))),
            child: BaseText(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              fontSize: 12,
              textColor: AppColors.black,
            ),
          ),
        ] else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              displayDateBreak(
                context,
                boldValue: "\$${shift.estimated_payables ?? ""}",
                timidValue: "",
                title: StringConstant.compassion,
                svgPrefixIcon: SvgImageConstant.dollorRound,
              ),
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
                      ViewHomeShiftDetails.name,
                      args: ViewHomeShiftDetailsArgs(
                        postId: shift.id ?? -1,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ]
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

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue}) {
    return RichText(
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
