import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewSingleApplicants')
class ViewSingleApplicants extends StatelessWidget {
  const ViewSingleApplicants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => context.router.maybePop(),
        title: 'View Applicants',
      ),
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: getSize(10),
          vertical: getSize(20),
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: index == 0 ? 0 : getSize(10),
              bottom: index != 9 ? getSize(10) : 0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(getSize(20)),
            ),
            padding: EdgeInsets.all(getSize(10)),
            child: Column(
              children: [
                getApplicantswDetailContainer(index: index),
                SizedBox(height: getSize(10)),
                getActionButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  getActionButtons() {
    return AcceptRejectView();
  }

  getApplicantswDetailContainer({required int index}) {
    return Container(
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
                          text: "Rochel Foose",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(width: getSize(10)),
                        Visibility(
                          visible: index == 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(7),
                              vertical: getSize(5),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.redAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(getSize(10)),
                            ),
                            child: BaseText(
                              text: 'Occupied',
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.redAccent.withOpacity(0.8),
                            ),
                          ),
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
