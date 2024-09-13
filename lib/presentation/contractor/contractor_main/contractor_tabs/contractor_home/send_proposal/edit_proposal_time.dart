import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';

class EditProposalTime extends StatelessWidget {
  const EditProposalTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return (index.isOdd)
                ? notAvailable(context)
                : startEndTime(context);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: getSize(30)),
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

  Widget startEndTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              getSize(20), getSize(10), getSize(20), getSize(5)),
          child: BaseText(
            text: "24 Sep, 2024",
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
              startTime(context),
              paddingBetweenFields(),
              endTime(context),
              paddingBetweenFields(),
              paybleHours(),
            ],
          ),
        ),
      ],
    );
  }

  Widget startTime(BuildContext context) {
    return CustomTimePickerDropdown(
      labelText: StringConstant.startTime,
      isLabelPadding: false,
      hourOnChanged: (value) {},
      minOnChanged: (value) {},
    );
  }

  Widget endTime(BuildContext context) {
    return CustomTimePickerDropdown(
      labelText: StringConstant.endTime,
      isLabelPadding: false,
      hourOnChanged: (value) {},
      minOnChanged: (value) {},
    );
  }

  Widget paybleHours() {
    return CustomTextField(
      labelText: StringConstant.payableHours,
      hintText: "00h 00min",
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

  Widget notAvailable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              getSize(20), getSize(10), getSize(20), getSize(5)),
          child: BaseText(
            text: "24 Sep, 2024",
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
