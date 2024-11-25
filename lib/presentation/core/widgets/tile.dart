import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
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
    this.titleIcon,
    this.subtitleIcon,
  });

  final Color? backgroundColor;
  final String title;
  final String subTitle;
  final Widget? trailing;
  final EdgeInsets? padding;
  final String url;
  final Widget? titleIcon;
  final Widget? subtitleIcon;

  @override
  Widget build(BuildContext context) {
    Widget title, subtitle;
    final titleLabel = BaseText(text: this.title, fontWeight: FontWeight.w600, fontSize: 14);
    final subtitleLabel = BaseText(text: subTitle, fontSize: 10, fontWeight: FontWeight.w500);

    if (titleIcon != null) {
      title = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: titleLabel),
          Gap(getSize(8)),
          titleIcon!,
        ],
      );
    } else {
      title = titleLabel;
    }

    if (subtitleIcon != null) {
      subtitle = Row(
        mainAxisSize: MainAxisSize.min,
        children: [subtitleIcon!, Gap(getSize(8)), subtitleLabel],
      );
    } else {
      subtitle = subtitleLabel;
    }

    return ListTile(
      tileColor: backgroundColor,
      contentPadding: padding ?? EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      trailing: trailing,
      leading: UserAvatar(url: url),
      minLeadingWidth: 0,
      title: title,
      subtitle: subtitle,
    );
  }
}

class CommonInfoTile extends StatelessWidget {
  const CommonInfoTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.leadingGap, this.crossAxisAlignment,
  });

  final Widget? leading, title, subtitle, trailing;
  final double? leadingGap;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.center,
      children: [
        if (leading != null) leading!,
        SizedBox(
          width: getSize(leadingGap ?? 6),
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
        if (trailing != null) trailing!
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


