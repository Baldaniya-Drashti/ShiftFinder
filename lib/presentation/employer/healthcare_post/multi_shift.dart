// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_time_picker_dropdown.dart';

class MultiPostShift extends StatelessWidget {
  const MultiPostShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        paddingBetweenFields(),
        dateField(),
        paddingBetweenFields(),
        startTime(),
        paddingBetweenFields(),
        endTime(),
        paddingBetweenFields(),
        unpaidBreakDropDown(),
        paddingBetweenFields(),
        totalPaybleHours(),
        paddingBetweenFields(),
        commuteAllownceDropDown(),
        paddingBetweenFields(),
        accommodationAllowanceDropDown(),
        paddingBetweenFields(),
        shiftNotesField(),
        paddingBetweenFields(),
        vacancyCheckBox(context),
        paddingBetweenFields(),
        numberOfVacancy(),
        Padding(
          padding: EdgeInsets.only(top: getSize(50), bottom: getSize(30)),
          child: CommonButton(
            onPressed: () {},
            buttonText: StringConstant.txtContinue,
          ),
        ),
      ],
    );
  }

  Widget dateField() {
    return CustomTextField(
      labelText: StringConstant.date,
      hintText: StringConstant.date,
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(
          SvgImageConstant.calendar,
          height: getSize(24),
          width: getSize(24),
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget startTime() {
    return CustomTimePickerDropdown(
      labelText: StringConstant.startTime,
      hourOnChanged: (value) {},
      minOnChanged: (value) {},
    );
  }

  Widget endTime() {
    return CustomTimePickerDropdown(
      labelText: StringConstant.endTime,
      hourOnChanged: (value) {},
      minOnChanged: (value) {},
    );
  }

  Widget unpaidBreakDropDown() {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.unpaidBreak,
      hintText: StringConstant.unpaidBreak,
      showTextfield: false,
      isLabelPadding: true,
      items: [],
      onChanged: (value) {},
    );
  }

  Widget totalPaybleHours() {
    return CustomTextField(
      labelText: StringConstant.totalPayableHours,
      hintText: "00h 00min",
      hintAsValue: true,
      readOnly: true,
      fillColor: AppColors.grey04,
    );
  }

  Widget commuteAllownceDropDown() {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.commuteAllowance,
      hintText: StringConstant.commuteAllowance,
      showTextfield: false,
      isLabelPadding: true,
      items: CommonList.commuteAllownceList.map((val) {
        return DropdownMenuItem<String>(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }

  Widget accommodationAllowanceDropDown() {
    return CustomDropdwonWithTextField(
      labelText: StringConstant.accommodationAllowance,
      hintText: StringConstant.accommodationAllowance,
      showTextfield: false,
      isLabelPadding: true,
      items: CommonList.commuteAllownceList.map((val) {
        return DropdownMenuItem<String>(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }

  Widget shiftNotesField() {
    return CustomTextField(
      labelText: StringConstant.addShiftNotes,
      hintText: StringConstant.typeHere,
      isOptional: true,
      maxLines: 3,
      keyboardType: TextInputType.multiline,
    );
  }

  Widget vacancyCheckBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getSize(20),
            width: getSize(16.67),
            child: Checkbox(
              value: false,
              activeColor: AppColors.primaryColor,
              side: BorderSide(
                width: getSize(1.5),
                color: AppColors.black.withOpacity(0.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            width: getSize(15),
          ),
          Flexible(
            child: BaseText(
              text: StringConstant.singleShiftVacancyDesc,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget numberOfVacancy() {
    return CustomTextField(
      labelText: StringConstant.numberOfVacancies,
      hintText: StringConstant.numberOfVacancies,
      keyboardType: TextInputType.number,
    );
  }
}
