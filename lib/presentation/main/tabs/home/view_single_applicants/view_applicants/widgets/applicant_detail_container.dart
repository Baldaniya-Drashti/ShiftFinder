import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class ApplicantsDetailView extends StatelessWidget {
  const ApplicantsDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getSize(12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: getSize(20),
                backgroundColor: AppColors.green,
                child: CircleAvatar(
                  radius: getSize(19),
                  backgroundImage: NetworkImage(
                    'https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg',
                  ),
                ),
              ),
              SizedBox(width: getSize(15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BaseText(
                      text: "Rochel Foose",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: getSize(3)),
                    BaseText(
                      text: 'Distance - 20 Km',
                      fontSize: 8,
                      textColor: AppColors.black.withOpacity(0.8),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: getSize(10)),
          Divider(
            height: 0,
            color: AppColors.black.withOpacity(0.2),
            thickness: 0.5,
          ),
          SizedBox(height: getSize(10)),
          Row(
            children: [
              SvgPicture.asset(
                SvgImageConstant.location,
                colorFilter: ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcATop,
                ),
              ),
              SizedBox(width: getSize(5)),
              BaseText(
                text: '4517 Washington Manchester, Kentucky 39495',
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
