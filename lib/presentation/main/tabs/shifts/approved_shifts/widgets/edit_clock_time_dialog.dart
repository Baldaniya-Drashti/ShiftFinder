import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/shifts/shifts_bloc_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

class EditClockTimeDialog extends StatelessWidget {
  const EditClockTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  editClockTimeDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => getIt<ShiftsBloc>(),
        child: BlocBuilder<ShiftsBloc, ShiftsBlocState>(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getSize(30),
                    ),
                    BaseText(
                      text: 'Edit Clock Time',
                      fontSize: 22,
                      fontFamily: 'Aclonica',
                    ),
                    SizedBox(
                      height: getSize(10),
                    ),
                    BaseText(
                      text:
                          'Please only edit the clock in and out times if you find major discrepancies to avoid potential disputes',
                      fontSize: 14,
                      showFullDescription: true,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black.withOpacity(0.7),
                    ),
                    SizedBox(
                      height: getSize(18),
                    ),
                    Text.rich(
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
                            text: 'Shift Date - ',
                            style: TextStyle(
                              fontSize: getFontSize(12),
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.7),
                            ),
                          ),
                          TextSpan(
                            text: ' 12 May 2024',
                            style: TextStyle(
                              fontSize: getFontSize(12),
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(20),
                    ),
                    BaseText(
                      text: 'Clock in',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: getSize(8),
                    ),
                    commonClockInOutMethod(
                      onTap: () async {
                        await selectTime(context, state.clockIn).then(
                          (value) {
                            if (value != null) {
                              context.read<ShiftsBloc>().add(
                                    ShiftsBlocEvent.changeClockInClockOutTime(
                                      value,
                                      true,
                                    ),
                                  );
                            }
                          },
                        );
                      },
                      clockInOrOutTime: formatTimeOfDay(state.clockIn),
                    ),
                    SizedBox(
                      height: getSize(20),
                    ),
                    BaseText(
                      text: 'Clock out',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: getSize(8),
                    ),
                    commonClockInOutMethod(
                      onTap: () async {
                        await selectTime(context, state.clockOut).then(
                          (value) {
                            if (value != null) {
                              context.read<ShiftsBloc>().add(
                                    ShiftsBlocEvent.changeClockInClockOutTime(
                                      value,
                                      false,
                                    ),
                                  );
                            }
                          },
                        );
                      },
                      clockInOrOutTime: formatTimeOfDay(state.clockOut),
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
                            buttonText: 'Cancel',
                          ),
                        ),
                        SizedBox(
                          width: getSize(25),
                        ),
                        Expanded(
                          child: CommonButton(
                            onPressed: () async {
                              await context.router.maybePop().then(
                                (value) {
                                  AcceptRejectDialog(
                                    title: 'Approve',
                                    description:
                                        'By approving these clock in and out times, you confirm that you have reviewed the [contractor name]’s  hours. Once approved, the times will be finalized.',
                                    onPressedAccept: () {},
                                    acceptButtonText: 'Approve',
                                    onPressedReject: () {
                                      context.router.maybePop();
                                    },
                                  ).acceptRejectDialog(context);
                                },
                              );
                            },
                            buttonText: 'Approve',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(25),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  Future<TimeOfDay?> selectTime(
      BuildContext context, TimeOfDay selectedTime) async {
    //log(selectedTime.);
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              secondary: AppColors.primaryColor,
              // change the border color
              //  primary: Colors.red,
              // change the text color
              //onSurface: Colors.purple,
            ),
            // button colors
            // buttonTheme: ButtonThemeData(
            //   colorScheme: ColorScheme.light(
            //     primary: Colors.green,
            //   ),
            // ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      return pickedTime;
    }
    return null;
    // setState(() {
    //   selectedTime = pickedTime;
    // });
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
