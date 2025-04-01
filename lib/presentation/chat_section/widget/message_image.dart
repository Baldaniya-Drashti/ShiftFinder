import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class MessageImage extends StatelessWidget {
  final String imageUrl;
  final bool isSender;
  const MessageImage(
      {super.key, required this.imageUrl, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          PageRouteInfo(
            Viewmedia.name,
            args: ViewmediaArgs(
              mediaUrl: imageUrl,
              type: 1,
            ),
          ),
        );
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.5,
          maxHeight: getSize(200),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSender
                ? AppColors.primaryColor
                : AppColors.grey2.withValues(alpha: 0.10),
            width: getSize(3),
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
