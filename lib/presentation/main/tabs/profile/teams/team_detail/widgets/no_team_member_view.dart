// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class NoTeamMemberView extends StatelessWidget {
  final String teamID;
  void Function() addMemberPressed;
  NoTeamMemberView(
      {super.key, required this.teamID, required this.addMemberPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Opacity(
          opacity: 0.5,
          child: Image.asset(
            PngImageConstants.teamImage,
            height: getSize(90),
            width: getSize(110),
          ),
        ),
        SizedBox(
          height: getSize(30),
        ),
        BaseText(
          text: 'Heads Up!',
          fontSize: 22,
          fontFamily: 'Aclonica',
        ),
        SizedBox(
          height: getSize(10),
        ),
        BaseText(
          text:
              'No team members have been added yet.\nPlease click the \'Add Team Members\'\nbutton to get started.',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          textColor: AppColors.black.withOpacity(0.7),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: getSize(70),
        ),
        CommonButton(
          height: 28,
          width: 170,
          onPressed: addMemberPressed,
          backgroundColor: AppColors.green.withOpacity(0.15),
          buttonText: '+ Add Team Member',
          buttonTextColor: AppColors.green,
          buttonFontSize: 12,
          borderRadius: 7,
          buttonFontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
