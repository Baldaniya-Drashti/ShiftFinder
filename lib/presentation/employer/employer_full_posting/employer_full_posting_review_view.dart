import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_full_posting_review/employer_full_posting_review_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerFullPostingReviewView")
class EmployerFullPostingReviewView extends StatelessWidget {
  const EmployerFullPostingReviewView({super.key, required this.employerFullPosting});
  final EmployerLongTermSuccessDto employerFullPosting;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerFullPostingReviewBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(onBackPressed: () => context.router.maybePop(), title: "Review Details"),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(getSize(12)),
          child: Column(
            children: [
              BaseTileDecoration(
                child: OverflowBar(
                  overflowSpacing: getSize(12),
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
                    _buildBulletPointsList(context, title: "Benefits Provided"),
                    _buildBulletPointsList(context, title: "Compensation Package"),
                    _buildBulletPointsList(context, title: "Job Summary"),
                    _buildBulletPointsList(context, title: "External and Internal Relationships"),
                    _buildBulletPointsList(context, title: "Required Qualifications"),
                    _buildBulletPointsList(context, title: "Required Experience"),
                    _buildBulletPointsList(context, title: "Required Licenses/Certifications"),
                    _buildBulletPointsList(context, title: "Required Skills"),
                    _buildBulletPointsList(context, title: "Other"),
                    _buildNumberOfVacancy(context),
                    BlocSelector<EmployerFullPostingReviewBloc, EmployerFullPostingReviewState, bool>(
                      selector: (state) => state.includeCall,
                      builder: (context, includeCall) {
                        return _buildCheckListTile(
                          context,
                          value: includeCall,
                          onChanged: (value) {
                            context.read<EmployerFullPostingReviewBloc>().add(
                                  EmployerFullPostingReviewEvent.onIncludeCallChanged(value: value),
                                );
                          },
                          label: "This position may include on call.",
                        );
                      },
                    ),
                    BlocSelector<EmployerFullPostingReviewBloc, EmployerFullPostingReviewState, bool>(
                      selector: (state) => state.saveTemplateFuture,
                      builder: (context, saveTemplateFuture) {
                        return _buildCheckListTile(
                          context,
                          value: saveTemplateFuture,
                          onChanged: (value) {
                            context.read<EmployerFullPostingReviewBloc>().add(
                                  EmployerFullPostingReviewEvent.onSaveTemplateFutureChanged(value: value),
                                );
                          },
                          label: "This position may include on call.",
                        );
                      },
                    ),
                  ],
                ),
              ),
              Gap(22),
              _buildSubmitButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return CommonButton(
      onPressed: () {},
      buttonText: "Submit",
    );
  }

  Widget _buildPositionTile(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
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
            height: getSize(50),
            color: AppColors.black.withOpacity(0.8),
          ),
          Gap(getSize(16)),
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
        height: getSize(24),
        width: getSize(24),
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
      borderRadius: BorderRadius.circular(getSize(10)),
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
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
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
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
                      SvgPicture.asset(SvgImageConstant.dollorRound, height: getSize(18)),
                      Gap(getSize(10)),
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
                  Gap(getSize(22)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        SvgImageConstant.calendar,
                        height: 18,
                        color: AppColors.black.withOpacity(0.8),
                      ),
                      Gap(getSize(10)),
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
              padding: EdgeInsets.only(right: getSize(20)),
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
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(text: "Estimated Weekly Hours", fontSize: 12, fontWeight: FontWeight.w500),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: BaseText(text: "45 Hour", fontSize: 20, fontWeight: FontWeight.w600)),
                SvgPicture.asset(
                  SvgImageConstant.clockWithOuterLine,
                  height: getSize(40),
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
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(text: "Shift Schedule", fontSize: 14, fontWeight: FontWeight.w600),
            Gap(getSize(12)),
            SizedBox(
              width: double.maxFinite,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  4,
                  (index) {
                    return Container(
                      padding: EdgeInsets.all(getSize(8)),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(getSize(10)),
                      ),
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
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: "Language Requirements", fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Gap(3),
            BaseText(text: "English, Hindi", fontSize: 14, textColor: AppColors.green)
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
        padding: EdgeInsets.symmetric(horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: "Location Details", fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            BaseText(text: "Location", fontSize: 12, textColor: AppColors.primaryColor),
            Gap(4),
            BaseText(text: "2464 Royal Ln. Mesa, New Jersey 45463", fontSize: 14),
            Gap(10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(text: "Unit - ", fontSize: 12, textColor: AppColors.primaryColor),
                BaseText(text: "Unit Name", fontSize: 12, fontWeight: FontWeight.w500),
              ],
            ),
            Gap(4),
            BaseText(text: "X-ray", fontSize: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildBargainingUnit(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: "Union/Bargaining Unit", fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            BaseText(text: "ABCD Union", fontSize: 14, fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }

  Widget _buildOnCall(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: "On-Call", fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            BaseText(text: "This position may include on-call", fontSize: 14, fontWeight: FontWeight.w500),
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
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: title, fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            ...List.generate(
              max(0, (4 * 2) - 1),
              (initialIndex) {
                final int index = initialIndex ~/ 2;
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
                  return Gap(getSize(4));
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
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(22), vertical: getSize(16)),
        child: Row(
          children: [
            Expanded(
              child: BaseText(text: "Number of Vacancies", fontSize: 12, fontWeight: FontWeight.w600),
            ),
            BaseText(text: "05", fontSize: 14, textColor: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckListTile(
    BuildContext context, {
    required bool value,
    required void Function(bool value) onChanged,
    required String label,
  }) {
    return Material(
      color: AppColors.surfaceColor,
      borderRadius: BorderRadius.circular(getSize(10)),
      child: Padding(
        padding: EdgeInsets.all(getSize(12)).copyWith(bottom: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, -6),
              child: Transform.scale(
                scale: 0.9,
                child: Checkbox(
                  activeColor: AppColors.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  side: BorderSide(color: AppColors.black.withOpacity(.5), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  value: value,
                  onChanged: (value) {
                    if (value == null) return;
                    onChanged(value);
                  },
                ),
              ),
            ),
            Gap(8),
            Expanded(
              child: BaseText(text: label, fontSize: 12, fontWeight: FontWeight.w500, maxLines: 10),
            )
          ],
        ),
      ),
    );
  }
}
