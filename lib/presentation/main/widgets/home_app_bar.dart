// ignore_for_file: prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_main_bloc.dart';
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
        return PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                getSize(19.5), getSize(15), getSize(19.5), 0),
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
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(
                    height: getSize(5),
                  ),
                )),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(getSize(70));
}

class ContractorHomeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  Widget? titleWidget;
  List<Widget>? actions;
  Widget? leading;
  String? titleText;
  bool showAppBar;

  ContractorHomeAppBar({
    super.key,
    this.actions,
    this.leading,
    this.titleWidget,
    this.titleText,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return (!showAppBar)
        ? Container()
        : BlocBuilder<ContractorMainTabBloc, ContractorMainTabState>(
            builder: (context, state) {
              return Container(
                color: AppColors.scaffoldColor,
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
                  automaticallyImplyLeading: true,
                  actions: actions,
                ),
              );
            },
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(getSize((!showAppBar) ? 0 : 70));
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
  final PreferredSizeWidget? bottom;

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
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(

      bottom: bottom,
      forceMaterialTransparency: forceMaterialTransparency,
      scrolledUnderElevation: 0,
      leading: (isShowBackBtn != null && isShowBackBtn == true)
          ? GestureDetector(
              onTap: onBackPressed,
              child: Container(
                color: AppColors.transparent,
                padding: EdgeInsets.only(left: getSize(20)),
                child: GestureDetector(
                  onTap: null,
                  child: SvgPicture.asset(
                    SvgImageConstant.back,
                    color: iconColor ?? AppColors.black,
                  ),
                ),
              ),
            )
          : null,
      leadingWidth: getSize(44),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.scaffoldColor,
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
                child: Container(
                  color: AppColors.transparent,
                  padding: EdgeInsets.only(
                      right: getSize(20),
                      left: getSize(10),
                      top: getSize(10),
                      bottom: getSize(10)),
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
