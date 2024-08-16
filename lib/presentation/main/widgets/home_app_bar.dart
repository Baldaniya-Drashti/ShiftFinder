// ignore_for_file: prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/main_tab/main_tab_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  Widget? titleWidget;
  List<Widget>? actions;
  Widget? leading;
  String? titleText;

  HomeAppbar(
      {super.key,
      this.actions,
      this.leading,
      this.titleWidget,
      this.titleText});

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
            leading: leading ?? Container(),
            centerTitle: (titleText != null) ? true : false,
            title: (titleText != null)
                ? BaseText(
                    text: titleText!,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Aclonica",
                  )
                : titleWidget ?? Container(),
            actions: actions,
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
  bool? isShowBackBtn;
  SystemUiOverlayStyle? systemOverlayStyle;
  List<Widget>? actions;
  bool showSkipBtn;
  bool forceMaterialTransparency;
  VoidCallback? onSkipped;

  CommonAppBar({
    super.key,
    required this.onBackPressed,
    required this.title,
    this.textStyle,
    this.iconColor,
    this.isShowBackBtn = true,
    this.systemOverlayStyle,
    this.actions,
    this.showSkipBtn = false,
    this.forceMaterialTransparency = true,
    this.onSkipped,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: forceMaterialTransparency,
      leading: (isShowBackBtn != null && isShowBackBtn == true)
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
      backgroundColor: AppColors.scaffoldColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
      title: BaseText(
        text: title,
        textAlign: TextAlign.center,
        fontSize: textStyle?.fontSize ?? 16,
        fontWeight: textStyle?.fontWeight ?? FontWeight.w400,
        textColor: textStyle?.color ?? AppColors.black,
        fontFamily: textStyle?.fontFamily ?? "Aclonica",
      ),
      actions: (showSkipBtn)
          ? [
              GestureDetector(
                onTap: onSkipped,
                child: Padding(
                  padding: EdgeInsets.only(right: getSize(10)),
                  child: BaseText(
                    text: StringConstant.skip,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.primaryColor,
                  ),
                ),
              ),
            ]
          : actions,
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
