// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class CustomMultiDatePicker extends StatelessWidget {
  final List<DateTime?> value;
  final Color? selectedDateBGColor;
  final void Function(List<DateTime>)? onValueChanged;
  final bool isDisabled;
  final bool Function(DateTime)? selectableDayPredicate;
  const CustomMultiDatePicker(
      {super.key,
      required this.value,
      this.onValueChanged,
      this.selectedDateBGColor,
      this.selectableDayPredicate,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          firstDate: DateTime.now(),
          calendarType: CalendarDatePicker2Type.multi,
          disableMonthPicker: true,
          disableModePicker: true,
          weekdayLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
          weekdayLabelTextStyle: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          selectedDayTextStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            fontSize: getFontSize(12),
          ),
          selectedDayHighlightColor:
              selectedDateBGColor ?? AppColors.primaryColor,
          daySplashColor: AppColors.transparent,
          disabledDayTextStyle: TextStyle(
            color: (isDisabled)
                ? AppColors.black
                : (selectableDayPredicate != null)
                    ? AppColors.black
                    : AppColors.grey,
          ),
          selectableDayPredicate: (selectableDayPredicate != null)
              ? selectableDayPredicate
              : (value) {
                  return (isDisabled) ? false : true;
                },
        ),
        value: value,
        onValueChanged: onValueChanged,
      ),
    );
  }
}
