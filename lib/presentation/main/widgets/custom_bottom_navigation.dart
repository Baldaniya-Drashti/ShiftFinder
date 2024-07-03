// ignore_for_file: prefer_const_constructors, must_be_immutable, deprecated_member_use

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/main_tab/main_tab_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class CustomBottomNavigationWidget extends StatelessWidget {
  CustomBottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainTabBloc, MainTabState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Theme(
          data: ThemeData(
            splashFactory: NoSplash.splashFactory,
          ),
          child: AnimatedBottomNavigationBar.builder(
            itemCount: 4,
            activeIndex: state.selectedTab,
            onTap: (index) {
              context.read<MainTabBloc>().add(MainTabEvent.tabChange(index));
            },
            tabBuilder: (index, isActive) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    tabIconList[index],
                    height: getSize(24),
                    width: getSize(24),
                    color: isActive ? AppColors.primaryColor : AppColors.black,
                  ),
                  SizedBox(
                    height: getSize(5),
                  ),
                  BaseText(
                    text: tabLabelList[index],
                    fontSize: 12,
                    fontFamily: "Sarabun",
                    textColor: isActive
                        ? AppColors.primaryColor
                        : AppColors.black.withOpacity(0.50),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              );
            },
            height: getSize(90),
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.sharpEdge,
            shadow: BoxShadow(
              color: AppColors.lightGrey,
              blurRadius: getSize(15),
              blurStyle: BlurStyle.normal,
            ),
            leftCornerRadius: 32,
            rightCornerRadius: 32,
          ),
        );
      },
    );
  }

  List tabIconList = [
    SvgImageConstant.email,
    SvgImageConstant.email,
    SvgImageConstant.email,
    SvgImageConstant.email,
  ];

  List<String> tabLabelList = [
    "Home",
    "History",
    "Notification",
    "Profile",
  ];
}
