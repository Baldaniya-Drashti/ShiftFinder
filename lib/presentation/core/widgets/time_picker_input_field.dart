import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/core/helper/time_extension.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class TimePickerInputField extends StatefulWidget {
  const TimePickerInputField({
    super.key,
    required this.label,
    required this.hint,
    this.initialTime,
    required this.onPickedTime,
    this.validator,
  });

  final String label;
  final String hint;
  final TimeOfDay? initialTime;
  final void Function(TimeOfDay time) onPickedTime;
  final String? Function(String? value, BuildContext context)? validator;

  @override
  State<TimePickerInputField> createState() => _TimePickerInputFieldState();
}

class _TimePickerInputFieldState extends State<TimePickerInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text:
          widget.initialTime != null ? widget.initialTime!.formatTimeOfDay : "",
    );
  }

  @override
  void didUpdateWidget(covariant TimePickerInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    Timer.run(
      () {
        if (widget.initialTime != oldWidget.initialTime) {
          _controller.text = widget.initialTime != null
              ? widget.initialTime!.formatTimeOfDay
              : "";
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
      hintAsValue: widget.initialTime != null,
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
        child: SvgPicture.asset(SvgImageConstant.clock,
            height: getSize(24), width: getSize(24)),
      ),
      onTap: () async {
        final time = await _showTimePicker(context);
        if (time != null) {
          widget.onPickedTime(time);
        }
      },
    );
  }

  Future<TimeOfDay?> _showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData.light().copyWith(
              timePickerTheme: TimePickerThemeData(
                dayPeriodColor: AppColors.primaryColor,
                dayPeriodTextColor: AppColors.black,
              ),
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onSurface: AppColors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(),
              ),
            ),
            child: TimePickerDialog(
              initialTime: TimeOfDay.fromDateTime(DateTime.now()),
            ),
          );
        });

    return pickedTime;
  }
}
