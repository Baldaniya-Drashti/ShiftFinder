// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/custom_multi_date_picker/calendar_date_picker2.dart';
import 'package:shift/presentation/core/widgets/custom_multi_date_picker/calendar_date_picker2_config.dart';

class CustomMultiDatePicker extends StatelessWidget {
  final List<DateTime?> value;
  final Color? selectedDateBGColor;
  final void Function(List<DateTime>)? onValueChanged;
  final bool isDisabled;
  final bool Function(DateTime)? selectableDayPredicate;
  final Map<DateTime, Color>? selectedDateColors;

  const CustomMultiDatePicker({
    super.key,
    required this.value,
    this.onValueChanged,
    this.selectedDateBGColor,
    this.selectableDayPredicate,
    this.isDisabled = false,
    this.selectedDateColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10)),
      child: CalendarDatePicker2(
        selectedDateColors: selectedDateColors ?? {},
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
