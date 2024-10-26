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
import 'package:shift/infrastructure/contractor_main/shift/current_shift_dto/current_shift_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CurrentShift extends StatelessWidget {
  const CurrentShift({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
      builder: (context, state) {
        return PaginatedListView(
          onRefresh: () {
            context
                .read<ContractorShiftBloc>()
                .add(ContractorShiftEvent.getCurrentShiftDetailAPI(true));
          },
          refreshController:
              context.read<ContractorShiftBloc>().currentShiftRefreshCtrl,
          onLoading: () {
            context
                .read<ContractorShiftBloc>()
                .add(ContractorShiftEvent.getCurrentShiftDetailAPI(false));
          },
          isNoDataFound: state.isNoDataFound,
          child: state.isLoading
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : state.isErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong),
                    )
                  : ListView.builder(
                      itemCount: state.currentShiftList.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                      itemBuilder: (context, index) {
                        final shift = state.currentShiftList[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: getSize(12)),
                          padding: EdgeInsets.all(getSize(10)),
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
                            children: [
                              userDetail(context, shift),
                              paddingBetweenFields(),
                              numberOfVacancy(
                                  value:
                                      // "${shift.shift_detail?.number_of_vacancie ?? 0}"),
                                      "${((shift.remaining_shifts ?? 0) > 9) ? shift.remaining_shifts : "0${shift.remaining_shifts}"}"),
                              paddingBetweenFields(),
                              dateAndTime(context, shift),
                              clockIn(context, index, shift),
                              paddingBetweenFields(),
                              clockOut(context, index, shift),
                            ],
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget dateAndTime(BuildContext context, CurrentShiftDTO shift) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 10,
          child: SizedBox(
            height: getSize(120),
            child: Column(
              children: [
                displayDateBreak(
                  context,
                  // boldValue: "12 May,",
                  // timidValue: "2024",
                  boldValue:
                      convertTimeStampToDate(shift.shift_detail?.date ?? -1),
                  timidValue: convertTimeStampToDate(
                      shift.shift_detail?.date ?? -1,
                      isYear: true),
                  title: StringConstant.shiftDate,
                  svgPrefixIcon: SvgImageConstant.calendar,
                ),
                displayDateBreak(
                  context,
                  boldValue:
                      "\$${shift.shift_detail?.payables?.total_amount_payable ?? ""}",
                  timidValue: "",
                  title: StringConstant.estimatedPayables,
                  svgPrefixIcon: SvgImageConstant.dollorRound,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 13,
          child: SizedBox(
            height: getSize(120),
            child: Column(
              children: [
                displayTime(
                  title: StringConstant.time,
                  startDate: (shift.shift_detail?.start_time != null)
                      ? DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (shift.shift_detail?.start_time ?? 0) * 1000))
                      : "",
                  endDate: (shift.shift_detail?.end_time != null)
                      ? DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              (shift.shift_detail?.end_time ?? 0) * 1000))
                      : "",
                  svgPrefixIcon: SvgImageConstant.clock,
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
        ),
      ],
    );
    /*Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayDateBreak(
              context,
              // boldValue: "12 May,",
              // timidValue: "2024",
              boldValue: convertTimeStampToDate(shift.shift_detail?.date ?? -1),
              timidValue: convertTimeStampToDate(shift.shift_detail?.date ?? -1,
                  isYear: true),
              title: StringConstant.shiftDate,
              svgPrefixIcon: SvgImageConstant.calendar,
            ),
            displayTime(
              title: StringConstant.time,
              startDate: (shift.shift_detail?.start_time != null)
                  ? DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          (shift.shift_detail?.start_time ?? 0) * 1000))
                  : "",
              endDate: (shift.shift_detail?.end_time != null)
                  ? DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          (shift.shift_detail?.end_time ?? 0) * 1000))
                  : "",
              svgPrefixIcon: SvgImageConstant.clock,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            displayDateBreak(
              context,
              boldValue:
                  "\$${shift.shift_detail?.payables?.total_amount_payable ?? ""}",
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
      ],
    );*/
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

  Widget clockIn(BuildContext context, int index, CurrentShiftDTO shift) {
    bool isClockInValid = (shift.clock_in != null);
    return CustomTextField(
      labelText: StringConstant.clockIn,
      hintText: (isClockInValid)
          ? DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(
              (shift.clock_in ?? -1) * 1000))
          : (shift.selectedClockInTime != null)
              ? DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      (shift.selectedClockInTime ?? -1) * 1000))
              : StringConstant.clockIn,
      hintAsValue: isClockInValid,
      fillColor: AppColors.grey04,
      readOnly: true,
      onTap: (shift.clock_in != null)
          ? null
          : () async {
              final clockInTime = await showTimePicker(context);
              if (clockInTime != null) {
                context.read<ContractorShiftBloc>().add(
                    ContractorShiftEvent.setClockIn(context,
                        index: index, clockInTime: clockInTime));
              }
            },
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(16),
          vertical: getSize(16),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.clock,
          height: getSize(16),
          width: getSize(16),
          color: AppColors.primaryColor,
        ),
      ),
      suffixIcon: (shift.clock_in != null)
          ? BaseText(
              text: StringConstant.submitted,
              fontSize: 10,
              textColor: AppColors.primaryColor,
            )
          : CommonButton(
              onPressed: (shift.selectedClockInTime != null)
                  ? () {
                      submitTime(
                        context,
                        title: StringConstant.clockIn,
                        infoMessage: StringConstant.clockInConfirmationDesc,
                        onSubmit: () {
                          context.read<ContractorShiftBloc>().add(
                              ContractorShiftEvent.submitClockInOut(context,
                                  clockInOutTime:
                                      shift.selectedClockInTime ?? -1,
                                  postId: shift.post_id ?? -1));
                        },
                      );
                    }
                  : () {},
              borderRadius: 10,
              buttonFontSize: 10,
              height: 33,
              width: 73,
              backgroundColor: (shift.selectedClockInTime != null)
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(0.5),
              buttonText: StringConstant.submit,
            ),
    );
  }

  Widget clockOut(BuildContext context, int index, CurrentShiftDTO shift) {
    bool isClockOutValid = (shift.clock_out != null);
    return CustomTextField(
      labelText: StringConstant.clockOut,
      hintText: (isClockOutValid)
          ? DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(
              (shift.clock_out ?? -1) * 1000))
          : (shift.selectedClockOutTime != null)
              ? DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                      (shift.selectedClockOutTime ?? -1) * 1000))
              : StringConstant.clockOut,
      hintAsValue: isClockOutValid,
      fillColor: AppColors.grey04,
      readOnly: true,
      onTap: (shift.clock_out != null)
          ? null
          : (shift.clock_in != null)
              ? () async {
                  final clockOutTime = await showTimePicker(context);
                  if (clockOutTime != null) {
                    context.read<ContractorShiftBloc>().add(
                        ContractorShiftEvent.setClockOut(context,
                            index: index, clockOutTime: clockOutTime));
                  }
                }
              : null,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(16),
          vertical: getSize(16),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.clock,
          height: getSize(16),
          width: getSize(16),
          color: AppColors.primaryColor,
        ),
      ),
      suffixIcon: (shift.clock_out != null)
          ? BaseText(
              text: StringConstant.submitted,
              fontSize: 10,
              textColor: AppColors.primaryColor,
            )
          : CommonButton(
              onPressed: (shift.selectedClockOutTime != null)
                  ? () {
                      submitTime(
                        context,
                        title: StringConstant.clockOut,
                        infoMessage: StringConstant.clockOutConfirmationDesc,
                        onSubmit: () {
                          context.read<ContractorShiftBloc>().add(
                              ContractorShiftEvent.submitClockInOut(context,
                                  clockInOutTime:
                                      shift.selectedClockOutTime ?? -1,
                                  postId: shift.post_id ?? -1));
                        },
                      );
                    }
                  : () {},
              borderRadius: 10,
              buttonFontSize: 10,
              height: 33,
              width: 73,
              backgroundColor: (shift.selectedClockOutTime != null)
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(0.5),
              buttonText: StringConstant.submit,
            ),
    );
  }

  Future<TimeOfDay?> showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData.light().copyWith(
              timePickerTheme: TimePickerThemeData(
                dayPeriodColor: AppColors.primaryColor,
                dayPeriodTextColor: AppColors.black,
              ),
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onSurface: AppColors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(),
              ),
            ),
            child: TimePickerDialog(
              initialTime: TimeOfDay.fromDateTime(DateTime.now()),
            ),
          );
        });

    print("Selected Time:  ${pickedTime?.format(context)}");
    return pickedTime;
  }

  submitTime(BuildContext context,
      {required String title,
      required String infoMessage,
      required void Function()? onSubmit}) {
    AppDialog.showDelete(
      context,
      title: title,
      infoMessage: infoMessage,
      onCancelClick: () {
        context.router.maybePop();
      },
      cancelText: StringConstant.no,
      deleteBtnText: StringConstant.yes,
      onDeleteClick: onSubmit,
    );
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
              onPressed: onBtnPressed ??
                  () {
                    /*if (post.shift_detail != null) {
                          context.router.push(PageRouteInfo(ViewDates.name,
                              args: ViewDatesArgs(
                                  shiftDetail: post.shift_detail!)));
                        }*/
                  },
              // width: 160,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
                  BaseText(
                    text: ' to ',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
                  BaseText(
                    text: endDate,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
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

  Widget userDetail(BuildContext context, CurrentShiftDTO shift) {
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
              height: getSize(45),
              width: getSize(45),
            ),
            // isThreeLine: true,
            title: BaseText(
              text: shift.roles_list_name ?? "",
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
                  text: shift.company_name ?? "",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text:
                      "(${getIndustry(shift.industry_id ?? 0)}  - ${shift.listing_id ?? ''})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            trailing: GestureDetector(
              onTap: () {
                showUnderDevelopment(context);
              },
              child: SvgPicture.asset(
                SvgImageConstant.chatWithBG,
              ),
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
                        text: shift.location?.location ?? "",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: shift.distance ?? "",
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
          SizedBox(
            height: getSize(12),
          ),
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
            title: StringConstant.remainingShifts, value: value));
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
          textColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
