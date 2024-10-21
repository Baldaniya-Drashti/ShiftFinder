import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/auth/auth_value_objects.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/utils/app_focus.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/rating_bar.dart';

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
            insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
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
    Color? deleteColor,
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
            content: SingleChildScrollView(
              child: Column(
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
            ),
            elevation: 80,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
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
                  Gap(getSize(8)),
                  Flexible(
                    child: CommonButton(
                      backgroundColor: deleteColor,
                      onPressed: () {
                        if (onDeleteClick != null) {
                          onDeleteClick.call();
                        }
                        AppFocus.unfocus(context);
                      },
                      width: 150,
                      buttonText: deleteBtnText ?? StringConstant.delete,
                    ),
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
            insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
            actions: [
              CommonButton(
                onPressed: () {
                  if (onOkClick != null) {
                    onOkClick.call();
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
          insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
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
      },
    );
  }

  static Future<void> showLeaveRatingModal(
    BuildContext context, {
    int? defaultRating,
    required ValueSetter<int> onSubmit,
  }) async {
    int rating = defaultRating ?? 0;
    final result = await showDialog<bool?>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          clipBehavior: Clip.hardEdge,
          actionsAlignment: MainAxisAlignment.center,
          insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
          titlePadding: EdgeInsets.zero,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(PngImageConstants.leaveRating),
              Gap(getSize(20)),
              BaseText(
                text: "Leave a Rating",
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
                text:
                    "Your feedback is valuable! Please rate [contractor name] to help showcase their performance and maintain service quality.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                textColor: AppColors.black.withOpacity(0.7),
              ),
              Gap(getSize(20)),
              RatingBar(
                initialRating: rating,
                onChanged: (int value) {
                  rating = value;
                },
              )
            ],
          ),
          actions: [
            CommonButton(
              onPressed: () => context.router.maybePop(true),
              width: 200,
              buttonText: "Submit",
            )
          ],
        );
      },
    );

    if (result ?? false) {
      onSubmit(rating);
    }
  }

  static Future<bool?> showCommonDialog({
    required BuildContext context,
    required String? title,
    required String? content,
    required String? successLabel,
  }) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        clipBehavior: Clip.hardEdge,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
        title: title != null
            ? BaseText(
                text: title,
                fontSize: 22,
                fontWeight: FontWeight.w400,
                fontFamily: "Aclonica",
                textAlign: TextAlign.center,
              )
            : null,
        content: content != null
            ? BaseText(
                text: content,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                textColor: AppColors.black.withOpacity(0.7),
                maxLines: 20,
              )
            : null,
        actions: [
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onPressed: () => context.router.maybePop(false),
                  buttonText: "Cancel",
                  backgroundColor: AppColors.white,
                  borderColor: AppColors.green,
                  buttonTextColor: AppColors.green,
                ),
              ),
              Gap(16),
              Expanded(
                child: CommonButton(
                  onPressed: () => context.router.maybePop(true),
                  buttonText: successLabel ?? "Done",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<void> showUrgentActionDialog(
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
            title: Stack(
              alignment: Alignment.topCenter,
              children: [
                BaseText(
                  text: title ?? "",
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Aclonica",
                  textAlign: TextAlign.center,
                ),
                Positioned(
                  right: 0,
                  child: CloseButton(),
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
            insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
            actions: [
              CommonButton(
                onPressed: () {
                  if (onDeleteClick != null) {
                    onDeleteClick.call();
                  }
                  AppFocus.unfocus(context);
                },
                buttonText: deleteBtnText ?? StringConstant.delete,
              ),
              SizedBox(height: getSize(10)),
              CommonButton(
                onPressed: () {
                  if (onCancelClick != null) {
                    onCancelClick.call();
                  }
                  AppFocus.unfocus(context);
                },
                buttonText: cancelText ?? StringConstant.cancle,
                backgroundColor: AppColors.white,
                buttonTextColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
              ),
            ],
          );
        });
  }
}

class AddRemarkModal extends StatefulWidget {
  const AddRemarkModal({super.key, this.initialValue});

  final String? initialValue;

  @override
  State<AddRemarkModal> createState() => _AddRemarkModalState();
}

class _AddRemarkModalState extends State<AddRemarkModal> {
  late TextEditingController _controller;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      actionsAlignment: MainAxisAlignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
      title: BaseText(
        text: "Add a Remark",
        fontSize: 22,
        fontWeight: FontWeight.w400,
        fontFamily: "Aclonica",
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseText(
            text:
                "Please enter your comments or feedback about the contractor. This remark will be visible only to you and is intended for your review.",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            textColor: AppColors.black.withOpacity(0.7),
          ),
          Gap(getSize(20)),
          BaseText(text: "Comment", fontSize: 12),
          Gap(getSize(8)),
          Form(
            key: _formKey,
            child: CustomTextField(
              autoValidateMode: AutovalidateMode.onUserInteraction,
              controller: _controller,
              maxLines: 5,
              hintText: "Type here",
              fillColor: AppColors.scaffoldColor,
              validator: (value, p1) {
                if ((value == null) || value.isEmpty) {
                  return "Please add remark";
                }
                return null;
              },
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: CommonButton(
                onPressed: () => context.router.maybePop(),
                buttonText: "Cancel",
                backgroundColor: AppColors.white,
                borderColor: AppColors.green,
                buttonTextColor: AppColors.green,
              ),
            ),
            Gap(16),
            Expanded(
              child: CommonButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  context.router.maybePop(_controller.text.trim());
                },
                buttonText: "Done",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
