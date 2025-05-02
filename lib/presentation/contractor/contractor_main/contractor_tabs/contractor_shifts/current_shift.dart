// ignore_for_file: deprecated_member_use

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
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/chat_button.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CurrentShift extends StatelessWidget {
  const CurrentShift({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorShiftBloc>()
        ..add(ContractorShiftEvent.getCurrentShiftDetailAPI(true)),
      child: BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
          builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(5)),
          child: PaginatedListView(
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
                        child:
                            BaseText(text: StringConstant.somethindWentWrong),
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
                                  color: AppColors.lightGrey
                                      .withValues(alpha: 0.2),
                                  blurRadius: getSize(20),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                userDetail(context, shift),
                                paddingBetweenFields(),
                                if (shift.shift_detail != null &&
                                    shift.shift_detail!.shift_type == 2) ...[
                                  remainingShift(
                                      value:
                                          "${((shift.remaining_shifts ?? 0) > 9) ? shift.remaining_shifts : "0${shift.remaining_shifts}"}"),
                                  paddingBetweenFields(),
                                ],
                                dateAndTime(context, shift),
                                paddingBetweenFields(),
                                clockIn(context, index, shift),
                                paddingBetweenFields(),
                                clockOut(context, index, shift),
                                if (shift.clock_in != null &&
                                    shift.clock_out != null) ...[
                                  paddingBetweenFields(),
                                  BaseText(
                                    text:
                                        StringConstant.awaitingEmployerApproval,
                                    textColor: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
          ),
        );
      }),
    );
  }
}

Widget paddingBetweenFields({double? height}) {
  return SizedBox(
    height: getSize(height ?? 10),
  );
}

Widget dateAndTime(BuildContext context, CurrentShiftDTO shift) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        flex: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* displayDateBreak(
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
              ), */
            (shift.shift_detail?.shift_type == 1)
                ? displayDateBreak(
                    context,
                    boldValue:
                        convertTimeStampToDate(shift.shift_detail?.date ?? -1),
                    timidValue: convertTimeStampToDate(
                        shift.shift_detail?.date ?? -1,
                        isYear: true),
                    title: StringConstant.shiftDate,
                    svgPrefixIcon: SvgImageConstant.calendar,
                  )
                : displayDateBreak(
                    context,
                    boldValue:
                        "${((shift.shift_detail?.payables?.number_of_shift ?? 0) > 9) ? shift.shift_detail?.payables?.number_of_shift : "0${shift.shift_detail?.payables?.number_of_shift}"} Shifts",
                    timidValue: "",
                    title: StringConstant.totalShifts,
                    svgPrefixIcon: SvgImageConstant.calendar,
                  ),
            displayDateBreak(
              context,
              boldValue:
                  "\$${shift.shift_detail?.payables?.total_amount_payable_contractor ?? ""}",
              timidValue: "",
              title: StringConstant.estimatedPayables,
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
            (shift.shift_detail?.shift_type == 1)
                ? displayTime(
                    title: StringConstant.time,
                    startDate: (shift.shift_detail?.start_time != null)
                        ? DateFormat('hh:mm a').format(
                            CustomDateTimeFormat.timeStampToDateTime(
                                (shift.shift_detail?.start_time ?? 0)))
                        : "",
                    endDate: (shift.shift_detail?.end_time != null)
                        ? DateFormat('hh:mm a').format(
                            CustomDateTimeFormat.timeStampToDateTime(
                                (shift.shift_detail?.end_time ?? 0)))
                        : "",
                    svgPrefixIcon: SvgImageConstant.clock,
                  )
                : displayDateBreak(
                    context,
                    boldValue:
                        convertTimeStampToDate(shift.shift_detail?.date ?? -1),
                    timidValue: convertTimeStampToDate(
                      shift.shift_detail?.date ?? -1,
                      isYear: true,
                    ),
                    title: StringConstant.shiftDate,
                    svgPrefixIcon: SvgImageConstant.calendar,
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
    ],
  );
}

