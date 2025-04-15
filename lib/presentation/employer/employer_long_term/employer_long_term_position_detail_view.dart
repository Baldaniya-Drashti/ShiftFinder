// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_long_term_detail/employer_long_term_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/employer_long_term_success/employer_long_term_success_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerLongTermPositionDetailView")
class EmployerLongTermPositionDetailView extends StatelessWidget {
  const EmployerLongTermPositionDetailView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerLongTermDetailBloc>()
        ..add(EmployerLongTermDetailEvent.getPositionDetail(context, id)),
      child: Scaffold(
        appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: StringConstant.viewPositionDetails),
        body: BlocBuilder<EmployerLongTermDetailBloc,
            EmployerLongTermDetailState>(
          builder: (context, state) {
            final employerLongTermSuccessDto = state.employerLongTermSuccessDto;
            return state.isLoading
                ? CenterLoadingIndicator()
                : state.employerLongTermSuccessDto == null
                    ? Center(child: BaseText(text: StringConstant.noDataFound))
                    : SingleChildScrollView(
                        padding: EdgeInsets.all(getSize(12)),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                    BorderRadius.circular(getSize(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.lightGrey
                                        .withValues(alpha: 0.2),
                                    blurRadius: getSize(20),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(getSize(12)),
                              child: OverflowBar(
                                overflowSpacing: getSize(12),
                                children: [
                                  _buildPositionTile(context,
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto),
                                  _buildApplicationInformation(context,
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto),
                                  rateHoursBox(
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto),
                                  _buildEstimatedHours(context,
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto),
                                  if (employerLongTermSuccessDto
                                              ?.specialties_detail !=
                                          null &&
                                      employerLongTermSuccessDto!
                                          .specialties_detail!.isNotEmpty)
                                    requiredSkillBox(
                                      svgPrefixIcon: SvgImageConstant.female,
                                      title: StringConstant.specialtiesRequired,
                                      value: employerLongTermSuccessDto
                                              .specialties_detail ??
                                          "",
                                    ),
                                  if (employerLongTermSuccessDto
                                              ?.software_skill !=
                                          null &&
                                      employerLongTermSuccessDto!
                                          .software_skill!.isNotEmpty)
                                    requiredSkillBox(
                                      svgPrefixIcon: SvgImageConstant.mouse,
                                      title: StringConstant.softwareSkills,
                                      value: employerLongTermSuccessDto
                                              .software_skill ??
                                          "",
                                    ),
                                  _buildShiftSchedule(context,
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto),
                                  _buildLanguageRequirement(context,
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto),
                                  _buildLocationDetail(context,
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto),
                                  if (employerLongTermSuccessDto
                                          ?.on_call_included ==
                                      1)
                                    _buildCommonDividerTile(
                                      context,
                                      title: StringConstant.onCall,
                                      value: StringConstant
                                          .thisContractMayIncludeOnCall,
                                    ),
                                  _buildCommonDividerTile(
                                    context,
                                    title: StringConstant.jobDescription,
                                    value: employerLongTermSuccessDto
                                            ?.job_description ??
                                        "",
                                  ),
                                  _buildCommonDividerTile(
                                    context,
                                    title: StringConstant.responsibilities,
                                    value: employerLongTermSuccessDto
                                            ?.responsibilities ??
                                        "",
                                  ),
                                  _buildCommonDividerTile(
                                    context,
                                    title: StringConstant.qualifications,
                                    value: employerLongTermSuccessDto
                                            ?.qualifications ??
                                        "",
                                  ),
                                  _buildCommonDividerTile(
                                    context,
                                    title:
                                        StringConstant.licensesCertifications,
                                    value: employerLongTermSuccessDto
                                            ?.licenses_certifications ??
                                        "",
                                  ),
                                  if (employerLongTermSuccessDto
                                          ?.terms_document !=
                                      null) ...[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: getSize(20)),
                                          child: BaseText(
                                            text: StringConstant.contractTerms,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.black
                                                .withValues(alpha: 0.7),
                                          ),
                                        ),
                                        Gap(getSize(6)),
                                        Material(
                                          color: AppColors.grey04,
                                          borderRadius: BorderRadius.circular(
                                              getSize(20)),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(getSize(16)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                if (employerLongTermSuccessDto
                                                        ?.terms !=
                                                    null) ...[
                                                  BaseText(
                                                      text:
                                                          StringConstant.terms,
                                                      fontSize: 13),
                                                  Gap(getSize(12)),
                                                  CustomTextField(
                                                    hintText: StringConstant
                                                        .typeHerewithDots,
                                                    controller: TextEditingController(
                                                        text:
                                                            employerLongTermSuccessDto
                                                                    ?.terms ??
                                                                ""),
                                                    maxLines: 3,
                                                    readOnly: true,
                                                  ),
                                                ],
                                                Gap(getSize(16)),
                                                if (employerLongTermSuccessDto
                                                        ?.terms_document !=
                                                    null) ...[
                                                  BaseText(
                                                      text: StringConstant
                                                          .uploadDocument,
                                                      fontSize: 13),
                                                  Gap(8),
                                                  selectedImage(
                                                      context,
                                                      employerLongTermSuccessDto!
                                                          .terms_document!),
                                                ]
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ] else if (employerLongTermSuccessDto
                                              ?.terms_document ==
                                          null &&
                                      employerLongTermSuccessDto?.terms !=
                                          null) ...[
                                    _buildCommonDividerTile(
                                      context,
                                      title: StringConstant.contractTerms,
                                      value:
                                          employerLongTermSuccessDto?.terms ??
                                              "",
                                    ),
                                  ],
                                  _buildCommonDividerTile(
                                    context,
                                    title: StringConstant.onboardingProcess,
                                    value: employerLongTermSuccessDto
                                            ?.onboarding_process ??
                                        "",
                                  ),
                                  _buildCommonDividerTile(
                                    context,
                                    title: StringConstant.disclaimer,
                                    value: StringConstant.longTermDisclaimer,
                                  ),
                                  if ((employerLongTermSuccessDto?.teams ?? [])
                                      .isNotEmpty)
                                    _buildSelectedTeams(
                                      context,
                                      employerLongTermSuccessDto:
                                          employerLongTermSuccessDto,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
          },
        ),
      ),
    );
  }

  Widget requiredSkillBox({
    required String svgPrefixIcon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minVerticalPadding: 0,
        horizontalTitleGap: getSize(0),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: getSize(43),
              width: getSize(35),
              child: SvgPicture.asset(
                svgPrefixIcon,
                color: AppColors.primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(10)),
              child: SvgPicture.asset(
                SvgImageConstant.verticalLine,
              ),
            ),
          ],
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: getSize(3)),
            Flexible(
              child: BaseText(
                text: value,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                lineHeight: getSize(1),
                maxLines: 10,
              ),
            ),
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
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
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
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            SizedBox(height: getSize(5)),
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
                      text: StringConstant.months,
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
            color: AppColors.primaryColor.withValues(alpha: 0.2),
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
            _buildPositionInfo(context,
                employerLongTermSuccessDto: employerLongTermSuccessDto),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
            GestureDetector(
              onTap: () {
                final location = employerLongTermSuccessDto?.location;
                final latitude = location?.latitude;
                final longitude = location?.longitude;
                if (latitude != null && longitude != null) {
                  LocationHelper.openDirections(context,
                      endLat: latitude, endLng: longitude);
                }
              },
              child: _buildLocationInfo(context,
                  employerLongTermSuccessDto: employerLongTermSuccessDto),
            ),
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
            color: AppColors.black.withValues(alpha: 0.5),
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
                  text:
                      "(${getIndustryText(employerLongTermSuccessDto?.industry ?? 0)} - ${employerLongTermSuccessDto?.listing_id})",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withValues(alpha: 0.5),
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
                        color: AppColors.black.withValues(alpha: 0.8),
                      ),
                      Gap(getSize(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                              text: StringConstant.startDate, fontSize: 10),
                          Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                    text: employerLongTermSuccessDto
                                        ?.start_date?.year
                                        .toString(),
                                    style: TextStyle(
                                        color: AppColors.green
                                            .withValues(alpha: 0.5)),
                                  )
                                ],
                                text:
                                    "${DateFormat("dd MMM").format(employerLongTermSuccessDto?.start_date ?? DateTime.now())}, "),
                            style: TextStyle(
                                fontSize: getSize(14),
                                fontWeight: FontWeight.w600,
                                color: AppColors.green),
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
                        color: AppColors.black.withValues(alpha: 0.8),
                      ),
                      Gap(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(text: StringConstant.endDate, fontSize: 10),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: employerLongTermSuccessDto
                                      ?.end_date?.year
                                      .toString(),
                                  style: TextStyle(
                                      color: AppColors.green
                                          .withValues(alpha: 0.5)),
                                )
                              ],
                              text:
                                  "${DateFormat("dd MMM").format(employerLongTermSuccessDto?.end_date ?? DateTime.now())}, ",
                            ),
                            style: TextStyle(
                                fontSize: getSize(14),
                                fontWeight: FontWeight.w600,
                                color: AppColors.green),
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
                        color: AppColors.black.withValues(alpha: 0.8),
                      ),
                      Gap(getSize(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                              text: StringConstant.applicationDeadline,
                              fontSize: 10),
                          Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                    text: employerLongTermSuccessDto
                                        ?.application_deadline?.year
                                        .toString(),
                                    style: TextStyle(
                                        color: AppColors.green
                                            .withValues(alpha: 0.5)),
                                  )
                                ],
                                text:
                                    "${DateFormat("dd MMM").format(employerLongTermSuccessDto?.application_deadline ?? DateTime.now())}, "),
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
                color: AppColors.primaryColor.withValues(alpha: 0.15),
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
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
                text: StringConstant.estimatedWeeklyHours,
                fontSize: 13,
                fontWeight: FontWeight.w500),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: BaseText(
                      text: formatTimeOfDay(
                          employerLongTermSuccessDto?.estimated_weekly_hours ??
                              TimeOfDay.now()),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
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

  Widget _buildShiftSchedule(
    BuildContext context, {
    required EmployerLongTermSuccessDto? employerLongTermSuccessDto,
  }) {
    final list = getShiftScheduleFromId(
        employerLongTermSuccessDto?.shift_schedule_type ?? "");

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
                text: StringConstant.shiftSchedule,
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
                      padding: EdgeInsets.all(getSize(8)),
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
        padding: EdgeInsets.symmetric(
            horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: StringConstant.languageRequirements,
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.8)),
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
            BaseText(
                text: StringConstant.locationDetails,
                fontSize: 12,
                textColor: AppColors.black.withValues(alpha: 0.8)),
            Divider(),
            Gap(getSize(4)),
            BaseText(
                text: StringConstant.location,
                fontSize: 12,
                textColor: AppColors.primaryColor),
            Gap(getSize(4)),
            BaseText(text: location?.location ?? "", fontSize: 14),
            Gap(getSize(10)),
            BaseText(
                text: StringConstant.unit,
                fontSize: 12,
                textColor: AppColors.primaryColor),
            Gap(getSize(4)),
            BaseText(
                text: employerLongTermSuccessDto?.location_unit ?? "",
                fontSize: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildCommonDividerTile(BuildContext context,
      {required String title, required String value}) {
    return Material(
      borderRadius: BorderRadius.circular(10),
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
                textColor: AppColors.black.withValues(alpha: 0.8)),
            Divider(),
            Gap(getSize(4)),
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
        padding: EdgeInsets.symmetric(
            horizontal: getSize(22), vertical: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BaseText(
                text: StringConstant.selectedTeams,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            Gap(getSize(10)),
            Material(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(getSize(14)),
                child: BaseText(
                    text: "${employerLongTermSuccessDto?.total_teams ?? 0}",
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
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
                      padding: EdgeInsets.all(getSize(8)),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BaseText(
                        text: employerLongTermSuccessDto?.teams?[index].name ??
                            "",
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
