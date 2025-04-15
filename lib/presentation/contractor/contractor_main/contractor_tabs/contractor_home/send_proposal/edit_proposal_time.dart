// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/send_proposal_bloc/send_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/main/date_time_dto/date_time_dto.dart';
import 'package:shift/infrastructure/main/shift_detail_dto/shift_detail_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';

class EditProposalTime extends StatelessWidget {
  ShiftDetailDTO shift;
  EditProposalTime({required this.shift});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendProposalBloc, SendProposalState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.multiDates.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return (state.multiDates[index].isUnAvailable)
                ? notAvailable(context, state.multiDates[index])
                : startEndTime(context, index, state.multiDates[index]);
          },
        );
      },
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget startEndTime(BuildContext context, int index, DateTimeDTO currentObj) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              getSize(20), getSize(10), getSize(20), getSize(5)),
          child: BaseText(
            text: (currentObj.date != null && currentObj.date!.isNotEmpty)
                ? DateFormat('d MMM, yyyy')
                    .format(DateTime.parse(currentObj.date ?? ""))
                : "",
            textColor: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(20)),
          decoration: BoxDecoration(
              color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              startTime(context, index, currentObj),
              paddingBetweenFields(),
              endTime(context, index, currentObj),
              paddingBetweenFields(),
              unpaidBreakDropDown(currentObj.unpaidBreak),
              paddingBetweenFields(),
              paybleHours(currentObj.totalPaybleHours),
            ],
          ),
        ),
      ],
    );
  }

  Widget startTime(BuildContext context, int index, DateTimeDTO obj) {
    final startHourValid = (obj.startHour != null && obj.startHour!.isNotEmpty);
    final startMinuteValid =
        (obj.startHour != null && obj.startHour!.isNotEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.startTime,
          disableDropDownColor: AppColors.grey04,
          hourValue: (startHourValid) ? obj.startHour : null,
          minuteValue: (startMinuteValid) ? obj.startMinute : null,
          hourOnChanged: (value) {
            if (value != null) {
              context.read<SendProposalBloc>().add(
                  SendProposalEvent.startHourListChanged(
                      value, index, obj.date ?? ""));
            }
          },
          minOnChanged: (value) {
            if (value != null) {
              context.read<SendProposalBloc>().add(
                  SendProposalEvent.startMinuteListChanged(
                      value, index, obj.date ?? ""));
            }
          },
        ),
      ],
    );
  }

  Widget endTime(BuildContext context, int index, DateTimeDTO obj) {
    final endHourValid = (obj.endHour != null && obj.endHour!.isNotEmpty);
    final endMinuteValid = (obj.endMinute != null && obj.endMinute!.isNotEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTimePickerDropdown(
          labelText: StringConstant.endTime,
          disableDropDownColor: AppColors.grey04,
          hourValue: (endHourValid) ? obj.endHour : null,
          minuteValue: (endMinuteValid) ? obj.endMinute : null,
          hourOnChanged: (value) {
            if (value != null) {
              context.read<SendProposalBloc>().add(
                  SendProposalEvent.endHourListChanged(
                      value, index, obj.date ?? ""));
            }
          },
          minOnChanged: (value) {
            if (value != null) {
              context.read<SendProposalBloc>().add(
                  SendProposalEvent.endMinuteListChanged(
                      value, index, obj.date ?? ""));
            }
          },
        ),
      ],
    );
  }

  Widget unpaidBreakDropDown(String? breakTime) {
    return CustomTextField(
      labelText: StringConstant.unpaidBreak,
      hintText: (breakTime != null && breakTime.isNotEmpty) ? breakTime : null,
      isLabelPadding: false,
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  Widget paybleHours(String? payableHours) {
    return CustomTextField(
      labelText: StringConstant.payableHours,
      hintText: payableHours ?? "00h 00min",
      isLabelPadding: false,
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  Widget notAvailableField() {
    return CustomTextField(
      labelText: StringConstant.proposedTime,
      hintText: StringConstant.notAvailable,
      hintTextColor: AppColors.redAccent,
      isLabelPadding: false,
      readOnly: true,
    );
  }

  Widget notAvailable(BuildContext context, DateTimeDTO currentObj) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              getSize(20), getSize(10), getSize(20), getSize(5)),
          child: BaseText(
            text: (currentObj.date != null && currentObj.date!.isNotEmpty)
                ? DateFormat('d MMM, yyyy')
                    .format(DateTime.parse(currentObj.date ?? ""))
                : "",
            textColor: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(20)),
          decoration: BoxDecoration(
              color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
          child: notAvailableField(),
        ),
      ],
    );
  }
}
