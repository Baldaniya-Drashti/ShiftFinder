import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class AcceptRejectDialog extends StatelessWidget {
  final String title;

  final String description;
  final String acceptButtonText;
  final String rejectButtonText;
  final Widget? otherContent;
  final Function() onPressedAccept;
  final Function() onPressedReject;

  const AcceptRejectDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onPressedAccept,
      required this.onPressedReject,
      this.acceptButtonText = StringConstant.accept,
      this.rejectButtonText = StringConstant.cancle,
      this.otherContent});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  acceptRejectDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        elevation: 0,
        backgroundColor: AppColors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: getSize(17)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(15)),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(25)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: getSize(30),
              ),
              BaseText(
                text: title,
                fontSize: 22,
                fontFamily: 'Aclonica',
              ),
              SizedBox(
                height: getSize(10),
              ),
              BaseText(
                text: description,
                fontSize: 14,
                showFullDescription: true,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              otherContent ?? SizedBox(),
              SizedBox(
                height: getSize(30),
              ),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      backgroundColor: AppColors.white,
                      borderColor: AppColors.green,
                      buttonTextColor: AppColors.green,
                      onPressed: onPressedReject,
                      buttonText: rejectButtonText,
                    ),
                  ),
                  SizedBox(width: getSize(25)),
                  Expanded(
                    child: CommonButton(
                      onPressed: onPressedAccept,
                      buttonText: acceptButtonText,
                    ),
                  ),
                ],
              ),
              SizedBox(height: getSize(25)),
            ],
          ),
        ),
      ),
    );
  }
}
