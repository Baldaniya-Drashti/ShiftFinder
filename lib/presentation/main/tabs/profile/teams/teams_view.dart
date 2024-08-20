import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'TeamsView')
class TeamsView extends StatelessWidget {
  const TeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'Teams',
      ),
      body: SafeArea(
        bottom: isFullScreenDevice(context) ? true : false,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(20),
                      vertical: getSize(14),
                    ),
                    margin: EdgeInsets.symmetric(vertical: getSize(5)),
                    decoration: BoxDecoration(
                      color: Color(0xFFEDEDED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          PngImageConstants.teamImage,
                          height: getSize(45),
                          width: getSize(60),
                        ),
                        SizedBox(
                          width: getSize(15),
                        ),
                        Image.asset(
                          PngImageConstants.line,
                          height: getSize(80),
                        ),
                        SizedBox(
                          width: getSize(15),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseText(
                                text: 'HR Team',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: getSize(5),
                              ),
                              Text.rich(
                                TextSpan(
                                  text: 'Total Members - ',
                                  style: TextStyle(
                                    fontSize: getFontSize(8),
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black.withOpacity(0.8),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '02',
                                      style: TextStyle(
                                        fontSize: getFontSize(8),
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: getSize(5),
                              ),
                              BaseText(
                                text: '2464 Royal Ln. Mesa, New...',
                                fontSize: 10,
                                textColor: AppColors.black.withOpacity(0.8),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: getSize(20),
            ),
            CommonButton(
              height: 28,
              width: 135,
              onPressed: () {},
              backgroundColor: AppColors.green.withOpacity(0.15),
              buttonText: '+ Add New Team',
              buttonTextColor: AppColors.green,
              buttonFontSize: 12,
              borderRadius: 7,
              buttonFontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
