// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_multi_date_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MarkUnavailability extends StatelessWidget {
  const MarkUnavailability({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendProposalBloc, SendProposalState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectMultiDate(context, state),
            // selectMultiDate2(context, state),
            paddingBetweenFields(),
            if (state.shift.shift_detail?.same_or_different_time == 1)
              Padding(
                padding: EdgeInsets.symmetric(vertical: getSize(30)),
                child: CommonButton(
                  onPressed: () {
                    Navigator.pop(context, state.multiDates);
                  },
                  buttonText: StringConstant.done,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Color? getColorForDate(DateTime date, SendProposalState state) {
    String formattedDate = date.toIso8601String().substring(0, 10);

    DateTimeDTO? dateEntry = state.multiDates.firstWhere((entry) {
      return DateTime.parse(entry.date ?? "")
          .toIso8601String()
          .startsWith(formattedDate);
    }, orElse: () => DateTimeDTO());
    if (dateEntry.colorText != null) {
      return Color(int.parse(dateEntry.colorText!));
    }
    return null;
  }

  Widget selectMultiDate(BuildContext context, SendProposalState state) {
    List<DateTime> selectedDates = state.multiDates.map((dto) {
      return (dto.date != null) ? DateTime.parse(dto.date!) : DateTime.now();
    }).toList();

    return CustomMultiDatePicker(
      value: selectedDates,
      dayBuilder: ({
        required date,
        textStyle,
        decoration,
        isSelected,
        isDisabled,
        isToday,
      }) {
        Color? dynamicColor = getColorForDate(date, state);
        return Container(
          decoration: decoration?.copyWith(
            color: dynamicColor,
          ),
          child: Center(
            child: Text(
              MaterialLocalizations.of(context).formatDecimal(date.day),
              style: textStyle,
            ),
          ),
        );
      },
      selectableDayPredicate: (date) {
        return isDateExist(selectedDates, date);
      },
      onValueChanged: (value) {
        context
            .read<SendProposalBloc>()
            .add(SendProposalEvent.setDateUnavailableEvent(value));
      },
    );
  }

  Widget selectMultiDate2(BuildContext context, SendProposalState state) {
    final isUnAvaiable =
        state.multiDates.any((dto) => dto.isUnAvailable == true);
    print("COLORS---> ${isUnAvaiable}");
    return SfDateRangePicker(
      onSelectionChanged: (value) {
        context
            .read<SendProposalBloc>()
            .add(SendProposalEvent.setDateUnavailableEvent(value.value));
      },
      selectionMode: DateRangePickerSelectionMode.multiple,
      initialSelectedDates: [
        DateTime.now().add(Duration(days: 1)),
        DateTime.now().add(Duration(days: 2)),
        DateTime.now().add(Duration(days: 3)),
        DateTime.now().add(Duration(days: 4)),
      ],
      selectionColor:
          isUnAvaiable ? AppColors.redAccent : AppColors.primaryColor,

      /*cellBuilder: (context, cell) {
        return Container(
          decoration:
              BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
          child: Center(
            child: Text(
              MaterialLocalizations.of(context).formatDecimal(cell.date.day),
              // style: textStyle,
            ),
          ),
        );
      },*/
      // monthCellStyle: DateRangePickerMonthCellStyle(
      //   selectionColor: AppColors.primaryColor,
      //   rangeSelectionColor: AppColors.primaryColor,
      // ),
    );
  }

  /*Widget selectedMulti(BuildContext context, SendProposalState state) {
    List<DateTime> selectedDates = state.multiDates.map((dto) {
      return (dto.date != null) ? DateTime.parse(dto.date!) : DateTime.now();
    }).toList();

    print("print selected datesss--> ${selectedDates}");

    return CalendarDatePicker2(
      initialValue: selectedDates,
      config: CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.multi,
        disableYearPicker: true,
        weekdayLabelTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        selectableDayPredicate: (date) {
          return isDateExist(selectedDates, date);
        },
        selectedDayTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.white,
          fontSize: getFontSize(12),
        ),
        dayBuilder: ({
          required date,
          textStyle,
          decoration,
          isSelected,
          isDisabled,
          isToday,
        }) {
          return Container(
            decoration: decoration?.copyWith(
              color:
                  (isSelected == true) ? AppColors.red : AppColors.primaryColor,
            ),
            child: Center(
              child: Text(
                MaterialLocalizations.of(context).formatDecimal(date.day),
                style: textStyle,
              ),
            ),
          );
        },
      ),
      onValueChanged: (value) {
        print("On changed value ---> ${value}");
        // List<DateTime> nonNullableDates =
        //     value.whereType<DateTime>().toList();
        // context.read<SendProposalBloc>().add(
        //     SendProposalEvent.setDateUnavailableEvent(
        //         nonNullableDates));
      },
    );
  }
*/
  bool isDateExist(List<DateTime> selectedDates, DateTime currentDate) {
    return selectedDates.any((selectedDate) =>
        selectedDate.year == currentDate.year &&
        selectedDate.month == currentDate.month &&
        selectedDate.day == currentDate.day);
  }
}
