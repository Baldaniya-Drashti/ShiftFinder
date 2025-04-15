// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class OnBoardTile extends StatelessWidget {
  String dpImage;
  String? bgImage;
  String title;
  String? designation;
  bool isTile2;
  OnBoardTile(
      {super.key,
      required this.dpImage,
      this.bgImage = SvgImageConstant.person,
      this.designation = "",
      required this.title,
      this.isTile2 = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (isTile2) ? getSize(80) : getSize(117),
      margin: EdgeInsets.symmetric(
        horizontal: (isTile2) ? 0 : getSize(20),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular((isTile2) ? 10 : 20),
        boxShadow: [
          BoxShadow(
            blurRadius: getSize(25),
            color: AppColors.grey,
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: (isTile2) ? getSize(20) : getSize(15),
      ),
      child: (isTile2) ? onBoardTile2() : onBoardTile1(),
    );
  }

  Widget onBoardTile1() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                width: getSize(87),
                height: getSize(87),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    image: DecorationImage(image: AssetImage(dpImage))),
              ),
              SizedBox(
                width: getSize(20),
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  maxLines: 3,
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: true,
                    applyHeightToLastDescent: false,
                    leadingDistribution: TextLeadingDistribution.proportional,
                  ),
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: getFontSize(11),
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          fontSize: getFontSize(14),
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Aclonica",
                        ),
                      ),
                      TextSpan(
                        text: designation,
                        style: TextStyle(
                          fontSize: getFontSize(14),
                          color: AppColors.black.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                          height: getSize(3),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: getSize(90),
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset(bgImage!),
        ),
      ],
    );
  }

  Widget onBoardTile2() {
    return ListTile(
      leading: SizedBox(
        width: getSize(50),
        child: SvgPicture.asset(dpImage),
      ),
      tileColor: AppColors.white,
      contentPadding: EdgeInsets.zero,
      title: BaseText(
        text: title,
        style: TextStyle(
          fontSize: getFontSize(16),
          color: AppColors.black,
          fontWeight: FontWeight.w400,
          fontFamily: "Aclonica",
        ),
      ),
      trailing: SvgPicture.asset(
        SvgImageConstant.forward,
        height: getSize(30),
        width: getSize(30),
      ),
    );
  }
}
