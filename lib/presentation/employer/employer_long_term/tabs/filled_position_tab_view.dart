import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class FilledPositionTabView extends StatelessWidget {
  const FilledPositionTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(getSize(12)),
      separatorBuilder: (context, index) => Gap(getSize(16)),
      itemCount: 4,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(color: AppColors.lightGrey.withOpacity(0.3), blurRadius: getSize(20), spreadRadius: 5),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(getSize(14)),
          child: Column(
            children: [
              _buildPositionTile(context),
              Gap(getSize(12)),
              _positionDetailButton(
                context,
                onPressed: () {
                  //context.router.push(PageRouteInfo(FullPositionDetailView.name));
                },
              ),
              Gap(getSize(12)),
              _buildDateInfoSection(context),
              Gap(getSize(12)),
              Material(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(7),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                  child: CommonInfoTile(
                    leading: UserAvatar(url: ""),
                    title: BaseText(text: "Darcel Ballentine",fontSize: 14,),
                    trailing: SvgPicture.asset(SvgImageConstant.rightArrow,height: 16,color: AppColors.black.withOpacity(0.5),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPositionTile(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context),
            Gap(6),
            Divider(color: AppColors.white.withOpacity(0.2)),
            Gap(6),
            _buildLocationInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      child: Row(
        children: [
          Image.asset(
            PngImageConstants.nurse2,
            height: 50,
            color: AppColors.white,
          ),
          Gap(getSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: "Full Time",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.white,
                ),
                BaseText(
                  text: "(Healthcare - 2DFG125)",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: "4517 Washington Manchester, Kentucky 39495",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textColor: AppColors.white,
      ),
    );
  }

  Widget _positionDetailButton(
    BuildContext context, {
    required VoidCallback onPressed,
  }) {
    return CommonButton(
      borderRadius: 7,
      height: 45,
      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
      onPressed: onPressed,
      buttonText: 'View Position Details',
      buttonFontSize: 12,
      buttonFontWeight: FontWeight.w600,
      buttonTextColor: AppColors.black,
    );
  }

  Widget _buildDateInfoSection(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(16), vertical: getSize(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildDateInfoTile(context, title: 'Start Date:-'),
              VerticalDivider(),
              _buildDateInfoTile(context, title: 'End Date:-'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInfoTile(
    BuildContext context, {
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(text: title, fontSize: 9),
        Text.rich(
          style: TextStyle(fontSize: getFontSize(10), fontWeight: FontWeight.w600),
          TextSpan(
            text: "12 May,",
            children: [
              TextSpan(text: " 2024", style: TextStyle(color: AppColors.black.withOpacity(0.5))),
            ],
          ),
        )
      ],
    );
  }
}






