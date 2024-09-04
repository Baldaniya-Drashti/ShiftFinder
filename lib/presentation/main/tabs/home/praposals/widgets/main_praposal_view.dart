import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class MainPraposalView extends StatelessWidget {
  const MainPraposalView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getSize(20)),
      padding: EdgeInsets.all(getSize(10)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.15),
            blurRadius: 24,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(getSize(12)),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
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
                          Row(
                            children: [
                              BaseText(
                                text: "CT Technologist",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              Spacer(),
                              BaseText(
                                text: "2 Days Ago",
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(height: getSize(3)),
                          BaseText(
                            text: '(Healthcare - 2DFG125)',
                            fontSize: 12,
                            textColor: const Color.fromARGB(255, 55, 46, 46)
                                .withOpacity(0.8),
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
          ),
          SizedBox(height: getSize(10)),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getSize(5),
              horizontal: getSize(20),
            ),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(getSize(10)),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BaseText(
                        text: 'Shift Date:-',
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: getSize(5)),
                      BaseText(
                        text: 'May 12, 2024',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: AppColors.black.withOpacity(0.3),
                    width: 0,
                  ),
                  Column(
                    children: [
                      BaseText(
                        text: 'Start and End Time:-',
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: getSize(5)),
                      BaseText(
                        text: '7AM to 6PM',
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
