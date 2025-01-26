import 'dart:async';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ActionIcon extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final VisualDensity? visualDensity;
  final String? tooltip;
  final double? iconSize;
  final double? splashRadius;

  const ActionIcon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.visualDensity = VisualDensity.compact,
    this.tooltip,
    this.iconSize,
    this.splashRadius,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: onPressed,
      visualDensity: visualDensity,
      tooltip: tooltip,
      iconSize: iconSize,
      splashRadius: splashRadius,
    );
  }
}

class CustomDropdownField<T> extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.onChanged,
    required this.value,
    required this.items,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.hintTextStyle,
    this.radius,
    this.label,
    this.fontSize,
    this.selectedItemBuilder,
  });

  // final ValueChanged<T?> onChanged;
  final void Function(dynamic) onChanged;
  final T? value;
  final List<DropdownMenuItem<T?>> items;
  final FormFieldValidator<dynamic>? validator;
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? radius;
  final String? label;
  final double? fontSize;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final ValueNotifier<bool> _isMenuOpened = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: BaseText(text: widget.label!, fontSize: widget.fontSize ?? 10, fontWeight: FontWeight.w500),
              ),
              Gap(8),
            ],
            DropdownButtonFormField2(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hint: Text(
                widget.hintText ?? "",
                style: widget.hintTextStyle,
              ),
              isDense: true,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
              isExpanded: true,
              menuItemStyleData: const MenuItemStyleData(
                height: 45,
                padding: EdgeInsets.only(left: 0, right: 14),
              ),
              selectedItemBuilder: widget.selectedItemBuilder,
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                padding: EdgeInsets.only(left: 12),
                offset: const Offset(0, -8),
                elevation: 1,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
              ),
              iconStyleData: IconStyleData(
                icon: ValueListenableBuilder(
                  valueListenable: _isMenuOpened,
                  builder: (context, value, child) => AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    transform: Matrix4.rotationZ(_isMenuOpened.value ? pi / 1 : 0),
                    transformAlignment: Alignment.center,
                    child: SvgPicture.asset(
                      height: 8,
                      SvgImageConstant.downArrow,
                      colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                contentPadding: EdgeInsets.only(right: 16, top: 12, bottom: 10),
                isDense: true,
                errorStyle: TextStyle(),
                focusedBorder: OutlineInputBorder(
                  borderSide: field.hasError ? BorderSide(color: AppColors.red) : BorderSide.none,
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.red),
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: field.hasError ? BorderSide(color: AppColors.red) : BorderSide.none,
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.red),
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.red),
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.red),
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
              ),
              value: widget.value,
              onMenuStateChange: (isOpen) => _isMenuOpened.value = isOpen,
              onChanged: (value) {
                widget.onChanged(value);
                field.didChange(value);
              },
              items: widget.items,
            ),
            if (field.hasError) ...[
              Gap(4),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: BaseText(
                  text: field.errorText.toString(),
                  textColor: AppColors.red,
                  fontSize: getFontSize(11),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}

class ShiftScheduleDropdownField extends StatefulWidget {
  const ShiftScheduleDropdownField({
    super.key,
    required this.onChanged,
    required this.selectedShiftSchedule,
  });

  final Function(CommonDropdownModel value) onChanged;
  final CommonDropdownModel? selectedShiftSchedule;

  @override
  State<ShiftScheduleDropdownField> createState() => _ShiftScheduleDropdownFieldState();
}

class _ShiftScheduleDropdownFieldState extends State<ShiftScheduleDropdownField> {
  @override
  void didUpdateWidget(covariant ShiftScheduleDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedShiftSchedule != oldWidget.selectedShiftSchedule) {}
  }

  @override
  Widget build(BuildContext context) {
    final List<CommonDropdownModel> list = [
      CommonDropdownModel(id: 1, label: "Morning"),
      CommonDropdownModel(id: 2, label: "Evening"),
      CommonDropdownModel(id: 3, label: "Night"),
      CommonDropdownModel(id: 4, label: "Weekends"),
      CommonDropdownModel(id: 5, label: "Weekdays"),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        boxShadow: [BoxShadow(color: AppColors.lightGrey.withOpacity(0.2), blurRadius: 30)],
      ),
      child: CustomDropdownField<CommonDropdownModel>(
        validator: (value) {
          if (value == null) return "Please select shift schedule";
          return null;
        },
        hintText: "Shift Schedule",
        fontSize: 13,
        label: "Shift Schedule",
        hintTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.black.withOpacity(0.5),
        ),
        onChanged: (value) => widget.onChanged(value as CommonDropdownModel),
        value: widget.selectedShiftSchedule,
        items: list.map(
          (e) {
            return DropdownMenuItem<CommonDropdownModel>(
              value: e,
              child: BaseText(text: e.label, fontSize: 14, fontWeight: FontWeight.w500),
            );
          },
        ).toList(),
      ),
    );
  }
}

class CustomFormFieldExample extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormField Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom FormField for Checkbox
              FormField<bool>(
                initialValue: false,
                validator: (value) {
                  if (value != true) {
                    return 'You must accept the terms.';
                  }
                  return null;
                },
                builder: (FormFieldState<bool> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: state.value,
                            onChanged: (bool? newValue) {
                              state.didChange(newValue);
                            },
                          ),
                          const Text('Accept terms and conditions'),
                        ],
                      ),
                      if (state.hasError)
                        Text(
                          state.errorText ?? '',
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully!')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
