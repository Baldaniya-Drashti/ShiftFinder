import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class MessageVideo extends StatelessWidget {
  final String videoThumbnail;
  final bool isSender;
  final String videoUrl;
  const MessageVideo(
      {super.key,
      required this.videoThumbnail,
      required this.isSender,
      required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
              image: CachedNetworkImageProvider(videoThumbnail),
              fit: BoxFit.cover,
            ),
          ),
        ),
        GestureDetector(
          child: playButton(),
          onTap: () {
            context.router.push(
              PageRouteInfo(
                Viewmedia.name,
                args: ViewmediaArgs(
                  mediaUrl: videoUrl,
                  type: 2,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget playButton() {
    return Container(
      height: getSize(40),
      width: getSize(40),
      padding: EdgeInsets.only(
        left: getSize(11),
        right: getSize(9),
        top: getSize(8),
        bottom: getSize(8),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(colors: [
          AppColors.primaryColor,
          AppColors.emeraldGreenColor,
        ]),
      ),
      child: SvgPicture.asset(
        SvgImageConstant.play,
      ),
    );
  }
}
