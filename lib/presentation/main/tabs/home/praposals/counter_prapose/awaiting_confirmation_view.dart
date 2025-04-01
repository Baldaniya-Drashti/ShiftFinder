import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'AwaitingConfirmationView')
class AwaitingConfirmationView extends StatelessWidget {
  const AwaitingConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Awaiting Confirmation',
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: getSize(20)),
        padding: EdgeInsets.all(getSize(10)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.15),
              blurRadius: 24,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                                  .withValues(alpha: 0.8),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(10)),
                  Divider(
                    height: 0,
                    color: AppColors.black.withValues(alpha: 0.2),
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
                      color: AppColors.black.withValues(alpha: 0.3),
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
            ),
            SizedBox(height: getSize(10)),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getSize(10),
                horizontal: getSize(15),
              ),
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(getSize(10)),
              ),
              child: Row(
                //ainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(width: getSize(10)),
                  BaseText(
                    text: 'Rochel Foose',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: getSize(5)),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: getSize(14),
                  ),
                  Spacer(),
                  getRevokingWidget(),
                  //revokingWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CommonButton revokingWidget() {
    return CommonButton(
      width: 70,
      onPressed: () {
        // AcceptRejectDialog(
        //   title: 'Revoke',
        //   description:
        //       'Once you revoke, the contractor will\nhave a 2-hour window to confirm the\nshift. If they do not confirm within 2\nhours, the offer will be automatically\nrevoked.',
        //   onPressedAccept: () {},
        //   acceptButtonText: 'Revoke',
        //   onPressedReject: () {
        //     context.router.maybePop();
        //   },
        // ).acceptRejectDialog(context);
      },
      backgroundColor: AppColors.redAccent.withValues(alpha: 0.15),
      buttonTextColor: AppColors.black,
      buttonFontSize: 12,
      borderRadius: 10,
      buttonText: 'Revoke',
      height: 34,
    );
  }

  getRevokingWidget() {
    return Column(
      children: [
        BaseText(
          text: 'Revoking...',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          textColor: AppColors.black.withValues(alpha: 0.7),
        ),
        SizedBox(height: getSize(3)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time_rounded,
                color: AppColors.green, size: getSize(15)),
            SizedBox(width: getSize(2)),
            BaseText(
              text: '1 h 23 min',
              textColor: AppColors.green,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ],
        )
      ],
    );
  }
}
