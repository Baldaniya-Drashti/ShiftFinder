// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/texts/common_texts.dart';

class CustomeSpecialityBox extends StatelessWidget {
  CustomeSpecialityBox({
    super.key,
    this.labelText,
    required this.hintText,
    this.value,
    required this.items,
    required this.experienceOnChanged,
    this.isLabelPadding = false,
    this.showTextfield = true,
    this.showDropDown = false,
    this.showPrefixIcon = false,
    this.validator,
    this.isOptional = false,
    this.optionalWidget,
    this.suffixIcon,
    this.fieldValidator,
    this.fieldController,
    this.fieldHintText,
    this.childDroDwonHintText,
    this.childDropDownValidator,
    this.childDropDownValue,
    this.showChildDropDownPrefixIcon = false,
    this.childDropDownItems,
    this.onDelete,
    this.showError = false,
    this.errorText,
    required this.selectedValue,
  });
  final String? labelText;
  final String? hintText;
  final String? fieldHintText;
  final String? childDroDwonHintText;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final bool? isLabelPadding;
  final bool showTextfield;
  final bool showDropDown;
  final Function(String?)? experienceOnChanged;
  final String? Function(String?)? validator;
  final bool showPrefixIcon;
  final bool? isOptional;
  final Widget? optionalWidget;

  final Widget? suffixIcon;
  final String? Function(String?, BuildContext)? fieldValidator;
  final TextEditingController? fieldController;
  final String? Function(String?)? childDropDownValidator;
  final bool showChildDropDownPrefixIcon;
  final String? childDropDownValue;
  List<String>? childDropDownItems;
  final VoidCallback? onDelete;
  final bool showError;
  final String? errorText;
  final String selectedValue;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(10),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.white),
      borderRadius: BorderRadius.circular(10),
    );
    final errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.red),
      borderRadius: BorderRadius.circular(10),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: getSize(15),
            horizontal: getSize(18),
          ),
          decoration: BoxDecoration(
            color: (showTextfield || showDropDown)
                ? AppColors.white
                : AppColors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.2),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(
                    text: selectedValue,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  GestureDetector(
                    onTap: onDelete,
                    child: SvgPicture.asset(
                      SvgImageConstant.remove,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: getSize(5)),
                child: Divider(
                  color: AppColors.black.withOpacity(0.3),
                ),
              ),
              DropdownButtonFormField<String>(
                validator: validator,
                dropdownColor: AppColors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  prefixIcon: (showPrefixIcon)
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: getSize(14),
                          ),
                          child: SvgPicture.asset(
                            SvgImageConstant.association,
                            height: getSize(24),
                            width: getSize(24),
                          ),
                        )
                      : null,
                  enabledBorder: border,
                  border: border,
                  focusedErrorBorder: errorBorder,
                  focusedBorder: focusedBorder,
                  errorBorder: errorBorder,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                alignment: Alignment.centerLeft,
                hint: BaseText(
                  text: hintText!,
                  textColor: AppColors.black.withOpacity(0.50),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                value: value,
                icon: SvgPicture.asset(
                  SvgImageConstant.downArrow,
                ),
                isExpanded: true,
                items: items,
                onChanged: experienceOnChanged,
              ),
            ],
          ),
        ),
        if (showError) commonErrorText(errorText ?? ""),
        SizedBox(
          height: getSize(15),
        ),
      ],
    );
  }
}
