import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.url,
    this.size,
  });

  final String url;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      shape: CircleBorder(
        side: BorderSide(color: AppColors.green),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          height: size ?? getSize(40),
          width: size ?? getSize(40),
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => SizedBox(),
        ),
      ),
    );
  }
}
