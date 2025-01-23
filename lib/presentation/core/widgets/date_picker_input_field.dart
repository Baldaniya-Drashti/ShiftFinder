import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/document_expiry_picker.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/core/helper/datetime_extensions.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

import 'inputs/custom_text_field.dart';

class DatePickerInputField extends StatefulWidget {
  const DatePickerInputField({
    super.key,
    required this.label,
    required this.hint,
    this.initialDate,
    required this.onPickedDate,
    this.firstDate,
    this.lastDate,
    this.validator,
  });

  final String label;
  final String hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime date) onPickedDate;
  final String? Function(String? value, BuildContext context)? validator;

  @override
  State<DatePickerInputField> createState() => _DatePickerInputFieldState();
}

class _DatePickerInputFieldState extends State<DatePickerInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialDate != null ? widget.initialDate!.formattedString : "",
    );
  }

  @override
  void didUpdateWidget(covariant DatePickerInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    Timer.run(
      () {
        if (widget.initialDate != oldWidget.initialDate) {
          _controller.text = widget.initialDate != null ? widget.initialDate!.formattedString : "";
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      controller: _controller,
      validator: widget.validator,
      labelText: widget.label,
      hintText: widget.hint,
      hintAsValue: widget.initialDate != null,
      readOnly: true,
      errorInputBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(14),
          vertical: getSize(14),
        ),
        child: SvgPicture.asset(SvgImageConstant.calendar, height: getSize(24), width: getSize(24)),
      ),
      onTap: () async {
        await DocumentExpiryDatePicker.customDatePicker(
          context,
          firstDate: widget.firstDate ?? DateTime.now(),
          onPickedDate: widget.onPickedDate,
          onCancelClick: () {},
          selectedDate: widget.initialDate ?? DateTime.now(),
        );
      },
    );
  }
}
