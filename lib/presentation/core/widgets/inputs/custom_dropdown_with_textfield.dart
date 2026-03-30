// ignore_for_file: must_be_immutable, unnecessary_question_mark

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class CustomDropdwonWithTextField extends StatelessWidget {
  const CustomDropdwonWithTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.value,
    required this.items,
    required this.onChanged,
    this.isLabelPadding = true,
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
    this.fieldPrefixIcon,
    this.fieldPrefixIconConstraints,
    this.fieldInputFormatters,
    this.fieldKeyboardType,
    this.fieldInitialValue,
    this.removeErrorBorder = false,
    this.fieldMaxLength,
    this.dropDownReadOnly = false,
    this.disableDropDownColor,
    this.dropDownIcon,
    this.onDropDownTap,
    this.verticalAlignment = MainAxisAlignment.start,
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
  final List<DropdownMenuItem<String>>? childDropDownItems;
  final BoxConstraints? fieldPrefixIconConstraints;
  final Widget? fieldPrefixIcon;
  final List<TextInputFormatter>? fieldInputFormatters;
  final TextInputType? fieldKeyboardType;
  final String? fieldInitialValue;
  final bool removeErrorBorder;
  final int? fieldMaxLength;
  final bool dropDownReadOnly;
  final Color? disableDropDownColor;
  final Widget? dropDownIcon;
  final void Function()? onDropDownTap;
  final MainAxisAlignment verticalAlignment;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.transparent),
      borderRadius: BorderRadius.circular(10),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.transparent),
      borderRadius: BorderRadius.circular(10),
    );
    final errorBorder = (removeErrorBorder)
        ? InputBorder.none
        : OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(10),
          );
    return Column(
      mainAxisAlignment: verticalAlignment,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: EdgeInsets.only(
                left: getSize((isLabelPadding == true) ? 18 : 0)),
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
                            color: AppColors.black.withValues(alpha: 0.8),
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
                color: AppColors.lightGrey.withValues(alpha: 0.2),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IgnorePointer(
                ignoring: dropDownReadOnly,
                child: DropdownButtonFormField<String>(
                  validator: validator,
                  dropdownColor: AppColors.white,
                  menuMaxHeight: getSize(300),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: (dropDownReadOnly)
                        ? disableDropDownColor ?? AppColors.grey04
                        : AppColors.white,
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
                    textColor: AppColors.black.withValues(alpha: 0.50),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  initialValue: value,
                  icon: dropDownIcon ??
                      SvgPicture.asset(
                        SvgImageConstant.downArrow,
                      ),
                  isExpanded: true,
                  items: items,
                  onChanged: onChanged,
                  onTap: onDropDownTap,
                ),
              ),
              if (showTextfield) ...[
                Divider(
                  color: AppColors.black.withValues(alpha: 0.3),
                  indent: getSize(18),
                  endIndent: getSize(18),
                ),
                textField(context),
              ],
              if (showDropDown) ...[
                Divider(
                  color: AppColors.black.withValues(alpha: 0.3),
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
      suffixIcon: suffixIcon,
      isBoxShadow: false,
      hintText: fieldHintText,
      errorInputBorder: UnderlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.red,
        ),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      maxLength: fieldMaxLength,
      errorMaxLines: 2,
      onChanged: fieldOnChanged,
      validator: fieldValidator,
      prefixIcon: fieldPrefixIcon,
      prefixIconConstraints: fieldPrefixIconConstraints,
      inputFormatters: fieldInputFormatters,
      keyboardType: fieldKeyboardType,
      controller: fieldController,
      initialValue: fieldInitialValue,
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
      menuMaxHeight: getSize(300),
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
        textColor: AppColors.black.withValues(alpha: 0.50),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      initialValue: childDropDownValue,
      icon: SvgPicture.asset(
        SvgImageConstant.downArrow,
      ),
      isExpanded: true,
      items: childDropDownItems,
      onChanged: childDropDownOnChanged,
    );
  }
}

class CustomLocationDropdDown extends StatelessWidget {
  const CustomLocationDropdDown({
    super.key,
    this.labelText,
    required this.hintText,
    this.value,
    required this.items,
    required this.onChanged,
    this.isLabelPadding = true,
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
    this.fieldPrefixIcon,
    this.fieldPrefixIconConstraints,
    this.fieldInputFormatters,
    this.fieldKeyboardType,
    this.fieldInitialValue,
    this.removeErrorBorder = false,
    this.autovalidateMode,
  });

  final String? labelText;
  final Widget? ddPrefixIcon;
  final String? hintText;
  final String? fieldHintText;
  final String? childDroDwonHintText;
  final dynamic value;
  final List<DropdownMenuItem<dynamic>>? items;
  final bool? isLabelPadding;
  final bool showTextfield;
  final bool showDropDown;
  final Function(dynamic)? onChanged;
  final String? Function(dynamic)? validator;
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
  final List<DropdownMenuItem<String>>? childDropDownItems;
  final BoxConstraints? fieldPrefixIconConstraints;
  final Widget? fieldPrefixIcon;
  final List<TextInputFormatter>? fieldInputFormatters;
  final TextInputType? fieldKeyboardType;
  final String? fieldInitialValue;
  final bool removeErrorBorder;
  final AutovalidateMode? autovalidateMode;
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
    final errorBorder = (removeErrorBorder)
        ? InputBorder.none
        : OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.red),
            borderRadius: BorderRadius.circular(10),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: EdgeInsets.only(
                left: getSize((isLabelPadding == true) ? 18 : 0)),
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
                          text: "(${StringConstant.optional})",
                          style: TextStyle(
                            fontSize: getFontSize(10),
                            fontWeight: FontWeight.w500,
                            color: AppColors.black.withValues(alpha: 0.8),
                            fontFamily: "Roboto Flex",
                          ),
                        )
                      : optionalWidget ?? Container(),
                ),
              ],
            ),
          ),
          SizedBox(height: getSize(7)),
        ],
        Container(
          decoration: BoxDecoration(
            color: (showTextfield || showDropDown)
                ? AppColors.white
                : AppColors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey.withValues(alpha: 0.2),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<dynamic>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validator,
                dropdownColor: AppColors.white,
                menuMaxHeight: getSize(300),
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
                  textColor: AppColors.black.withValues(alpha: 0.50),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                initialValue: value,
                icon: SvgPicture.asset(
                  SvgImageConstant.downArrow,
                ),
                isExpanded: true,
                items: items,
                onChanged: onChanged,
              ),
              if (showTextfield) ...[
                Divider(
                  color: AppColors.black.withValues(alpha: 0.3),
                  indent: getSize(18),
                  endIndent: getSize(18),
                ),
                textField(context),
              ],
              if (showDropDown) ...[
                Divider(
                  color: AppColors.black.withValues(alpha: 0.3),
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
      prefixIcon: fieldPrefixIcon,
      prefixIconConstraints: fieldPrefixIconConstraints,
      inputFormatters: fieldInputFormatters,
      keyboardType: fieldKeyboardType,
      controller: fieldController,
      initialValue: fieldInitialValue,
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
      menuMaxHeight: getSize(300),
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
        textColor: AppColors.black.withValues(alpha: 0.50),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      initialValue: childDropDownValue,
      icon: SvgPicture.asset(
        SvgImageConstant.downArrow,
      ),
      isExpanded: true,
      items: childDropDownItems,
      onChanged: childDropDownOnChanged,
    );
  }
}
