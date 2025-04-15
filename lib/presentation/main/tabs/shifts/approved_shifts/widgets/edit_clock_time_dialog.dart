import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';

class EditClockTimeDialog extends StatelessWidget {
  const EditClockTimeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  editClockTimeDialog(BuildContext context, HiredContractorListDTO contractor,
      {VoidCallback? callBack}) async {
    await showDialog<bool?>(
      context: context,
      builder: (__) => BlocProvider(
        create: (_) => getIt<HiredContractorBloc>()
          ..add(HiredContractorEvent.getEditClockInTime(
              clockIn: contractor.clock_in_time,
              clockOut: contractor.clock_out_time)),
        child: BlocBuilder<HiredContractorBloc, HiredContractorState>(
          builder: (con, state) {
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
                      textColor: AppColors.black.withValues(alpha: 0.7),
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
                              color: AppColors.black.withValues(alpha: 0.7),
                            ),
                          ),
                          TextSpan(
                            text: DateFormat('dd MMM, yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    (contractor.shift_date ?? -1) * 1000)),
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
                        DateTime dateTime;
                        if (state.clockIn == null) {
                          dateTime = DateTime.fromMillisecondsSinceEpoch(
                              (contractor.clock_in_time ?? 0) * 1000);
                        } else {
                          dateTime = DateTime.fromMillisecondsSinceEpoch(
                              (state.clockIn ?? 0) * 1000);
                        }

                        final clockInTime =
                            await _showTimePicker(con, dateTime: dateTime);
                        if (clockInTime != null) {
                          con.read<HiredContractorBloc>().add(
                              HiredContractorEvent.changeClockInClockOutTime(
                                  con, clockInTime, true));
                        }
                      },
                      clockInOrOutTime: (state.clockIn != null)
                          ? DateFormat('hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  (state.clockIn ?? -1) * 1000))
                          : StringConstant.clockIn,
                    ),
                    if (state.showClockTimeError && state.clockIn == null)
                      commonErrorText(StringConstant.pleaseAddClockInTime),
                    SizedBox(height: getSize(20)),
                    BaseText(
                      text: StringConstant.clockOut,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: getSize(8)),
                    commonClockInOutMethod(
                      onTap: () async {
                        DateTime dateTime;
                        if (state.clockIn == null) {
                          dateTime = DateTime.fromMillisecondsSinceEpoch(
                              (contractor.clock_in_time ?? 0) * 1000);
                        } else {
                          dateTime = DateTime.fromMillisecondsSinceEpoch(
                              (state.clockOut ?? 0) * 1000);
                        }

                        final clockOutTime =
                            await _showTimePicker(con, dateTime: dateTime);
                        if (clockOutTime != null) {
                          con.read<HiredContractorBloc>().add(
                              HiredContractorEvent.changeClockInClockOutTime(
                                  con, clockOutTime, false));
                        }
                      },
                      clockInOrOutTime: (state.clockOut != null)
                          ? DateFormat('hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  (state.clockOut ?? -1) * 1000))
                          : StringConstant.clockOut,
                    ),
                    if (state.showClockTimeError && state.clockOut == null)
                      commonErrorText(StringConstant.pleaseAddClockOutTime),
                    SizedBox(height: getSize(30)),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            backgroundColor: AppColors.white,
                            borderColor: AppColors.green,
                            buttonTextColor: AppColors.green,
                            onPressed: () => con.router.maybePop(),
                            buttonText: StringConstant.cancle,
                          ),
                        ),
                        SizedBox(width: getSize(25)),
                        Expanded(
                          child: CommonButton(
                            isSubmitting: state.isSubmitting,
                            onPressed: () {
                              con.read<HiredContractorBloc>().add(
                                      HiredContractorEvent.submitClockInOutTime(
                                    con,
                                    isEdit: true,
                                    postId: contractor.post_id ?? -1,
                                    userId: contractor.user_id ?? -1,
                                    clockIn: state.clockIn,
                                    clockOut: state.clockOut,
                                  ));
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
    ).then((value) {
      if (value == true) {
        if (callBack != null) {
          callBack();
        }
      }
    });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  Future<TimeOfDay?> _showTimePicker(BuildContext context,
      {required DateTime dateTime}) async {
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
              initialTime: TimeOfDay.fromDateTime(dateTime),
            ),
          );
        });

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
            SizedBox(width: getSize(10)),
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
