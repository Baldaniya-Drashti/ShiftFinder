import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.url,
    this.backgroundColor,
    this.trailing,
    this.padding,
  });

  final Color? backgroundColor;
  final String title;
  final String subTitle;
  final Widget? trailing;
  final EdgeInsets? padding;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: backgroundColor,
      contentPadding: padding ?? EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      trailing: trailing,
      leading: UserAvatar(url: url),
      minLeadingWidth: 0,
      title: BaseText(text: title, fontWeight: FontWeight.w600, fontSize: 15),
      subtitle: BaseText(text: subTitle, fontSize: 10, fontWeight: FontWeight.w500),
    );
  }
}

class CommonInfoTile extends StatelessWidget {
  const CommonInfoTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
  });

  final Widget? leading, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) leading!,
        SizedBox(
          width: getSize(6),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) title!,
              if (subtitle != null) subtitle!,
            ],
          ),
        ),
      ],
    );
  }
}

class BaseTileDecoration extends StatelessWidget {
  const BaseTileDecoration({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(20.0)),
      color: AppColors.white,
      child: Padding(
        padding: padding ?? EdgeInsets.all(getSize(15.0)),
        child: child,
      ),
    );
  }
}
