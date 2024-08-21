// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:badges/badges.dart' as badges;

class ChatButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int badgeCount;
  final Widget? customWidget;

  const ChatButton(
      {super.key,
      required this.onPressed,
      this.badgeCount = 0,
      this.customWidget});

  @override
  Widget build(BuildContext context) {
    return (badgeCount > 0)
        ? badges.Badge(
            onTap: () {},
            showBadge: (badgeCount > 0),
            badgeContent: BaseText(
              text: "$badgeCount",
              textColor: AppColors.white,
              fontSize: 8,
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: AppColors.primaryColor,
            ),
            child: commonButton(customWidget: customWidget),
          )
        : commonButton(customWidget: customWidget);
  }

  commonButton({Widget? customWidget}) {
    return GestureDetector(
      onTap: onPressed,
      child: customWidget ??
          CommonButton(
            height: getSize(35),
            width: getSize(80),
            borderRadius: 5,
            onPressed: onPressed,
            backgroundColor: (customWidget != null)
                ? AppColors.transparent
                : AppColors.primaryColor.withOpacity(0.15),
            buttonText: "",
            customWidget: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  SvgImageConstant.chat,
                  color: AppColors.black,
                  height: getSize(15),
                  width: getSize(15),
                ),
                SizedBox(width: getSize(5)),
                BaseText(
                  text: StringConstant.chat,
                  fontWeight: FontWeight.w600,
                  fontSize: getFontSize(12),
                ),
              ],
            ),
          ),
    );
  }
}
