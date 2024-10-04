// ignore_for_file: must_be_immutable

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/core/logger/logger.dart';
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
            paddingBetweenFields(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: getSize(20)),
              child: CommonButton(
                onPressed: () {},
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

  Widget selectMultiDate(BuildContext context, SendProposalState state) {
    List<DateTime> selectedDates = state.multiDates.map((dto) {
      return (dto.date != null) ? DateTime.parse(dto.date!) : DateTime.now();
    }).toList();

    Log.debug("selected datess----> $selectedDates");
    return CustomMultiDatePicker(
      selectedDateList: state.multiDates,
      value: selectedDates,
      selectedDateBGColor: state.multiDates.any((element) => element.isUnAvailable==true)?AppColors.green:AppColors.red,
      /*selectedDateColors:
          (state.multiDates.every((element) => element.isUnAvailable == true))
              ? {
                  DateTime(2024, 10, 3): Colors.blue,
                  DateTime(2024, 10, 5): Colors.green,
                  DateTime(2024, 10, 7): Colors.yellowAccent,
                }
              : {},*/
      selectableDayPredicate: (date) {
        return isDateExist(selectedDates, date);
      },
      onValueChanged: (value) {
        final date = state.multiDates.where((dto) => dto.isUnAvailable == true).length;
        Log.debug("date ${date}");
        Log.debug(state.multiDates);
        print("Value is changed---> $value");
        Log.debug(value);
        context.read<SendProposalBloc>().add(SendProposalEvent.setDateUnavailableEvent(value));
      },
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
              color: AppColors.primaryColor,
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
        selectedDate.year == currentDate.year && selectedDate.month == currentDate.month && selectedDate.day == currentDate.day);
  }
}
