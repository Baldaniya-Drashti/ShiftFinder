import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class CommonPaymentHistoryTile extends StatelessWidget {
  const CommonPaymentHistoryTile({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BaseTileDecoration(
      child: Column(
        children: [
          Material(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonInfoTile(
                    leading: SizedBox.square(
                      dimension: 50,
                      child: Image.asset(PngImageConstants.nurse2),
                    ),
                    title: BaseText(text: "CT Technologist", fontWeight: FontWeight.w600, fontSize: 16),
                    subtitle: BaseText(text: "(Healthcare - 2DFG175)", fontSize: 12, fontWeight: FontWeight.w400),
                    leadingGap: 12,
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BaseText(text: "End Date", fontSize: 10),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(color: AppColors.green),
                            text: DateFormat("dd MMM, ").format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch)),
                            children: [
                              TextSpan(
                                text: "${DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).year}",
                                style: TextStyle(color: AppColors.black.withOpacity(0.8)),
                              ),
                            ],
                          ),
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  Gap(12),
                  Divider(height: 0),
                  Gap(12),
                  CommonInfoTile(
                    leading: SvgPicture.asset(
                      SvgImageConstant.location,
                      colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      height: 24,
                      width: 24,
                    ),
                    title: BaseText(text: "4517 Washington Manchester, Kentucky 39495", fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                  Gap(12),
                  Divider(height: 0),
                  Gap(12),
                  CommonInfoTile(
                    leading: UserAvatar(
                      size: 35,
                      url: "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg",
                    ),
                    title: BaseText(text: "Rochel Foose", fontWeight: FontWeight.w500, fontSize: 12),
                    subtitle: BaseText(text: "Rochel Foose", fontSize: 10, fontWeight: FontWeight.w500, textColor: AppColors.green),
                    leadingGap: 10,
                  ),
                ],
              ),
            ),
          ),
          Gap(12),
          child,
        ],
      ),
    );
  }
}


