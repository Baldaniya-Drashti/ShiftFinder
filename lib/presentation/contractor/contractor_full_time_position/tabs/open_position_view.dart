import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class OpenPositionView extends StatelessWidget {
  const OpenPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(12),
      itemBuilder: (context, index) => BaseTileDecoration(
        child: Column(
          children: [
            _buildPositionTile(context),
            Gap(12),
            _positionDetailButton(
              context,
              onPressed: () {
                context.router.push(PageRouteInfo(ContractorFullTimePositionDetailView.name));
              },
            ),
            Gap(12),
            _buildPositionDescription(context),
            Gap(12),
            _buildSalaryInformation(context),
            Gap(12),
            _buildEstimatedHours(context),
            Gap(12),
            _buildShiftSchedule(context),
            Gap(12),
            CommonButton(
              height: 45,
              borderRadius: 10,
              buttonTextColor: AppColors.white,
              onPressed: () async {
                final result = await AppDialog.showCommonDialog(
                  context: context,
                  title: "Apply",
                  content:
                      "Interviews and hiring procedures for full-time positions are managed directly by the employer, outside of the ShiftFinder platform. Once hired, the employer will be responsible for making payments directly to you.ShiftFinder is not liable for any disputes, including those related to non-payment or contract violations.",
                  extraContent: "Are you sure you want to apply for this position?",
                  successLabel: "Apply",
                );
                if (result ?? false) {
                  ///TODO:
                }
              },
              buttonText: "Apply",
            )
          ],
        ),
      ),
      separatorBuilder: (context, index) => Gap(16),
      itemCount: 5,
    );
  }

  Widget _positionDetailButton(
    BuildContext context, {
    required VoidCallback onPressed,
  }) {
    return CommonButton(
      borderRadius: 7,
      height: 40,
      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
      onPressed: onPressed,
      buttonText: 'View Position Details',
      buttonFontSize: 12,
      buttonFontWeight: FontWeight.w600,
      buttonTextColor: AppColors.black,
    );
  }

  Widget _buildPositionTile(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context),
            Gap(6),
            Divider(),
            Gap(6),
            _buildLocationInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(BuildContext context) {
    return Material(
      color: AppColors.scaffoldColor,
      child: Row(
        children: [
          Image.asset(
            PngImageConstants.nurse2,
            height: 50,
            color: AppColors.black.withOpacity(0.8),
          ),
          Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseText(
                text: "Full Time",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              BaseText(
                text: "(Healthcare - 2DFG125)",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textColor: AppColors.black.withOpacity(0.8),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: "4517 Washington Manchester, Kentucky 39495",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
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

  Widget _buildSalaryInformation(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(SvgImageConstant.dollorRound, height: 18),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(text: "Salary", fontSize: 12),
                          BaseText(
                            text: "93,000 – 98,000",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        SvgImageConstant.calendar,
                        height: 18,
                        color: AppColors.black.withOpacity(0.8),
                      ),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(text: "Salary", fontSize: 12),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: "2024",
                                style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                              )
                            ], text: "22 Oct, "),
                            style: TextStyle(fontSize: getSize(14), fontWeight: FontWeight.w600, color: AppColors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                SvgImageConstant.clockWithBag,
                height: getSize(70),
                width: getSize(70),
                color: AppColors.primaryColor.withOpacity(0.15),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEstimatedHours(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(text: "Estimated Weekly Hours", fontSize: 14, fontWeight: FontWeight.w500),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: BaseText(text: "45 Hour", fontSize: 20, fontWeight: FontWeight.w600)),
                SvgPicture.asset(
                  SvgImageConstant.clockWithOuterLine,
                  height: 40,
                  color: AppColors.primaryColor.withOpacity(0.15),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftSchedule(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(text: "Shift Schedule", fontSize: 14, fontWeight: FontWeight.w600),
            Gap(12),
            SizedBox(
              width: double.maxFinite,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  4,
                  (index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(10)),
                      child: BaseText(
                        text: "Morning",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
