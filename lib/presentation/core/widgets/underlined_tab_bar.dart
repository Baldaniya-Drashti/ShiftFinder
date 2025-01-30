
  import 'package:flutter/material.dart';
  import 'package:shift/domain/core/math_utils.dart';
  import 'package:shift/presentation/core/style/app_colors.dart';

  class UnderlinedTabBar extends StatelessWidget implements PreferredSizeWidget {
    const   UnderlinedTabBar({
      super.key,
      required this.tabs,
      this.onTap,
    });

    final List<Widget> tabs;
    final ValueSetter<int>? onTap;
    static const _kDefaultTabBarHeight = 46.0;

    @override
    Widget build(BuildContext context) {
      final baseTextStyle = TextStyle(fontSize: getFontSize(13), fontWeight: FontWeight.w500, color: AppColors.primaryColor);
      final unselectedLabelStyle = baseTextStyle.copyWith(color: Colors.black.withOpacity(0.5));

      return TabBar(
        onTap: onTap,
        tabs: tabs,
        padding: EdgeInsets.zero,
        labelStyle: baseTextStyle,
        overlayColor: WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.01)),
        unselectedLabelStyle: unselectedLabelStyle,
        dividerHeight: getSize(3),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.black.withOpacity(0.2),
        indicatorColor: AppColors.primaryColor,
        labelPadding: EdgeInsets.zero,
        unselectedLabelColor: AppColors.black.withOpacity(0.2),
      );
    }

    @override
    Size get preferredSize => Size.fromHeight(_kDefaultTabBarHeight);
  }
