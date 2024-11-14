import 'dart:async';
import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
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
  });

  // final ValueChanged<T?> onChanged;
  final void Function(dynamic) onChanged;
  final T? value;
  final List<DropdownMenuItem<T?>> items;
  final FormFieldValidator<T?>? validator;
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? radius;
  final String? label;
  final double? fontSize;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  final ValueNotifier<bool> _isMenuOpened = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
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
          hint: Text(
            widget.hintText ?? "",
            style: widget.hintTextStyle,
          ),
          isDense: true,
          validator: widget.validator,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
          isExpanded: true,
          menuItemStyleData: const MenuItemStyleData(
            height: 45,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            padding: EdgeInsets.zero,
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
            contentPadding: EdgeInsets.only(right: 16, top: 10, bottom: 10),
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(widget.radius ?? 6),
            ),
          ),
          value: widget.value,
          onMenuStateChange: (isOpen) => _isMenuOpened.value = isOpen,
          onChanged: widget.onChanged,
          items: widget.items,
        ),
      ],
    );
  }
}