String convertTimeStampToDate(int timestamp,
    {bool isYear = false, bool isTime = false}) {
  DateTime dateTime = CustomDateTimeFormat.timeStampToDateTime(timestamp);

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
        ? DateFormat('hh:mm a').format(
            CustomDateTimeFormat.timeStampToDateTime((shift.clock_in ?? -1)))
        : (shift.selectedClockInTime != null)
            ? DateFormat('hh:mm a').format(
                CustomDateTimeFormat.timeStampToDateTime(
                    (shift.selectedClockInTime ?? -1)))
            : StringConstant.clockIn,
    hintAsValue: isClockInValid,
    fillColor: AppColors.grey04,
    readOnly: true,
    onTap: (isClockInValid)
        ? null
        : () async {
            print("tttt-> ${shift.selectedClockInTime}");
            final now = DateTime.now();
            final clockInTime = await showTimePicker(
              context,
              initalTime: (shift.selectedClockInTime != null)
                  ? CustomDateTimeFormat.timeStampToDateTime(
                      (shift.selectedClockInTime)!)
                  : (shift.shift_detail?.start_time != null)
                      ? CustomDateTimeFormat.timeStampToDateTime(
                          (shift.shift_detail?.start_time)!)
                      : null,
            );
            if (clockInTime != null) {
              final selectedDateTime = DateTime(now.year, now.month, now.day,
                  clockInTime.hour, clockInTime.minute);

              if (selectedDateTime.isBefore(now)) {
                context.read<ContractorShiftBloc>().add(
                    ContractorShiftEvent.setClockIn(context,
                        index: index, clockInTime: clockInTime));
              } else {
                showError(message: StringConstant.pleaseSelectAValidTime)
                    .show(context);
              }
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
    suffixIcon: (isClockInValid)
        ? BaseText(
            text: StringConstant.submitted,
            fontSize: 10,
            textColor: AppColors.primaryColor,
          )
        : ElevatedButton(
            onPressed: (shift.selectedClockInTime != null)
                ? () {
                    submitTime(
                      context,
                      title: StringConstant.clockIn,
                      infoMessage: StringConstant.clockInConfirmationDesc,
                      onSubmit: () {
                        context.read<ContractorShiftBloc>().add(
                            ContractorShiftEvent.submitClockInOut(context,
                                clockInOutTime: shift.selectedClockInTime ?? -1,
                                postId: shift.post_id ?? -1));
                      },
                    );
                  }
                : null,
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getSize(10),
                ),
              )),
              fixedSize: WidgetStatePropertyAll(Size(
                getSize(73),
                getSize(33),
              )),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              visualDensity: VisualDensity(
                vertical: VisualDensity.minimumDensity,
                horizontal: VisualDensity.minimumDensity,
              ),
              backgroundColor: WidgetStatePropertyAll(
                (shift.selectedClockInTime != null)
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withValues(alpha: 0.5),
              ),
            ),
            child: BaseText(
              text: StringConstant.submit,
              fontSize: 10,
              textAlign: TextAlign.center,
              //maxLines: 1,
              fontWeight: FontWeight.w600,
              textColor: Colors.white,
            ),
          ),
    /* CommonButton(
            onPressed: (shift.selectedClockInTime != null)
                ? () {
                    submitTime(
                      context,
                      title: StringConstant.clockIn,
                      infoMessage: StringConstant.clockInConfirmationDesc,
                      onSubmit: () {
                        context.read<ContractorShiftBloc>().add(
                            ContractorShiftEvent.submitClockInOut(context,
                                clockInOutTime: shift.selectedClockInTime ?? -1,
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
                : AppColors.primaryColor.withValues(alpha: 0.5),
            buttonText: StringConstant.submit,
          ), */
  );
}

