import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class PreviousShiftFavView extends StatelessWidget {
  const PreviousShiftFavView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(getSize(20)),
      child: Column(
        children: [
          SizedBox(
            height: getSize(12),
          ),
          BaseText(
            text: "You can remove a contractor from your favorites list by clicking the favorite button again.",
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: getSize(18),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => _PreviousShiftFavTile(),
            separatorBuilder: (context, index) => Gap(getSize(16)),
            itemCount: 4,
          )
        ],
      ),
    );
  }
}

class _PreviousShiftFavTile extends StatelessWidget {
  const _PreviousShiftFavTile();

  @override
  Widget build(BuildContext context) {
    return BaseTileDecoration(
      padding: EdgeInsets.all(getSize(12)),
      child: Material(
        borderRadius: BorderRadius.circular(getSize(16)),
        color: AppColors.scaffoldColor,
        child: UserInfoTile(
          titleIcon: SvgPicture.asset(
            SvgImageConstant.rightArrow,
            height: 13,
            width: 13,
            colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.5), BlendMode.srcIn),
          ),
          padding: EdgeInsets.symmetric(horizontal: getSize(16)),
          title: "Roboto Flex",
          subTitle: "CT Technologist",
          url: "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg",
          trailing: CommonMaterialButton.icon(
            radius: 10.0,
            backgroundColor: AppColors.green.withOpacity(0.2),
            width: 90,
            height: 33,
            onPressed: () {},
            label: "Favorite",
            textStyle: TextStyle(fontSize: 10, color: AppColors.green),
            icon: SvgPicture.asset(SvgImageConstant.heartChecked, height: 11, width: 11),
          ),
        ),
      ),
    );
  }
}
