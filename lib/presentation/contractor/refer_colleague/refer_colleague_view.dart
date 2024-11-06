import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ReferColleagueView")
class ReferColleagueView extends StatelessWidget {
  const ReferColleagueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Refer a Colleague"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.surfaceColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            text: "Referral Code",
                            fontSize: 10,
                          ),
                          BaseText(
                            text: "FG15464CV",
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.green,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                        child: BaseText(
                          text: "Share",
                          textColor: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Gap(20  ),
            
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: BaseText(
                        text: "Your Referrals",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(12),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Material(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ListTile(
                            visualDensity: VisualDensity.compact,
                            leading: UserAvatar(
                              url: "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg",
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            tileColor: AppColors.scaffoldColor,
                            title: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BaseText(
                                  text: "Rochel Foose",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  width: getSize(10),
                                ),
                                SvgPicture.asset(
                                  SvgImageConstant.rightArrow,
                                  height: 13,
                                  width: 13,
                                  color: AppColors.black.withOpacity(0.5),
                                )
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                SvgPicture.asset(
                                  SvgImageConstant.emailFilled,
                                  height: 16,
                                  width: 16,
                                ),
                                SizedBox(
                                  width: getSize(4),
                                ),
                                BaseText(
                                  text: "debra.holt@example.com",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => Gap(12),
                      itemCount: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
