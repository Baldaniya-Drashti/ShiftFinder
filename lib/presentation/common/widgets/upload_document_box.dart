// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class UploadDocumentBox extends StatelessWidget {
  VoidCallback onUploadBtnPressed;
  double? height;
  UploadDocumentBox({required this.onUploadBtnPressed, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.grey04,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(66),
            width: getSize(58),
            child: Image.asset(
              PngImageConstants.upload,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CommonButton(
            onPressed: onUploadBtnPressed,
            width: 140,
            height: 28,
            backgroundColor: AppColors.primaryColor.withOpacity(0.15),
            borderRadius: 5,
            buttonText: StringConstant.upload,
            customWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  SvgImageConstant.upload,
                ),
                SizedBox(
                  width: getSize(10),
                ),
                BaseText(
                  text: StringConstant.upload,
                  fontSize: 12,
                  textAlign: TextAlign.center,
                  //maxLines: 1,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
