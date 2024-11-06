import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorRatingView")
class ContractorRatingView extends StatelessWidget {
  const ContractorRatingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Ratings"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            BaseText(
              text: "Employer ratings showcase your performance and contributions.",
              fontWeight: FontWeight.w600,
              fontSize: 10,
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
                    title: BaseText(
                      text: "Employer Name",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    subtitle: BaseText(
                      text: "Louis Vuitton Pvt. Ltd.",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    trailing: RatingStar(rating: 4.5),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => Gap(12),
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
