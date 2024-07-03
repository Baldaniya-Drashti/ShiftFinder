// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/main_tab_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainTabBloc, MainTabState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(19.5)),
          child: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.scaffoldColor,
            elevation: 0,
            leading: CircleAvatar(
              // minRadius: getSize(50),
              child: Image.asset(
                PngImageConstants.homeAppBarLogo,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: "Welcome!",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Aclonica",
                  textColor: AppColors.black.withOpacity(0.7),
                ),
                BaseText(
                  text: "Cameron Williamson",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Aclonica",
                ),
              ],
            ),
            actions: [
              SvgPicture.asset(
                SvgImageConstant.twoPerson,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(getSize(70));
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  VoidCallback onBackPressed;
  String title;
  TextStyle? textStyle;
  Color? iconColor;
  bool isShowBackBtn;
  CommonAppBar({
    super.key,
    required this.onBackPressed,
    required this.title,
    this.textStyle,
    this.iconColor,
    this.isShowBackBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: (isShowBackBtn)
          ? Padding(
              padding: EdgeInsets.only(left: getSize(20)),
              child: GestureDetector(
                onTap: onBackPressed,
                child: SvgPicture.asset(
                  SvgImageConstant.back,
                  color: iconColor ?? AppColors.black,
                ),
              ),
            )
          : null,
      leadingWidth: getSize(44),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: BaseText(
        text: title,
        fontSize: textStyle?.fontSize ?? 16,
        fontWeight: textStyle?.fontWeight ?? FontWeight.w400,
        textColor: textStyle?.color ?? AppColors.black,
        fontFamily: textStyle?.fontFamily ?? "Aclonica",
      ),
    );

    // Row(
    //   children: [
    //     GestureDetector(
    //       onTap: onBackPressed,
    //       child: SvgPicture.asset(
    //         SvgImageConstant.back,
    //         color: iconColor ?? AppColors.black,
    //       ),
    //     ),
    //     SizedBox(
    //       width: getSize(73),
    //     ),
    //     BaseText(
    //       text: title,
    //       fontSize: textStyle?.fontSize ?? 16,
    //       fontWeight: textStyle?.fontWeight ?? FontWeight.w400,
    //       textColor: textStyle?.color ?? AppColors.black,
    //       fontFamily: textStyle?.fontFamily ?? "Aclonica",
    //     ),
    //   ],
    // );
  }

  @override
  Size get preferredSize => Size.fromHeight(getSize(70));
}
