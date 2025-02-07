// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_full_posting_review/employer_full_posting_review_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/helper/time_extension.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerFullPostingReviewView")
class EmployerFullPostingReviewView extends StatelessWidget {
  const EmployerFullPostingReviewView(
      {super.key, required this.response, required this.data, this.postId});

  final EmployerLongTermSuccessDto response;
  final EmployerLongTermSuccessDto data;
  final int? postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerFullPostingReviewBloc>(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: CommonAppBar(
              onBackPressed: () => context.router.maybePop(),
              title: StringConstant.reviewDetails),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(getSize(12)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(getSize(20)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightGrey.withOpacity(0.2),
                        blurRadius: getSize(20),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(getSize(12)),
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
                      if (response.benefits != null)
                        _buildBulletPointsList(context,
                            title: "Benefits Provided",
                            content: response.benefits),
                      if (response.compensation_package != null)
                        _buildBulletPointsList(
                          context,
                          title: "Compensation Package",
                          content: response.compensation_package,
                        ),
                      if (response.job_summary != null)
                        _buildBulletPointsList(context,
                            title: "Job Summary",
                            content: response.job_summary),
                      if (response.external_internal_relationships != null)
                        _buildBulletPointsList(
                          context,
                          title: "External and Internal Relationships",
                          content: response.external_internal_relationships,
                        ),
                      if (response.employer_payment_confirmation != null)
                        _buildBulletPointsList(context,
                            title: "Required Qualifications",
                            content: response.qualifications),
                      if (response.experience != null)
                        _buildBulletPointsList(
                          context,
                          title: "Required Experience",
                          content: response.experience,
                        ),
                      if (response.licenses_certifications != null)
                        _buildBulletPointsList(
                          context,
                          title: "Required Licenses/Certifications",
                          content: response.licenses_certifications,
                        ),
                      if (response.skills != null)
                        _buildBulletPointsList(
                          context,
                          title: "Required Skills",
                          content: response.skills,
                        ),
                      if (response.other != null)
                        _buildBulletPointsList(
                          context,
                          title: "Other",
                          content: response.other,
                        ),
                      _buildNumberOfVacancy(
                          context, response.number_of_vacancie ?? 00),
                      if (response.on_call_included == 1)
                        _buildCheckListTile(
                          context,
                          value: response.on_call_included == 1,
                          onChanged: (value) {},
                          label: StringConstant.thisPositionMayIncludeOnCall,
                        ),
                    ],
                  ),
                ),
                Gap(getSize(22)),
                _buildSubmitButton(context)
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return CommonButton(
      onPressed: () {
        context.read<EmployerFullPostingReviewBloc>().add(
              EmployerFullPostingReviewEvent.onSubmit(
                context: context,
                id: response.id ?? -1,
                postId: postId,
                employer: response,
                data: data,
              ),
            );
      },
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
    final jobType = response.job_type == 1 ? "Full Time" : "Part Time";
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
                text: jobType,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              BaseText(
                text:
                    "(${getIndustryText(response.industry ?? 0)} - ${response.listing_id})",
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
        text: response.location?.location ?? "",
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
            BaseText(
                text: "Position", fontSize: 12, fontWeight: FontWeight.w500),
            Divider(),
            BaseText(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                text: response.position ?? ""),
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
                      SvgPicture.asset(SvgImageConstant.dollorRound,
                          height: getSize(18)),
                      Gap(getSize(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                              text: response.compensation_type == 1
                                  ? "Rate"
                                  : "Salary",
                              fontSize: 12),
                          BaseText(
                            text: "${response.rate_hour ?? ""}",
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
                          BaseText(text: "Application Deadline", fontSize: 12),
                          Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${response.application_deadline?.year}",
                                    style: TextStyle(
                                        color:
                                            AppColors.green.withOpacity(0.5)),
                                  )
                                ],
                                text:
                                    "${DateFormat("dd MMM").format(response.application_deadline ?? DateTime.now())}, "),
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
            BaseText(
                text: "Estimated Weekly Hours",
                fontSize: 12,
                fontWeight: FontWeight.w500),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: BaseText(
                        text:
                            "${response.estimated_weekly_hours?.formatTimeOfDay}",
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
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
    final list = getShiftScheduleFromId(response.shift_schedule_type ?? "");

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
                  list.length,
                  (index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BaseText(
                        text: list[index],
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
    final list = response.languages_list ?? [];
    final language = list.map((e) => e.name).join(", ");
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: "Language Requirements",
                fontSize: 12,
                textColor: AppColors.black.withOpacity(0.8)),
            Gap(3),
            BaseText(text: language, fontSize: 14, textColor: AppColors.green)
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDetail(BuildContext context) {
    final location = response.location;
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
                textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            BaseText(
                text: "Location",
                fontSize: 12,
                textColor: AppColors.primaryColor),
            Gap(4),
            BaseText(text: location?.location ?? "", fontSize: 13),
            Gap(10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                    text: "Unit - ",
                    fontSize: 12,
                    textColor: AppColors.primaryColor),
                BaseText(
                    text: "Unit Name",
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ],
            ),
            Gap(4),
            BaseText(text: response.location_unit ?? "", fontSize: 13),
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
        padding: EdgeInsets.symmetric(
            horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: "Union/Bargaining Unit",
                fontSize: 12,
                textColor: AppColors.black.withOpacity(0.8)),
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
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: "On-Call",
                fontSize: 12,
                textColor: AppColors.black.withOpacity(0.8)),
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
    required String? content,
  }) {
    final list = content?.split(",").toList() ?? [];
    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: title,
                fontSize: 12,
                textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            ...List.generate(
              max(0, (list.length * 2) - 1),
              (initialIndex) {
                final int index = initialIndex ~/ 2;
                if (initialIndex.isEven) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: getSize(8)),
                        child: CircleAvatar(
                            radius: 2, backgroundColor: AppColors.black),
                      ),
                      Gap(getSize(8)),
                      Expanded(
                        child: BaseText(
                          maxLines: 1,
                          text: list[index],
                          fontSize: 13,
                          showFullDescription: true,
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

  Widget _buildNumberOfVacancy(BuildContext context, int vacancie) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getSize(22), vertical: getSize(14)),
        child: Row(
          children: [
            Expanded(
              child: BaseText(
                  text: StringConstant.numberOfVacancies,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            BaseText(
                text: (vacancie > 9) ? "$vacancie" : "0$vacancie",
                fontSize: 14,
                textColor: AppColors.primaryColor),
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
      color: AppColors.scaffoldColor,
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
                  side: BorderSide(
                      color: AppColors.black.withOpacity(.5), width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
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
              child: BaseText(
                  text: label,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  maxLines: 10),
            )
          ],
        ),
      ),
    );
  }
}
