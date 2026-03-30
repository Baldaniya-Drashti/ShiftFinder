import 'package:another_flushbar/flushbar.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:flutter/material.dart';

Flushbar showError({
  required String message,
  String? title,
  Duration duration = const Duration(seconds: 5),
}) {
  return Flushbar(
    title: title,
    message: message,
    messageColor: AppColors.redAccent,
    icon: const Icon(
      Icons.warning,
      size: 28.0,
      color: Colors.redAccent,
    ),
    backgroundColor: AppColors.backgroundRed,
    duration: duration,
    flushbarPosition: FlushbarPosition.BOTTOM,
  );
}

Flushbar showSuccess({
  required String message,
  String? title,
  Duration duration = const Duration(seconds: 2),
}) {
  return Flushbar(
    title: title,
    message: message,
    icon: const Icon(
      Icons.check_circle,
      color: AppColors.white,
    ),
    leftBarIndicatorColor: AppColors.green,
    backgroundColor: AppColors.green,
    flushbarPosition: FlushbarPosition.BOTTOM,
    duration: duration,
  );
}

Future<dynamic> showUnderDevelopment(BuildContext context) {
  return showSuccess(
    message: "Next Process is under development!!",
  ).show(context);
}
