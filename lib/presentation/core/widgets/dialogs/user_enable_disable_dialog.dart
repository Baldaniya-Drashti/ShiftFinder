import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class UserEnableDisableDialog {
  static Future<bool?> showEnableDisableDialog(
    BuildContext context, {
    String? title,
    String? buttonText,
    required String infoMessage,
    EdgeInsets? insetPadding,
    Widget? image,
    Widget? otherContent,
    bool barrierDismissible = false,
    VoidCallback? onOkClick,
  }) async {
    return showDialog<bool?>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
            title: BaseText(
              text: title ?? "",
              fontSize: 22,
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: infoMessage,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  textColor: AppColors.black.withValues(alpha: 0.7),
                ),
                otherContent ?? Container(),
              ],
            ),
            elevation: 80,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            insetPadding:
                insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
            actions: [
              CommonButton(
                onPressed: () {
                  if (onOkClick != null) {
                    onOkClick.call();
                  } else {
                    context.router.maybePop(true);
                  }
                  AppFocus.unfocus(context);
                },
                width: 200,
                buttonText: buttonText ?? StringConstant.ok,
              ),
            ],
          );
        });
  }
}
