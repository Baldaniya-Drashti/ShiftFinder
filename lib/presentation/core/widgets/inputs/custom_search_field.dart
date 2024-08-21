// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

class DebouncingTextField extends StatefulWidget {
  const DebouncingTextField({
    super.key,
    this.delay = const Duration(milliseconds: 500),
    required this.onSearch,
    this.hintText,
    this.labelText,
    this.labelStyle,
    this.isShowLabel = true,
  });

  final Duration delay;

  final Function(String query) onSearch;
  final String? hintText;
  final TextStyle? labelStyle;
  final String? labelText;
  final bool isShowLabel;

  @override
  State<DebouncingTextField> createState() => _DebouncingTextFieldState();
}

class _DebouncingTextFieldState extends State<DebouncingTextField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(widget.delay, () {
      /// use this to Hide keyboard after refresh the
      // FocusManager.instance.primaryFocus?.unfocus();
      widget.onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getSize(14), vertical: getSize(14)),
        child: SvgPicture.asset(
          SvgImageConstant.search,
          height: getSize(24),
          width: getSize(24),
          color: AppColors.primaryColor,
        ),
      ),
      onChanged: _onSearchChanged,
      hintText: widget.hintText ?? StringConstant.jobRole,
      labelText: widget.isShowLabel
          ? widget.labelText ?? StringConstant.searchByJobRole
          : null,
      labelStyle: widget.labelStyle,
    );
  }
}
