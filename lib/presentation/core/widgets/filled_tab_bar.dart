import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class FilledTabBar extends StatelessWidget implements PreferredSizeWidget {
  const FilledTabBar({
    super.key,
    required this.tabs,
    this.onTap,
  });

  final List<Widget> tabs;
  final ValueSetter<int>? onTap;
  static const _kDefaultTabBarHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    final baseTextStyle = TextStyle(fontSize: getFontSize(14), fontWeight: FontWeight.w500, color: AppColors.white);
    final unselectedLabelStyle = baseTextStyle.copyWith(color: Colors.black.withOpacity(0.6));

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.white,
      child: SizedBox(
        height: preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: TabBar(
            onTap: onTap,
            tabs: tabs,
            padding: EdgeInsets.zero,
            labelStyle: baseTextStyle,
            overlayColor: WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.01)),
            unselectedLabelStyle: unselectedLabelStyle,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.primaryColor,
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: AppColors.black.withOpacity(0.2),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_kDefaultTabBarHeight);
}
