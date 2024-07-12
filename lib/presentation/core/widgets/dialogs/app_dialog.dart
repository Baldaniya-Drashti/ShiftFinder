import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

/// Shows a dialog.
/// Use in priority cases where it's necessary for the user to see
/// the result as user will need to take action to move forward.
class AppDialog {
  static Future<void> showInfo(
    BuildContext context,
    String infoMessage, {
    EdgeInsets? insetPadding,
  }) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: BaseText(
              text: infoMessage,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
            elevation: 80,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            insetPadding:
                insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              CommonButton(
                onPressed: () {
                  context.router.maybePop();
                },
                width: 200,
                buttonText: StringConstant.ok,
              )
            ],
          );
        });
  }

  static Future<void> showDelete(
    BuildContext context, {
    String? title,
    required String infoMessage,
    EdgeInsets? insetPadding,
    required VoidCallback? onCancelClick,
    required VoidCallback? onDeleteClick,
  }) async {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: BaseText(
              text: title ?? "",
              fontSize: 22,
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
              textAlign: TextAlign.center,
            ),
            content: BaseText(
              text: infoMessage,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              textColor: AppColors.black.withOpacity(0.7),
            ),
            elevation: 80,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            insetPadding:
                insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonButton(
                    onPressed: onCancelClick ?? () {},
                    width: 150,
                    buttonText: StringConstant.cancle,
                    backgroundColor: AppColors.white,
                    buttonTextColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                  ),
                  CommonButton(
                    onPressed: onDeleteClick ?? () {},
                    width: 150,
                    buttonText: StringConstant.delete,
                  )
                ],
              ),
            ],
          );
        });
  }

  static Future<void> showSuccess(
    BuildContext context,
    String successMessage,
  ) async {
    // QuickAlert.show(
    //   context: context,
    //   type: QuickAlertType.success,
    //   text: successMessage,
    // );
  }

  static Future<void> showError(
    BuildContext context,
    String successMessage,
  ) async {
    // QuickAlert.show(
    //   context: context,
    //   type: QuickAlertType.error,
    //   text: successMessage,
    // );
  }
}
