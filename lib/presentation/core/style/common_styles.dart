import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

TextStyle commonErrorStyle() {
  return TextStyle(
    fontSize: getFontSize(12),
    color: AppColors.red,
    fontWeight: FontWeight.w500,
  );
}
