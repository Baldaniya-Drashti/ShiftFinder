import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class MessageDocument extends StatelessWidget {
  final String documentName;
  final bool isSender;
  final String documentUrl;
  const MessageDocument({
    super.key,
    required this.documentName,
    required this.isSender,
    required this.documentUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          PageRouteInfo(
            Viewmedia.name,
            args: ViewmediaArgs(
              mediaUrl: documentUrl,
              type: 3,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getSize(15),
          vertical: getSize(11),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSender
              ? AppColors.primaryColor
              : AppColors.grey2.withOpacity(0.10),
        ),
        child: Row(
          children: [
            Image.asset(
              PngImageConstants.document,
              width: getSize(25),
              height: getSize(33),
            ),
            SizedBox(width: getSize(10)),
            Expanded(
              child: BaseText(
                text: documentName,
                maxLines: 50,
                fontSize: 12,
                textColor: isSender ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
