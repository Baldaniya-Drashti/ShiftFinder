// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class CustomPinField extends StatelessWidget {
  const CustomPinField({
    Key? key,
    this.onDone,
    this.length = 4,
    this.labelWidget,
    this.autofocus = false,
    this.validator,
    this.onChanged,
    this.onCompleted,
    this.controller,
  }) : super(key: key);

  final Function(String)? onDone;
  final int length;
  final bool autofocus;
  final Widget? labelWidget;
  final Function(String)? onChanged;
  final String? Function(String?, BuildContext)? validator;
  final Function(String)? onCompleted;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (labelWidget != null) ...[
          labelWidget ?? Container(),
          SizedBox(height: getSize(8)),
        ],
        PinCodeTextField(
          appContext: context,
          length: 4,
          animationType: AnimationType.fade,
          hintCharacter: '0',
          errorTextMargin: EdgeInsets.only(top: getSize(10)),
          cursorHeight: getSize(20),
          textStyle: TextStyle(
            fontFamily: 'Sarabun',
            letterSpacing: 0.5,
            color: AppColors.black,
            fontSize: getFontSize(14),
            fontWeight: FontWeight.w400,
          ),
          enableActiveFill: true,
          errorTextSpace: getSize(30),
          validator: (inputString) {
            return validator?.call(inputString, context);
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(getSize(10)),
            fieldHeight: getSize(45),
            fieldWidth: getSize(45),
            activeFillColor: AppColors.white,
            inactiveFillColor: AppColors.white,
            selectedFillColor: AppColors.white,
            // disabledColor: AppColors.white,
            activeBorderWidth: 0,
            selectedBorderWidth: 0,
            borderWidth: 0,
            errorBorderWidth: 0,
            inactiveBorderWidth: 0,
            disabledBorderWidth: 0,
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.black.withOpacity(0.2),
            selectedColor: AppColors.primaryColor.withOpacity(0.2),
            errorBorderColor: AppColors.red,
          ),
          cursorColor: AppColors.primaryColor,
          controller: controller,
          keyboardType: TextInputType.number,
          onCompleted: onCompleted,
          onChanged: onChanged,
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste ");

            return true;
          },
        ),
      ],
    );
  }
}
