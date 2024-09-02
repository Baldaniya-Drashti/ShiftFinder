// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  //final FocusNode focusNode = FocusNode();
  const CustomTextField({
    Key? key,
    this.inputFormatters,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.labelText,
    this.labelStyle,
    this.isLabelPadding = true,
    this.isOptional = false,
    this.initialValue,
    this.onChanged,
    this.decoration,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.prefixIcon,
    this.validator,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.errorMaxLines,
    this.suffixIcon,
    this.maxLength,
    this.fillColor,
    this.obscureText = false,
    this.focusNode,
    this.isBoxShadow = true,
    this.errorInputBorder,
    this.optionalWidget,
    this.isPrefixValueShow = false,
    this.hintAsValue = false,
    this.prefixIconConstraints,
  }) : super(key: key);

  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? labelText;
  final TextStyle? labelStyle;
  final bool? isLabelPadding;
  final bool? isOptional;
  final Widget? optionalWidget;
  final String? initialValue;
  final Function(String)? onChanged;
  final InputDecoration? decoration;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autofocus;
  final Color? fillColor;
  final int maxLines;
  final String? Function(String?, BuildContext)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? errorMaxLines;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final bool obscureText;
  final int? minLines;
  final FocusNode? focusNode;
  final bool? isBoxShadow;
  final InputBorder? errorInputBorder;
  final bool isPrefixValueShow;
  final bool hintAsValue;
  final BoxConstraints? prefixIconConstraints;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
          color: (fillColor != null)
              ? fillColor ?? AppColors.white
              : AppColors.white),
      borderRadius: BorderRadius.circular(getSize(10)),
    );
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: (fillColor != null)
              ? fillColor ?? AppColors.white
              : AppColors.white),
      borderRadius: BorderRadius.circular(getSize(10)),
    );
    final errorBorder = errorInputBorder ??
        OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(getSize(10)),
        );
    if (focusNode != null) {
      return getCommonTextFieldMethod(
          context, border, focusedBorder, errorBorder);
    } else {
      return getCommonTextFieldMethod(
          context, border, focusedBorder, errorBorder);
    }
  }

  Column getCommonTextFieldMethod(
      BuildContext context,
      OutlineInputBorder border,
      OutlineInputBorder focusedBorder,
      InputBorder errorBorder) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: EdgeInsets.only(
                left: getSize((isLabelPadding == true) ? 18 : 0)),
            child: Row(
              children: [
                BaseText(
                  text: labelText ?? "",
                  fontSize: labelStyle?.fontSize ?? 14,
                  fontWeight: FontWeight.w500,
                  textColor: labelStyle?.color ?? Color(0xff030202),
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
          SizedBox(height: getSize(8)),
        ],
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(10)),
            boxShadow: [
              if (isBoxShadow == true)
                BoxShadow(
                  color: AppColors.lightGrey.withOpacity(0.2),
                  blurRadius: 30,
                )
            ],
          ),
          // elevation: 0.3,
          child: TextFormField(
            validator: (inputString) {
              return validator?.call(inputString, context);
            },
            maxLength: maxLength,
            scrollPadding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom +
                    getFontSize(14) * 4),
            autofocus: autofocus,
            readOnly: readOnly,
            inputFormatters: inputFormatters,
            minLines: minLines,
            focusNode: focusNode,
            onTap: onTap,
            onChanged: onChanged,
            initialValue: initialValue,
            obscureText: obscureText,
            controller: controller,
            cursorColor: AppColors.primaryColor,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            maxLines: maxLines,
            decoration: decoration?.copyWith(
                  counterStyle: const TextStyle(
                      // height: double.minPositive,
                      ),
                  filled: true,
                  fillColor: AppColors.extraLightGrey,
                  // isDense: true,
                  border: border,
                  enabledBorder: border,
                  focusedBorder: focusedBorder,
                  focusedErrorBorder: errorBorder,
                  errorBorder: errorBorder,
                  hintStyle: TextStyle(
                      color: hintAsValue
                          ? AppColors.black
                          : AppColors.black.withOpacity(0.50),
                      fontSize: getSize(
                        14,
                      ),
                      fontWeight: FontWeight.w500),
                ) ??
                InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: fillColor ?? AppColors.white,
                  hintText: hintText,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: getSize(12),
                    horizontal: getSize(20),
                  ),
                  isDense: true,
                  alignLabelWithHint: true,
                  border: border,
                  enabledBorder: border,
                  errorMaxLines: errorMaxLines,
                  prefixIcon: prefixIcon,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: getSize(10)),
                    child: suffixIcon,
                  ),
                  suffixIconConstraints:
                      BoxConstraints(maxWidth: getSize(80), minHeight: 0),
                  focusedBorder: focusedBorder,
                  focusedErrorBorder: errorBorder,
                  errorBorder: errorBorder,
                  errorStyle: TextStyle(
                    color: AppColors.red,
                    fontSize: getFontSize(11),
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIconConstraints: prefixIconConstraints,
                  //     BoxConstraints(maxWidth: getSize(79), minHeight: 0),
                  hintStyle: TextStyle(
                    color: hintAsValue
                        ? AppColors.black
                        : AppColors.black.withOpacity(0.5),
                    fontSize: getFontSize(hintAsValue ? 13 : 14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
            style: readOnly
                ? Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.lightGrey)
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
