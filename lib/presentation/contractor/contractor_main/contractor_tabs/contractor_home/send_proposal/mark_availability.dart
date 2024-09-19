// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_multi_date_picker.dart';

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
    return CustomMultiDatePicker(
      value: selectedDates,
      selectedDateBGColor:
          state.multiDates.any((dto) => dto.isUnAvailable == true)
              ? AppColors.redAccent
              : AppColors.primaryColor,
      selectableDayPredicate: (date) {
        return isDateExist(selectedDates, date);
      },
      onValueChanged: (value) {
        print("Value is changed---> $value");
        context
            .read<SendProposalBloc>()
            .add(SendProposalEvent.setDateUnavailableEvent(value));
      },
    );
  }

  bool isDateExist(List<DateTime> selectedDates, DateTime currentDate) {
    return selectedDates.any((selectedDate) =>
        selectedDate.year == currentDate.year &&
        selectedDate.month == currentDate.month &&
        selectedDate.day == currentDate.day);
  }
}
