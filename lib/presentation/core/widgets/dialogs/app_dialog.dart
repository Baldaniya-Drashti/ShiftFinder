import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
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
    int? maxLines,
    void Function()? onPressed,
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
              maxLines: maxLines,
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
                onPressed: onPressed ??
                    () {
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
    String? cancelText,
    String? deleteBtnText,
    Widget? otherContent,
    bool barrierDismissible = false,
    required VoidCallback? onCancelClick,
    required VoidCallback? onDeleteClick,
  }) async {
    showDialog(
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
                  textColor: AppColors.black.withOpacity(0.7),
                  maxLines: 20,
                ),
                otherContent ?? Container()
              ],
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
                    onPressed: () {
                      if (onCancelClick != null) {
                        onCancelClick.call();
                      }
                      AppFocus.unfocus(context);
                    },
                    width: 150,
                    buttonText: cancelText ?? StringConstant.cancle,
                    backgroundColor: AppColors.white,
                    buttonTextColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                  ),
                  CommonButton(
                    onPressed: () {
                      if (onDeleteClick != null) {
                        onDeleteClick.call();
                      }
                      AppFocus.unfocus(context);
                    },
                    width: 150,
                    buttonText: deleteBtnText ?? StringConstant.delete,
                  )
                ],
              ),
            ],
          );
        });
  }

  static Future<void> showSuccess(
    BuildContext context, {
    String? title,
    String? buttonText,
    required String infoMessage,
    EdgeInsets? insetPadding,
    Widget? image,
    Widget? otherContent,
    bool barrierDismissible = false,
    required VoidCallback? onOkClick,
  }) async {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            title: Column(
              children: [
                (image != null)
                    ? image
                    : Image.asset(
                        PngImageConstants.thumbsUp,
                      ),
                SizedBox(
                  height: getSize(20),
                ),
                BaseText(
                  text: title ?? "",
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Aclonica",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: infoMessage,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                otherContent ?? Container()
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
                  }
                  AppFocus.unfocus(context);
                },
                width: 200,
                buttonText: buttonText??StringConstant.ok,
              ),
            ],
          );
        });
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

  static Future<void> showWithDrawIInfo(
    BuildContext context, {
    EdgeInsets? insetPadding,
    String? cancelText,
    String? deleteBtnText,
    bool barrierDismissible = false,
    required VoidCallback? onCancelClick,
    required VoidCallback? onDeleteClick,
  }) async {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
            title: BaseText(
              text: StringConstant.withdrawShift,
              fontSize: 22,
              fontWeight: FontWeight.w400,
              fontFamily: "Aclonica",
              textAlign: TextAlign.center,
            ),
            content: BaseText(
              text: StringConstant.withdrawShiftDesc,
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
                    onPressed: () {
                      if (onCancelClick != null) {
                        onCancelClick.call();
                      }
                      AppFocus.unfocus(context);
                    },
                    width: 150,
                    buttonText: cancelText ?? StringConstant.cancle,
                    backgroundColor: AppColors.white,
                    buttonTextColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                  ),
                  CommonButton(
                    onPressed: () {
                      if (onDeleteClick != null) {
                        onDeleteClick.call();
                      }
                      AppFocus.unfocus(context);
                    },
                    width: 150,
                    buttonText: deleteBtnText ?? StringConstant.delete,
                  )
                ],
              ),
            ],
          );
        });
  }
}