Widget clockOut(BuildContext context, int index, CurrentShiftDTO shift) {
  bool isClockOutValid = (shift.clock_out != null);
  return CustomTextField(
    labelText: StringConstant.clockOut,
    hintText: (isClockOutValid)
        ? DateFormat('hh:mm a').format(
            CustomDateTimeFormat.timeStampToDateTime((shift.clock_out ?? -1)))
        : (shift.selectedClockOutTime != null)
            ? DateFormat('hh:mm a').format(
                CustomDateTimeFormat.timeStampToDateTime(
                    (shift.selectedClockOutTime ?? -1)))
            : StringConstant.clockOut,
    hintAsValue: isClockOutValid,
    fillColor: AppColors.grey04,
    readOnly: true,
    onTap: (shift.clock_out != null)
        ? null
        : (shift.clock_in != null)
            ? () async {
                final now = DateTime.now();
                final clockInTime = CustomDateTimeFormat.timeStampToDateTime(
                    (shift.clock_in ?? -1));
                final clockOutTime = await showTimePicker(
                  context,
                  initalTime: (shift.selectedClockOutTime != null)
                      ? CustomDateTimeFormat.timeStampToDateTime(
                          (shift.selectedClockOutTime)!)
                      : null,
                );

                if (clockOutTime != null) {
                  final selectedDateTime = DateTime(now.year, now.month,
                      now.day, clockOutTime.hour, clockOutTime.minute);

                  if (
                      // selectedDateTime.isBefore(now) &&
                      selectedDateTime.isAfter(clockInTime)) {
                    context.read<ContractorShiftBloc>().add(
                        ContractorShiftEvent.setClockOut(context,
                            index: index, clockOutTime: clockOutTime));
                  } else {
                    showError(message: StringConstant.pleaseSelectAValidTime)
                        .show(context);
                  }
                }

                /* if (clockOutTime != null) {
                    context.read<ContractorShiftBloc>().add(
                        ContractorShiftEvent.setClockOut(context,
                            index: index, clockOutTime: clockOutTime));
                  } */
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
        : ElevatedButton(
            onPressed: (shift.selectedClockOutTime != null)
                ? () {
                    submitTime(
                      context,
                      title: StringConstant.clockOut,
                      infoMessage: StringConstant.clockOutConfirmationDesc,
                      onSubmit: () {
                        context
                            .read<ContractorShiftBloc>()
                            .add(ContractorShiftEvent.submitClockInOut(
                              context,
                              clockInOutTime: shift.selectedClockOutTime ?? -1,
                              postId: shift.post_id ?? -1,
                              isClockOut: true,
                            ));
                      },
                    );
                  }
                : null,
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  getSize(10),
                ),
              )),
              fixedSize: WidgetStatePropertyAll(Size(
                getSize(73),
                getSize(33),
              )),
              padding: WidgetStatePropertyAll(EdgeInsets.zero),
              visualDensity: VisualDensity(
                vertical: VisualDensity.minimumDensity,
                horizontal: VisualDensity.minimumDensity,
              ),
              backgroundColor: WidgetStatePropertyAll(
                (shift.selectedClockOutTime != null)
                    ? AppColors.primaryColor
                    : AppColors.primaryColor.withValues(alpha: 0.5),
              ),
            ),
            child: BaseText(
              text: StringConstant.submit,
              fontSize: 10,
              textAlign: TextAlign.center,
              //maxLines: 1,
              fontWeight: FontWeight.w600,
              textColor: Colors.white,
            )),
    /* CommonButton(
            onPressed: (shift.selectedClockOutTime != null)
                ? () {
                    submitTime(
                      context,
                      title: StringConstant.clockOut,
                      infoMessage: StringConstant.clockOutConfirmationDesc,
                      onSubmit: () {
                        context
                            .read<ContractorShiftBloc>()
                            .add(ContractorShiftEvent.submitClockInOut(
                              context,
                              clockInOutTime: shift.selectedClockOutTime ?? -1,
                              postId: shift.post_id ?? -1,
                              isClockOut: true,
                            ));
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
                : AppColors.primaryColor.withValues(alpha: 0.5),
            buttonText: StringConstant.submit,
          ), */
  );
}

Future<TimeOfDay?> showTimePicker(BuildContext context,
    {DateTime? initalTime}) async {
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
            initialTime: TimeOfDay.fromDateTime(initalTime ?? DateTime.now()),
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
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            Row(
              children: [
                BaseText(
                  text: startDate,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withValues(alpha: 0.7),
                ),
                BaseText(
                  text: ' to ',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withValues(alpha: 0.7),
                ),
                BaseText(
                  text: endDate,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withValues(alpha: 0.7),
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
          color: AppColors.black.withValues(alpha: 0.5),
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
          titleAlignment: ListTileTitleAlignment.top,
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
                textColor: AppColors.black.withValues(alpha: 0.80),
              ),
              BaseText(
                text:
                    "(${getIndustry(shift.industry_id ?? 0)} - ${shift.listing_id ?? ''})",
                fontSize: 10,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withValues(alpha: 0.80),
              ),
              BaseText(
                text: shift.location?.facility_type?.name ?? "",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          trailing: ChatButton(
            badgeCount: shift.count ?? 0,
            onPressed: () {
              context.router
                  .push(
                PageRouteInfo(
                  Message.name,
                  args: MessageArgs(
                    receiverId: shift.employer_user_id ?? 0,
                  ),
                ),
              )
                  .then((value) {
                if (shift.count != null && (shift.count ?? 0) > 0) {
                  context
                      .read<ContractorShiftBloc>()
                      .add(ContractorShiftEvent.getCurrentShiftDetailAPI(true));
                }
              });
            },
          ),
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          minTileHeight: getSize(43.41),
        ),
        Divider(
          color: AppColors.black.withValues(alpha: 0.2),
          thickness: getSize(0.5),
        ),
        GestureDetector(
          onTap: () {
            final location = shift.location;
            final latitude = location?.latitude;
            final longitude = location?.longitude;
            if (latitude != null && longitude != null) {
              LocationHelper.openDirections(context,
                  endLat: latitude, endLng: longitude);
              /* context.router.push(
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

Widget remainingShift({
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
