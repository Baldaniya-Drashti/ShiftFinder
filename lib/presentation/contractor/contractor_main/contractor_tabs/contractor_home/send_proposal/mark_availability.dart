// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_multi_date_picker.dart';

class MarkUnavailability extends StatelessWidget {
  MarkUnavailability({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        selectMultiDate(context),
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
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  List<DateTime> selectedDateList = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 1)),
    DateTime.now().add(Duration(days: 3)),
    DateTime.now().add(Duration(days: 5)),
    DateTime.now().add(Duration(days: 7)),
    DateTime.now().add(Duration(days: 8)),
  ];

  Widget selectMultiDate(BuildContext context) {
    return CustomMultiDatePicker(
      value: selectedDateList,
      selectableDayPredicate: (date) {
        return selectedDateList.any((selectedDate) =>
            selectedDate.year == date.year &&
            selectedDate.month == date.month &&
            selectedDate.day == date.day);
      },
      onValueChanged: (value) {},
    );
  }
}
