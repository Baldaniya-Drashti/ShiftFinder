import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/location_dto/location_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_shift/employer_shift_dto.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';

class ApproveShiftView extends StatelessWidget {
  const ApproveShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftsBloc, ShiftsBlocState>(
      builder: (context, state) {
        return state.approveLoading
            ? CenterLoadingIndicator(isOnlyLoader: true)
            : state.approveErrorApi
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
                        Expanded(
                          child: PaginatedListView(
                            onRefresh: () => context.read<ShiftsBloc>().add(
                                ShiftsBlocEvent.fetchApprovedShiftList(
                                    refresh: true)),
                            onLoading: () => context.read<ShiftsBloc>().add(
                                ShiftsBlocEvent.fetchApprovedShiftList(
                                    refresh: false)),
                            refreshController: context
                                .read<ShiftsBloc>()
                                .approveRefreshController,
                            child: ListView.builder(
                              itemCount: state.approveShiftList.length,
                              shrinkWrap: true,
                              padding:
                                  EdgeInsets.symmetric(vertical: getSize(20)),
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: getSize(
                                          index == 0 || index == 9 ? 0 : 12.5)),
                                  padding: EdgeInsets.all(getSize(10)),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius:
                                        BorderRadius.circular(getSize(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            AppColors.black.withOpacity(0.15),
                                        blurRadius: 10,
                                        offset: Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      userDetail(context,
                                          state.approveShiftList[index]),
                                      paddingBetweenFields(),
                                      remainingTime(context,
                                          state.approveShiftList[index]),
                                      paddingBetweenFields(),
                                      dateAndTime(context,
                                          state.approveShiftList[index]),
                                      paddingBetweenFields(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: getSize(10),
                                          horizontal: getSize(15),
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.scaffoldColor,
                                          borderRadius: BorderRadius.circular(
                                              getSize(10)),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            context.router.push(PageRouteInfo(
                                                ApprovedHiredList.name,
                                                args: ApprovedHiredListArgs(
                                                    postId: state
                                                            .approveShiftList[
                                                                index]
                                                            .id ??
                                                        -1)));
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColors.transparent,
                                                radius: getSize(20),
                                                child: SvgPicture.asset(
                                                  SvgImageConstant
                                                      .threePersonCircle,
                                                ),
                                              ),
                                              SizedBox(width: getSize(10)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  BaseText(
                                                    text:
                                                        "${StringConstant.allHiredContractors} (${state.approveShiftList[index].hired_user}/${state.approveShiftList[index].total_user})",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  BaseText(
                                                    text: StringConstant
                                                        .approveShiftsForContractors,
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: getSize(16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
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
                .add(ShiftsBlocEvent.onApproveSorting(value ?? LocationDTO()));
          }
        },
        hintText: StringConstant.location,
        value: (state.currentApproveFilter.location != null &&
                state.currentApproveFilter.location!.isNotEmpty)
            ? state.currentApproveFilter
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

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
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
                    )
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

  Widget remainingTime(BuildContext context, EmployerShiftDto shift) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getSize(10),
        horizontal: getSize(15),
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Row(
        children: [
          BaseText(
            text: StringConstant.remainingShifts,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          Spacer(),
          BaseText(
            text: (shift.remaining_shift != null && shift.remaining_shift! > 9)
                ? "${shift.remaining_shift ?? 0}"
                : "0${shift.remaining_shift ?? 0}",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget dateAndTime(BuildContext context, EmployerShiftDto shift) {
    return Column(
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
                    boldValue:
                        "${shift.total_shifts ?? 0} ${((shift.total_shifts ?? 0) > 1) ? "Shifts" : "Shift"}",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayDateBreak(
              context,
              boldValue: "\$${shift.estimated_payables ?? ""}",
              timidValue: "",
              title: StringConstant.estimatedPayables,
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

  Widget displayDateBreak(
    BuildContext context, {
    required String title,
    required String boldValue,
    required String timidValue,
    required String svgPrefixIcon,
    bool showBtn = false,
    void Function()? onBtnPressed,
    Color? valueColor,
  }) {
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
              buttonText: StringConstant.viewShiftDetails,
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
                    highLightText(
                        boldValue: boldValue,
                        timidValue: timidValue,
                        valueColor: valueColor),
                  ],
                ),
              ],
            ),
    );
  }

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue,
      Color? valueColor}) {
    return RichText(
        text: TextSpan(
      text: boldValue,
      style: TextStyle(
        fontSize: getFontSize(13),
        fontWeight: FontWeight.w500,
        color: valueColor ?? AppColors.black,
      ),
      children: [
        TextSpan(
          text: timidValue,
          style: TextStyle(
            fontSize: getFontSize(13),
            fontWeight: FontWeight.w500,
            color: valueColor ?? AppColors.black.withOpacity(0.5),
          ),
        ),
        TextSpan(
          text: thirdValue ?? "",
        ),
      ],
    ));
  }
}
