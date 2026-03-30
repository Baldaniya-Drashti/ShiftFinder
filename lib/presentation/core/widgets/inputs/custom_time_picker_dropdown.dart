// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_dropdown_with_textfield.dart';

class CustomTimePickerDropdown extends StatelessWidget {
  final String labelText;
  final String? hourHintText;
  final String? minHintText;
  final String? hourValue;
  final String? minuteValue;
  final bool isLabelPadding;
  final dynamic Function(String?)? minOnChanged;
  final dynamic Function(String?)? hourOnChanged;
  final List<DropdownMenuItem<String>>? hourItems;
  final List<DropdownMenuItem<String>>? minItems;
  final bool dropDownReadOnly;
  final Color? disableDropDownColor;
  final Widget? dropDownIcon;

  const CustomTimePickerDropdown({
    super.key,
    required this.labelText,
    this.hourHintText,
    this.minHintText,
    this.hourValue,
    this.minuteValue,
    this.hourItems,
    this.minItems,
    required this.hourOnChanged,
    required this.minOnChanged,
    this.isLabelPadding = true,
    this.dropDownReadOnly = false,
    this.disableDropDownColor,
    this.dropDownIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: CustomDropdwonWithTextField(
            labelText: labelText,
            hintText: hourHintText ?? StringConstant.hour,
            isLabelPadding: isLabelPadding,
            dropDownIcon: dropDownIcon,
            value: hourValue,
            showTextfield: false,
            showPrefixIcon: true,
            dropDownReadOnly: dropDownReadOnly,
            disableDropDownColor: disableDropDownColor ?? AppColors.grey,
            ddPrefixIcon: SvgPicture.asset(
              SvgImageConstant.clock,
              height: getSize(24),
              width: getSize(24),
              color: AppColors.primaryColor,
            ),
            items: hourItems ??
                CommonList.hourList.map((val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: BaseText(
                      text: val,
                      fontSize: 14,
                      textColor: AppColors.black,
                    ),
                  );
                }).toList(),
            onChanged: hourOnChanged,
          ),
        ),
        SizedBox(
          width: getSize(20),
        ),
        Expanded(
          child: CustomDropdwonWithTextField(
            hintText: minHintText ?? StringConstant.min,
            value: minuteValue,
            showTextfield: false,
            showPrefixIcon: true,
            dropDownIcon: dropDownIcon,
            dropDownReadOnly: dropDownReadOnly,
            disableDropDownColor: disableDropDownColor ?? AppColors.grey,
            ddPrefixIcon: SvgPicture.asset(
              SvgImageConstant.clock,
              height: getSize(24),
              width: getSize(24),
              color: AppColors.primaryColor,
            ),
            items: minItems ??
                CommonList.minutesList.map((val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: BaseText(
                      text: val,
                      fontSize: 14,
                      textColor: AppColors.black,
                    ),
                  );
                }).toList(),
            onChanged: minOnChanged,
          ),
        ),
      ],
    );
  }
}
