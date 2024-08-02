// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CustomDropdwonWithTextField extends StatelessWidget {
  CustomDropdwonWithTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.value,
    required this.items,
    required this.onChanged,
    this.isLabelPadding = false,
    this.showTextfield = true,
    this.showDropDown = false,
    this.showPrefixIcon = false,
    this.validator,
    this.isOptional = false,
    this.optionalWidget,
    this.suffixIcon,
    this.fieldOnChanged,
    this.fieldValidator,
    this.fieldController,
    this.fieldHintText,
    this.childDroDwonHintText,
    this.childDropDownOnChanged,
    this.childDropDownValidator,
    this.childDropDownValue,
    this.showChildDropDownPrefixIcon = false,
    this.childDropDownItems,
    this.ddPrefixIcon,
  });
  final String? labelText;
  final Widget? ddPrefixIcon;
  final String? hintText;
  final String? fieldHintText;
  final String? childDroDwonHintText;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final bool? isLabelPadding;
  final bool showTextfield;
  final bool showDropDown;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool showPrefixIcon;
  final bool? isOptional;
  final Widget? optionalWidget;

  final Widget? suffixIcon;
  final Function(String)? fieldOnChanged;
  final String? Function(String?, BuildContext)? fieldValidator;
  final TextEditingController? fieldController;
  final Function(String?)? childDropDownOnChanged;
  final String? Function(String?)? childDropDownValidator;
  final bool showChildDropDownPrefixIcon;
  final String? childDropDownValue;
  List<String>? childDropDownItems;

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
        if (labelText != null) ...[
          Padding(
            padding: EdgeInsets.only(
                left: getSize((isLabelPadding == true) ? 20 : 0)),
            child: Row(
              children: [
                BaseText(
                  text: labelText ?? "",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getSize(5),
                  ),
                  child: (isOptional == true && optionalWidget == null)
                      ? BaseText(
                          text: "(Optional)",
                          style: TextStyle(
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withOpacity(0.8),
                            fontFamily: "Roboto Flex",
                          ),
                        )
                      : optionalWidget ?? Container(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
        ],
        Container(
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
                          child: ddPrefixIcon ??
                              SvgPicture.asset(
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getSize(18),
                  ),
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
                onChanged: onChanged,
              ),
              if (showTextfield) ...[
                Divider(
                  color: AppColors.black.withOpacity(0.3),
                  indent: getSize(18),
                  endIndent: getSize(18),
                ),
                textField(context),
              ],
              if (showDropDown) ...[
                Divider(
                  color: AppColors.black.withOpacity(0.3),
                  indent: getSize(18),
                  endIndent: getSize(18),
                ),
                childDropDown(),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget textField(
    BuildContext context,
  ) {
    return CustomTextField(
      // labelText: StringConstant.address,
      // isLabelPadding: true,
      suffixIcon: suffixIcon,
      isBoxShadow: false,
      hintText: fieldHintText,
      errorInputBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.red,
        ),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      errorMaxLines: 2,
      onChanged: fieldOnChanged,
      validator: fieldValidator,
      controller: fieldController,
    );
  }

  Widget childDropDown() {
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
    return DropdownButtonFormField<String>(
      validator: childDropDownValidator,
      dropdownColor: AppColors.white,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        prefixIcon: (showChildDropDownPrefixIcon)
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
        contentPadding: EdgeInsets.symmetric(
          horizontal: getSize(18),
        ),
      ),
      alignment: Alignment.centerLeft,
      hint: BaseText(
        text: childDroDwonHintText ?? "",
        textColor: AppColors.black.withOpacity(0.50),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      value: childDropDownValue,
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: getSize(25),
        color: AppColors.black,
      ),
      isExpanded: true,
      items: childDropDownItems!.map((val) {
        return DropdownMenuItem(
          value: val,
          child: BaseText(
            text: val,
            fontSize: 14,
            textColor: AppColors.black,
          ),
        );
      }).toList(),
      onChanged: childDropDownOnChanged,
    );
  }
}
