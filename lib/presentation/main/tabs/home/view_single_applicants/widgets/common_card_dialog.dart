// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class CommonCardDialog extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String buttonText;
  final Function() onPressed;
  final bool barrierDismissible;
  final Widget? otherContent;
  final EdgeInsets? insetPadding;
  final Function(dynamic)? onCallback;

  const CommonCardDialog({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
    this.otherContent,
    this.insetPadding,
    this.barrierDismissible = true,
    this.onCallback,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  addCardDialog(BuildContext context) async {
    showDialog<bool?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        clipBehavior: Clip.none,
        insetPadding:
            insetPadding ?? EdgeInsets.symmetric(horizontal: getSize(20)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(15)),
        ),
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(15)),
                  child: Image.asset(PngImageConstants.curvedBackgroundImage),
                ),
                Positioned(
                  top: getSize(85),
                  child: SvgPicture.asset(
                    image,
                    height: getSize(107),
                    width: getSize(107),
                  ),
                ),
              ],
            ),
            SizedBox(height: getSize(90)),
            BaseText(
              text: title,
              fontSize: 22,
              fontFamily: 'Aclonica',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: getSize(10)),
            BaseText(
              text: description,
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black.withOpacity(0.7),
            ),
            otherContent ?? Container(),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          CommonButton(
            height: 46,
            width: 200,
            onPressed: onPressed,
            buttonText: buttonText,
          ),
        ],
      ),
    ).then((value) {
      if (onCallback != null) {
        onCallback!.call(value);
      }
    });
  }
}
