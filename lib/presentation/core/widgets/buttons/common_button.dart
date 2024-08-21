// ignore_for_file: use_super_parameters, prefer_const_constructors

import 'dart:async';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  final double borderRadius;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final VoidCallback onPressed;
  final String buttonText;
  final Widget? customWidget;
  final List<BoxShadow>? shadows;
  final Widget? iconWidget;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final double? buttonFontSize;
  final FontWeight? buttonFontWeight;
  final Widget? widget;
  final bool isSubmitting;

  const CommonButton({
    Key? key,
    required this.onPressed,
    this.customWidget,
    this.borderRadius = 30,
    this.width,
    this.height,
    this.shadows,
    this.gradient,
    this.backgroundColor,
    required this.buttonText,
    this.iconWidget,
    this.buttonTextColor,
    this.buttonFontSize,
    this.buttonFontWeight,
    this.borderColor,
    this.widget,
    this.isSubmitting = false,
  }) : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  bool isButtonDisabled = false;
  Timer? buttonTimer;

  void _handleButtonTap() {
    if (!isButtonDisabled) {
      setState(() {
        isButtonDisabled = true;
      });
      AppFocus.unfocus(context);
      widget.onPressed();
      // Enable the button after a specified duration (e.g., 3 seconds).
      buttonTimer = Timer(Duration(seconds: 3), () {
        setState(() {
          isButtonDisabled = false;
        });
      });
    }
  }

  @override
  void dispose() {
    buttonTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          widget.isSubmitting || isButtonDisabled ? null : _handleButtonTap,
      style: ButtonStyle(
        side: WidgetStatePropertyAll(
            BorderSide(color: widget.borderColor ?? Colors.transparent)),
        elevation: WidgetStatePropertyAll(0),
        // shadowColor: WidgetStatePropertyAll(Colors.transparent),
        // splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStatePropertyAll(AppColors.grey04),

        backgroundColor: WidgetStatePropertyAll(
            widget.backgroundColor ?? AppColors.primaryColor),
        // disabledBackgroundColor:widget.backgroundColor ?? AppColors.primaryColor,
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        fixedSize: WidgetStatePropertyAll(Size(
          getSize(widget.width ?? MediaQuery.of(context).size.width * 100),
          // (widget.width != null) ? getSize(widget.width!) : double.infinity,
          getSize(
            widget.height ?? 50,
          ),
        )),
        visualDensity: VisualDensity(
          vertical: VisualDensity.minimumDensity,
          horizontal: VisualDensity.minimumDensity,
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            getSize(widget.borderRadius),
          ),
        )),
      ),
      child: widget.isSubmitting
          ? SizedBox(
              height: getSize(20),
              width: getSize(20),
              child: CircularProgressIndicator(
                color: AppColors.white,
              ),
            )
          : (widget.customWidget != null)
              ? widget.customWidget
              : BaseText(
                  text: widget.buttonText,
                  fontSize: widget.buttonFontSize ?? 16,
                  textAlign: TextAlign.center,
                  //maxLines: 1,
                  fontWeight: widget.buttonFontWeight ?? FontWeight.w600,
                  textColor: widget.buttonTextColor ?? Colors.white,
                ),
    );
  }
}

Widget documentSkipButton(BuildContext context,
    {required VoidCallback onPressed}) {
  return Align(
    alignment: Alignment.center,
    child: CommonButton(
      onPressed: onPressed,
      buttonText: StringConstant.skip,
      height: 40,
      width: 150,
      // borderRadius: 10,
      // buttonFontSize: 12,
      buttonFontWeight: FontWeight.w500,
      backgroundColor: AppColors.transparent,
      buttonTextColor: AppColors.primaryColor,
      borderColor: AppColors.transparent,
    ),
  );
}

class CommonMaterialButton extends StatelessWidget {
  const CommonMaterialButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.height,
    this.width,
    this.backgroundColor,
    this.textStyle,
    this.radius,
    this.padding,
    this.borderColor,
  }) : _icon = null;

  const CommonMaterialButton.icon({
    super.key,
    required this.onPressed,
    required this.label,
    required final Widget icon,
    this.borderColor,
    this.height,
    this.width,
    this.backgroundColor,
    this.textStyle,
    this.radius,
    this.padding,
  }) : _icon = icon;

  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? radius;
  final Color? borderColor;
  final EdgeInsets? padding;
  final Widget? _icon;

  @override
  Widget build(BuildContext context) {
    Widget child;
    final baseTextStyle =
        TextStyle(fontSize: getSize(12), fontWeight: FontWeight.w600);
    final Widget title =
        BaseText(text: label, style: textStyle ?? baseTextStyle);

    if (_icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [_icon, Gap(getSize(6)), title],
      );
    } else {
      child = title;
    }

    return SizedBox(
      height: height ?? 38,
      width: width ?? double.maxFinite,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 0.0),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        color: backgroundColor ?? AppColors.primaryColor,
        elevation: 0.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: padding ?? EdgeInsets.all(getSize(8.0)),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
