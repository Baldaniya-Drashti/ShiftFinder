// ignore_for_file: invalid_use_of_protected_member

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:figma_squircle/figma_squircle.dart';

import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class CustomDropdownTextfield extends StatelessWidget {
  final SingleValueDropDownController valueController;

  final List<DropDownValueModel> list;
  final Function(dynamic)? onChanged;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? borderColor;
  final FocusNode? textFieldFocusNode;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final bool enableSearch;
  const CustomDropdownTextfield({
    super.key,
    required this.valueController,
    this.onChanged,
    required this.list,
    this.validator,
    this.textFieldFocusNode,
    this.fillColor,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.enableSearch = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      padding: EdgeInsets.zero,
      // dropdownColor: ColorConstants.white,
      listPadding: ListPadding(top: getSize(8), bottom: getSize(8)),
      enableSearch: enableSearch,

      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: valueController,
      searchDecoration: InputDecoration(
        alignLabelWithHint: true,
        isDense: true,
        filled: false,
        prefixIcon: prefixIcon,
        focusColor: AppColors.white,
        // label: BaseText(
        //   text: labelText ?? '',
        //   fontSize: 16,
        //   textColor: ColorConstants.black.withOpacity(0.60),
        // ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(18),
        ),
        hintText: hintText,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getSize(10),
          ),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getSize(10),
          ),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getSize(10),
          ),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getSize(10),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        //  floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getSize(10),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto Flex',
          letterSpacing: 0.5,
          color: AppColors.red,
        ),
        labelStyle: TextStyle(
          fontSize: getFontSize(12),
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto Flex',
          letterSpacing: 0.5,
        ),
        hintStyle: TextStyle(
          fontSize: getFontSize(12),
          fontFamily: 'Roboto Flex',
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: AppColors.black,
        ),
      ),
      dropDownIconProperty: IconProperty(
        icon: Icons.keyboard_arrow_down,
        color: AppColors.black,
        size: getSize(24),
      ),
      dropDownItemCount: 5,
      clearOption: false,

      dropdownRadius: getSize(10),
      listTextStyle: TextStyle(
        fontSize: getFontSize(14),
        fontFamily: 'Roboto Flex',
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      textStyle: TextStyle(
        debugLabel: labelText,
        fontFamily: 'Roboto Flex',
        //  letterSpacing: 0.5,
        color: AppColors.black,
        fontSize: getFontSize(13),
        fontWeight: FontWeight.w400,
      ),
      validator: validator,
      textFieldFocusNode: textFieldFocusNode,
      textFieldDecoration: InputDecoration(

        alignLabelWithHint: true,
        isDense: true,
        prefixIcon: prefixIcon,
        filled: true,
        label: BaseText(
          text: labelText ?? '',
          fontSize: 16,
          textColor: AppColors.black.withOpacity(0.60),
        ),
        fillColor: AppColors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: getSize(10)),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: getSize(10)),
          borderSide: BorderSide(
            color: AppColors.white,
            width: getSize(1.5),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: getSize(10)),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: getSize(10)),
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: getSize(10)),
          borderSide: BorderSide(
            color: AppColors.red,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: SmoothBorderRadius(cornerRadius: getSize(10)),
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: getSize(20),
          vertical: getSize(14),
        ),
        hintText: hintText ?? '',
        errorStyle: TextStyle(
          fontSize: getFontSize(12),
          letterSpacing: 0.5,
          fontWeight: FontWeight.normal,
          fontFamily: 'Roboto Flex',
          color: AppColors.red,
        ),
        labelStyle: TextStyle(
          fontSize: getFontSize(14),
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          fontFamily: 'Roboto Flex',
          color: AppColors.black.withOpacity(0.6),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          fontSize: getFontSize(14),
          fontFamily: 'Roboto Flex',
          fontWeight: FontWeight.w500,
          //letterSpacing: 0.5,
          color: AppColors.black.withOpacity(0.5),
        ),
        prefixStyle: TextStyle(
          fontSize: getFontSize(15),
          fontFamily: 'Roboto Flex',
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      dropDownList: list,
      onChanged: onChanged,
    );
  }
}
