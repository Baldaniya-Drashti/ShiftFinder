import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/add_full_position/add_full_position_bloc.dart';
import 'package:shift/application/employer/employer_full_position/employer_postion_bloc.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerFullPositionView")
class EmployerFullPositionView extends StatelessWidget {
  const EmployerFullPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerPostionBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Full Time Positions"),
        body: ListView.separated(
          padding: EdgeInsets.all(12),
          itemBuilder: (context, index) => Material(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _buildPositionTile(context),
                  Gap(12),
                  _positionDetailButton(context, onPressed: () {}),
                  Gap(12),
                  _buildPositionDescription(context),
                  Gap(12),
                  _buildTotalApplication(context)
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => Gap(16),
          itemCount: 5,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0).copyWith(top: 12),
          child: CommonButton(
            onPressed: () {
              context.router.push(PageRouteInfo(AddFullPositionView.name));
            },
            buttonText: "Post a Full Time Position",
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
        padding: const EdgeInsets.all(16.0),
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
          Gap(16),
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
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(SvgImageConstant.delete, height: 25),
          ),
          Gap(16),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(SvgImageConstant.edit, height: 25),
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
      height: 48,
      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
      onPressed: onPressed,
      buttonText: 'View Position Details',
      buttonFontSize: 12,
      buttonFontWeight: FontWeight.w600,
      buttonTextColor: AppColors.black,
    );
  }

  Widget _buildPositionDescription(BuildContext context) {
    return Material(
      color: AppColors.scaffoldColor,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(text: "Position", fontSize: 12, fontWeight: FontWeight.w500),
            Divider(),
            BaseText(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              text:
                  "Lorem ipsum dolor sit amet,gurte to consectetur adipiscing elit, sed do eghte fir eiusmod tempor incididunt ut labore et dolore magna?",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalApplication(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(text: "Total Applications", fontSize: 12, fontWeight: FontWeight.w500),
            Gap(8),
            Row(
              children: [
                BaseText(text: "0", fontWeight: FontWeight.w600, fontSize: 25, textColor: AppColors.primaryColor),
                Gap(12),
                SvgPicture.asset(SvgImageConstant.threePerson, height: 30),
                // StackedImage(index: 2)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
