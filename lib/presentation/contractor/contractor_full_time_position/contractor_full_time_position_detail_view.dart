// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "ContractorFullTimePositionDetailView")
class ContractorFullTimePositionDetailView extends StatelessWidget {
  const ContractorFullTimePositionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          onBackPressed: () => context.router.maybePop(),
          title: StringConstant.viewPositionDetails),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: BaseTileDecoration(
          child: OverflowBar(
            overflowSpacing: 12,
            children: [
              _buildPositionTile(context),
              _buildPositionDescription(context),
              _buildSalaryInformation(context),
              _buildEstimatedHours(context),
              _buildShiftSchedule(context),
              _buildLanguageRequirement(context),
              _buildLocationDetail(context),
              _buildBargainingUnit(context),
              _buildOnCall(context),
              _buildBulletPointsList(context,
                  title: StringConstant.benefitsProvided),
              _buildBulletPointsList(context,
                  title: StringConstant.compensationPackage),
              _buildBulletPointsList(context, title: StringConstant.jobSummary),
              _buildBulletPointsList(context,
                  title: StringConstant.externalAndInternalRelationships),
              _buildBulletPointsList(context,
                  title: StringConstant.requiredQualifications),
              _buildBulletPointsList(context,
                  title: StringConstant.requiredExperience),
              _buildBulletPointsList(context,
                  title: StringConstant.requiredLicensesCertifications),
              _buildBulletPointsList(context,
                  title: StringConstant.requiredSkills),
              _buildBulletPointsList(context, title: StringConstant.other),
              _buildNumberOfVacancy(context)
            ],
          ),
        ),
      ),
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
            color: AppColors.black.withValues(alpha: 0.8),
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
                textColor: AppColors.black.withValues(alpha: 0.8),
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
            BaseText(
                text: "Position", fontSize: 12, fontWeight: FontWeight.w500),
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
                      SvgPicture.asset(SvgImageConstant.dollorRound,
                          height: 18),
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
                        color: AppColors.black.withValues(alpha: 0.8),
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
                                style: TextStyle(
                                    color:
                                        AppColors.green.withValues(alpha: 0.5)),
                              )
                            ], text: "22 Oct, "),
                            style: TextStyle(
                                fontSize: getSize(14),
                                fontWeight: FontWeight.w600,
                                color: AppColors.green),
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
                color: AppColors.primaryColor.withValues(alpha: 0.15),
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
            BaseText(
                text: "Estimated Weekly Hours",
                fontSize: 14,
                fontWeight: FontWeight.w500),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: BaseText(
                        text: "45 Hour",
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                SvgPicture.asset(
                  SvgImageConstant.clockWithOuterLine,
                  height: 40,
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
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
            BaseText(
                text: "Shift Schedule",
                fontSize: 14,
                fontWeight: FontWeight.w600),
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
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(10)),
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

  Widget _buildLanguageRequirement(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: "Language Requirements",
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.8)),
            Gap(3),
            BaseText(
                text: "English, Hindi",
                fontSize: 14,
                textColor: AppColors.green)
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDetail(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: "Location Details",
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.8)),
            Divider(),
            Gap(4),
            BaseText(
                text: "Location",
                fontSize: 12,
                textColor: AppColors.primaryColor),
            Gap(4),
            BaseText(
                text: "2464 Royal Ln. Mesa, New Jersey 45463", fontSize: 14),
            Gap(10),
            BaseText(
                text: "Unit - ",
                fontSize: 12,
                textColor: AppColors.primaryColor),
            Gap(4),
            BaseText(text: "X-ray", fontSize: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildBargainingUnit(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: "Union/Bargaining Unit",
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.8)),
            Divider(),
            Gap(4),
            BaseText(
                text: "ABCD Union", fontSize: 14, fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }

  Widget _buildOnCall(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: "On-Call",
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.8)),
            Divider(),
            Gap(4),
            BaseText(
                text: "This position may include on-call",
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPointsList(
    BuildContext context, {
    required String title,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: title,
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.8)),
            Divider(),
            Gap(4),
            ...List.generate(
              max(0, (4 * 2) - 1),
              (initialIndex) {
                if (initialIndex.isEven) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(radius: 3, backgroundColor: AppColors.black),
                      Gap(8),
                      Expanded(
                        child: BaseText(
                          maxLines: 1,
                          text: "Lorem ipsum dolor sit amet,gurte to him",
                          fontSize: 13,
                        ),
                      )
                    ],
                  );
                } else {
                  return Gap(4);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNumberOfVacancy(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: BaseText(
                  text: "Number of Vacancies",
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            BaseText(
                text: "05", fontSize: 14, textColor: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
