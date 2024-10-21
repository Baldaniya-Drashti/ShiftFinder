import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

class EditClockTimeDialog extends StatelessWidget {
  const EditClockTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  editClockTimeDialog(
      BuildContext context, HiredContractorListDTO contractor) async {
    final result = await showDialog<bool?>(
      context: context,
      builder: (_) => BlocProvider(
        create: (context) => getIt<HiredContractorBloc>(),
        child: BlocBuilder<HiredContractorBloc, HiredContractorState>(
          bloc: context.read<HiredContractorBloc>()
            ..state.copyWith(
              clockIn: contractor.clock_in_time ?? -1,
              clockOut: contractor.clock_out_time ?? -1,
            ),
          builder: (context, state) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.none,
              elevation: 0,
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.symmetric(horizontal: getSize(17)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(getSize(15)),
              ),
              content: Padding(
                padding: EdgeInsets.symmetric(horizontal: getSize(25)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: getSize(30),
                    ),
                    BaseText(
                      text: StringConstant.editClockTime,
                      fontSize: 22,
                      fontFamily: 'Aclonica',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getSize(10)),
                    BaseText(
                      text: StringConstant.editClockDesc,
                      fontSize: 14,
                      showFullDescription: true,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black.withOpacity(0.7),
                    ),
                    SizedBox(height: getSize(18)),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                        ),
                        children: [
                          WidgetSpan(
                            child: SvgPicture.asset(
                              SvgImageConstant.calendar,
                              height: getSize(15),
                              width: getSize(15),
                              colorFilter: ColorFilter.mode(
                                AppColors.black,
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: '${StringConstant.shiftDate} - ',
                            style: TextStyle(
                              fontSize: getFontSize(12),
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.7),
                            ),
                          ),
                          TextSpan(
                            text: DateFormat('d MMM, yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch(-1 * 1000)),
                            style: TextStyle(
                              fontSize: getFontSize(12),
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getSize(20)),
                    BaseText(
                      text: StringConstant.clockIn,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: getSize(8)),
                    commonClockInOutMethod(
                      onTap: () async {
                        final clockInTime = await showTimePicker(
                          context,
                        );

                        if (clockInTime != null) {
                          context.read<HiredContractorBloc>().add(
                              HiredContractorEvent.changeClockInClockOutTime(
                                  clockInTime, true));
                        }
                      },
                      // clockInOrOutTime: formatTimeOfDay(state.clockIn),
                      clockInOrOutTime: (state.clockIn != null)
                          ? DateFormat('hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  (state.clockIn ?? -1) * 1000))
                          : (contractor.clock_in_time != null)
                              ? DateFormat('hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      (contractor.clock_in_time ?? -1) * 1000))
                              : StringConstant.clockOut,
                    ),
                    SizedBox(height: getSize(20)),
                    BaseText(
                      text: StringConstant.clockOut,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: getSize(8),
                    ),
                    commonClockInOutMethod(
                      onTap: () async {
                        final clockOutTime = await showTimePicker(
                          context,
                        );
                        if (clockOutTime != null) {
                          context.read<HiredContractorBloc>().add(
                              HiredContractorEvent.changeClockInClockOutTime(
                                  clockOutTime, false));
                        }
                      },
                      // clockInOrOutTime: formatTimeOfDay(state.clockOut),
                      clockInOrOutTime:
                          // ? DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.clock_out_time ?? -1) * 1000))
                          (state.clockOut != null)
                              ? DateFormat('hh:mm a').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      (state.clockOut ?? -1) * 1000))
                              : (contractor.clock_out_time != null)
                                  ? DateFormat('hh:mm a').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          (contractor.clock_out_time ?? -1) *
                                              1000))
                                  : StringConstant.clockOut,
                    ),
                    SizedBox(
                      height: getSize(30),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            backgroundColor: AppColors.white,
                            borderColor: AppColors.green,
                            buttonTextColor: AppColors.green,
                            onPressed: () {
                              context.router.maybePop();
                            },
                            buttonText: StringConstant.cancle,
                          ),
                        ),
                        SizedBox(
                          width: getSize(25),
                        ),
                        Expanded(
                          child: CommonButton(
                            onPressed: () async {
                              context.router.maybePop(true);
                            },
                            buttonText: StringConstant.approve,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getSize(25)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );

    if (result ?? false) {
      AcceptRejectDialog(
        title: StringConstant.approve,
        description:
            "${StringConstant.approveShiftDesc1}${contractor.first_name ?? ""}${StringConstant.approveShiftDesc2}",
        onPressedAccept: () async {
          await context.router.maybePop();
          final result = await showDialog<bool?>(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(24).copyWith(top: 0),
                clipBehavior: Clip.none,
                insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(getSize(15)),
                ),
                titlePadding: EdgeInsets.zero,
                title: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(15)),
                          child: Image.asset(
                              PngImageConstants.curvedBackgroundImage),
                        ),
                        Positioned(
                          top: getSize(85),
                          child: SvgPicture.asset(
                            SvgImageConstant.approved,
                            height: getSize(107),
                            width: getSize(107),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(80),
                    ),
                    BaseText(
                      text: "Approved!",
                      fontSize: 22,
                      fontFamily: 'Aclonica',
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: getSize(10),
                    ),
                    BaseText(
                      text:
                          "The clock in and out times for this shift have been successfully approved.",
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black.withOpacity(0.7),
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  CommonButton(
                    height: 46,
                    width: 200,
                    onPressed: () {
                      context.router.maybePop(true);
                    },
                    buttonText: "Ok",
                  ),
                ],
              );
            },
          );
          if (result ?? true) {
            context.router.push(PageRouteInfo(ShiftActionsView.name));
          }
        },
        acceptButtonText: 'Approve',
        onPressedReject: () async {
          await context.router.maybePop();
        },
      ).acceptRejectDialog(context);
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  /*Future<TimeOfDay?> selectTime(
      BuildContext context, 
      TimeOfDay selectedTime
      ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      // initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              secondary: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      return pickedTime;
    }
    return null;
  }*/

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

  commonClockInOutMethod({
    required Function() onTap,
    required String clockInOrOutTime,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(14),
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(getSize(10)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              SvgImageConstant.clock,
              height: getSize(20),
              width: getSize(20),
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcATop,
              ),
            ),
            SizedBox(
              width: getSize(10),
            ),
            BaseText(
              text: clockInOrOutTime,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
