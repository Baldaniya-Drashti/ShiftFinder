import 'package:flutter/material.dart';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_long_term_detail/employer_long_term_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/get_cookie.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

class ContractorLongTermPosition extends StatelessWidget {
  const ContractorLongTermPosition({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                _buildPositionTile(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
                _buildApplicationInformation(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
                rateHoursBox(employerLongTermSuccessDto: employerLongTermSuccessDto),
                _buildEstimatedHours(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
                _buildShiftSchedule(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
                _buildLanguageRequirement(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
                _buildLocationDetail(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
                if (employerLongTermSuccessDto?.on_call_included == 1)
                  _buildCommonDividerTile(
                    context,
                    title: 'On-Call',
                    value: "This contract may include on-call",
                  ),
                _buildCommonDividerTile(
                  context,
                  title: 'Job Description',
                  value: employerLongTermSuccessDto?.job_description ?? "",
                ),
                _buildCommonDividerTile(
                  context,
                  title: 'Responsibilities',
                  value: employerLongTermSuccessDto?.responsibilities ?? "",
                ),
                _buildCommonDividerTile(
                  context,
                  title: 'Qualifications',
                  value: employerLongTermSuccessDto?.qualifications ?? "",
                ),
                _buildCommonDividerTile(
                  context,
                  title: 'Licenses/Certifications',
                  value: employerLongTermSuccessDto?.licenses_certifications ?? "",
                ),
                if (employerLongTermSuccessDto?.terms_document != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: BaseText(
                          text: "Contract Terms",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      Gap(6),
                      Material(
                        color: AppColors.grey04,
                        borderRadius: BorderRadius.circular(getSize(20)),
                        child: Padding(
                          padding: EdgeInsets.all(getSize(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (employerLongTermSuccessDto?.terms != null) ...[
                                BaseText(text: "Terms", fontSize: 13),
                                Gap(getSize(12)),
                                CustomTextField(
                                  hintText: "Type Here...",
                                  controller: TextEditingController(text: employerLongTermSuccessDto?.terms ?? ""),
                                  maxLines: 3,
                                  readOnly: true,
                                ),
                              ],
                              Gap(getSize(16)),
                              if (employerLongTermSuccessDto?.terms_document != null) ...[
                                BaseText(text: "Upload Document", fontSize: 13),
                                Gap(8),
                                selectedImage(context, employerLongTermSuccessDto!.terms_document!),
                              ]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else if (employerLongTermSuccessDto?.terms_document == null &&
                    employerLongTermSuccessDto?.terms != null) ...[
                  _buildCommonDividerTile(
                    context,
                    title: 'Contract Terms',
                    value: employerLongTermSuccessDto?.terms ?? "",
                  ),
                ],
                _buildCommonDividerTile(
                  context,
                  title: 'Onboarding Process',
                  value: employerLongTermSuccessDto?.onboarding_process ?? "",
                ),
                _buildCommonDividerTile(
                  context,
                  title: 'Disclaimer',
                  value:
                  "By proceeding, I confirm that we, the employer, are responsible for making payments directly to the contractor for this long-term contract. We understand that ShiftFinder is not responsible for any disputes, including those arising from non-payment or contract violations. We confirm that the ShiftFinder service fee is payable by us upon accepting a contractor for the position.",
                ),
                if ((employerLongTermSuccessDto?.teams ?? []).isNotEmpty)
                  _buildSelectedTeams(
                    context,
                    employerLongTermSuccessDto: employerLongTermSuccessDto,
                  ),
                _buildCheckListTile(
                  context,
                  value: employerLongTermSuccessDto?.on_call_included == 1,
                  onChanged: (value) {},
                  label: "This contract may include on call.",
                ),
                _buildCheckListTile(
                  context,
                  value: employerLongTermSuccessDto?.save_template_status == 1,
                  onChanged: (value) {},
                  label: "Save this as a template for future posting.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCheckListTile(
      BuildContext context, {
        required bool value,
        required void Function(bool value) onChanged,
        required String label,
        EdgeInsets? padding,
        Widget? trailing,
      }) {
    return Container(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: getSize(20),
            vertical: getSize(10),
          ),
      decoration: BoxDecoration(color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          onChanged(!value);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(20),
              width: getSize(16.67),
              child: Checkbox(
                value: value,
                activeColor: AppColors.primaryColor,
                side: BorderSide(
                  width: getSize(1.5),
                  color: AppColors.black.withOpacity(0.5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  onChanged(value!);
                },
              ),
            ),
            SizedBox(
              width: getSize(15),
            ),
            Expanded(
              child: BaseText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                maxLines: 15,
              ),
            ),
            if (trailing != null) trailing
          ],
        ),
      ),
    );
  }

  Widget selectedImage(
      BuildContext context,
      String selectedFile,
      ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: ShowPickedFile(
        showBadge: false,
        selectedFile: selectedFile,
        mainBoxHeight: getSize(300),
        childBoxHeight: getSize(300),
        childBoxWidth: double.maxFinite,
      ),
    );
  }

  Widget rateHoursBox({
    required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(20),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          rateWithBGIcon(
            svgIcon: SvgImageConstant.clockWithBag,
            title: StringConstant.hourlyRate,
            value: "\$${employerLongTermSuccessDto?.rate_hour}",
          ),
          Container(
            width: getSize(40),
            padding: EdgeInsets.symmetric(horizontal: getSize(10)),
            child: SvgPicture.asset(SvgImageConstant.verticalLine),
          ),
          Flexible(
            child: rateWithBGIcon(
                svgIcon: SvgImageConstant.clockWithOuterLine,
                title: "Total Months",
                value: "${employerLongTermSuccessDto?.total_months ?? ""}",
                hasMonthLabel: true),
          ),
        ],
      ),
    );
  }

  Widget rateWithBGIcon({
    required String svgIcon,
    required String title,
    required String value,
    bool hasMonthLabel = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black.withOpacity(0.7),
            ),
            SizedBox(
              height: getSize(5),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: value,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black,
                ),
                if (hasMonthLabel) ...[
                  Gap(getSize(4)),
                  Flexible(
                    child: BaseText(
                      text: "Months",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.black,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        SizedBox(width: getSize(10)),
        Align(
          alignment: Alignment.center,
          child: SvgPicture.asset(
            svgIcon,
            height: getSize(35),
            width: getSize(35),
            color: AppColors.primaryColor.withOpacity(0.2),
          ),
        )
      ],
    );
  }

  Widget _buildPositionTile(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
            _buildLocationInfo(context, employerLongTermSuccessDto: employerLongTermSuccessDto),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    return Material(
      color: AppColors.scaffoldColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            PngImageConstants.nurse2,
            height: getSize(50),
            color: AppColors.black.withOpacity(0.5),
          ),
          Gap(getSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: employerLongTermSuccessDto?.roles_list_name ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: "(${getIndustryText(employerLongTermSuccessDto?.industry ?? 0)} - ${employerLongTermSuccessDto?.listing_id})",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          BaseText(
            text: employerLongTermSuccessDto?.last_ago ?? "",
            fontSize: 10,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: employerLongTermSuccessDto?.location?.location ?? "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildApplicationInformation(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
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
                          BaseText(text: "Start Date", fontSize: 10),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: employerLongTermSuccessDto?.start_date?.year.toString(),
                                style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                              )
                            ], text: "${DateFormat("dd MMM").format(employerLongTermSuccessDto?.start_date ?? DateTime.now())}, "),
                            style: TextStyle(fontSize: getSize(14), fontWeight: FontWeight.w600, color: AppColors.green),
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
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(text: "End Date", fontSize: 10),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: employerLongTermSuccessDto?.end_date?.year.toString(),
                                  style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                                )
                              ],
                              text: "${DateFormat("dd MMM").format(employerLongTermSuccessDto?.end_date ?? DateTime.now())}, ",
                            ),
                            style: TextStyle(fontSize: getSize(14), fontWeight: FontWeight.w600, color: AppColors.green),
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
                          BaseText(text: "Application Deadline", fontSize: 10),
                          Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                    text: employerLongTermSuccessDto?.application_deadline?.year.toString(),
                                    style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                                  )
                                ],
                                text:
                                "${DateFormat("dd MMM").format(employerLongTermSuccessDto?.application_deadline ?? DateTime.now())}, "),
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

  Widget _buildEstimatedHours(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(text: "Estimated Weekly Hours", fontSize: 13, fontWeight: FontWeight.w500),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: BaseText(
                      text: formatTimeOfDay(employerLongTermSuccessDto?.estimated_weekly_hours ?? TimeOfDay.now()),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
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

  Widget _buildShiftSchedule(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    final list = getShiftScheduleFromId(employerLongTermSuccessDto?.shift_schedule_type ?? "");

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
                  list.length,
                      (index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(10)),
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

  Widget _buildLanguageRequirement(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    final list = employerLongTermSuccessDto?.languages_list ?? [];
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
            BaseText(text: "Language Requirements", fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Gap(3),
            BaseText(text: language, fontSize: 14, textColor: AppColors.green)
          ],
        ),
      ),
    );
  }

  Widget _buildLocationDetail(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    final location = employerLongTermSuccessDto?.location;
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: "Location Details", fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            BaseText(text: "Location", fontSize: 12, textColor: AppColors.primaryColor),
            Gap(4),
            BaseText(text: location?.location ?? "", fontSize: 14),
            Gap(10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(text: "Unit - ", fontSize: 12, textColor: AppColors.primaryColor),
                BaseText(text: "Unit Name", fontSize: 12, fontWeight: FontWeight.w500),
              ],
            ),
            Gap(4),
            BaseText(text: employerLongTermSuccessDto?.location_unit ?? "", fontSize: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildCommonDividerTile(BuildContext context, {required String title, required String value}) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: title, fontSize: 12, textColor: AppColors.black.withOpacity(0.8)),
            Divider(),
            Gap(4),
            BaseText(
              text: value,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedTeams(
      BuildContext context, {
        required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
      }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(text: "Selected Teams", fontSize: 14, fontWeight: FontWeight.w500),
            Gap(getSize(10)),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(getSize(14)),
                child: BaseText(text: "${employerLongTermSuccessDto?.total_teams ?? 0}", fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            Gap(getSize(20)),
            SizedBox(
              width: double.maxFinite,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  (employerLongTermSuccessDto?.teams ?? []).length,
                      (index) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(10)),
                      child: BaseText(
                        text: employerLongTermSuccessDto?.teams?[index].name ?? "",
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
