// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
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
    print(selectedDates);

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
        final dateExist = isDateExist(selectedDates, date);

        return dateExist;
      },
      onValueChanged: (value) {
        context
            .read<SendProposalBloc>()
            .add(SendProposalEvent.setDateUnavailableEvent(value));
      },
    );
  }

  bool isDateExist(List<DateTime> selectedDates, DateTime currentDate) {
    return selectedDates.any((selectedDate) {
      return (selectedDate.year == currentDate.year &&
          selectedDate.month == currentDate.month &&
          selectedDate.day == currentDate.day);
    });
  }
}
