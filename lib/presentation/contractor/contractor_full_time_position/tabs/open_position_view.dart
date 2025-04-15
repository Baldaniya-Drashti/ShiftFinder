// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_full_time_position/contractor_full_time_position_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_long_term_dashboard/contractor_long_term_dashboard_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class ContractorFullTimeOpenPositionView extends StatelessWidget {
  const ContractorFullTimeOpenPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorFullTimePositionBloc>()
        ..add(ContractorFullTimePositionEvent.fetchOpenPositionList(
            refresh: true)),
      child: BlocBuilder<ContractorFullTimePositionBloc,
          ContractorFullTimePositionState>(
        builder: (context, state) {
          return Stack(
            children: [
              PaginatedListView(
                isNoDataFound: state.isNoDataFound,
                onRefresh: () {
                  context.read<ContractorFullTimePositionBloc>().add(
                      ContractorFullTimePositionEvent.fetchOpenPositionList(
                          refresh: true));
                },
                onLoading: () {
                  context.read<ContractorFullTimePositionBloc>().add(
                      ContractorFullTimePositionEvent.fetchOpenPositionList(
                          refresh: false));
                },
                refreshController: context
                    .read<ContractorFullTimePositionBloc>()
                    .openRefreshController,
                child: state.isLoading
                    ? CenterLoadingIndicator(isOnlyLoader: true)
                    : state.isErrorInAPI
                        ? Center(
                            child: BaseText(
                                text: StringConstant.somethindWentWrong))
                        : ListView.separated(
                            padding: EdgeInsets.all(getSize(12)),
                            itemBuilder: (context, index) {
                              final data = state.openPositionList[index];
                              return Container(
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
                                child: Column(
                                  children: [
                                    _buildPositionTile(context,
                                        contractorFullPosting: data),
                                    Gap(getSize(12)),
                                    CommonMaterialButton(
                                      radius: 7,
                                      height: 36,
                                      onPressed: () {
                                        context.router.push(
                                          PageRouteInfo(
                                              EmployerFullPositionPositionDetailView
                                                  .name,
                                              args:
                                                  EmployerFullPositionPositionDetailViewArgs(
                                                      id: data.id ?? -1)),
                                        );
                                      },
                                      label: StringConstant.viewPositionDetails,
                                      backgroundColor: AppColors.primaryColor
                                          .withValues(alpha: .1),
                                    ),
                                    Gap(getSize(12)),
                                    _buildSalaryInformation(context,
                                        employerFullPosting: data),
                                    Gap(getSize(10)),
                                    _buildEstimatedHours(context,
                                        contractorFullPosting: data),
                                    Gap(getSize(12)),
                                    _buildShiftSchedule(context,
                                        contractorFullPosting: data),
                                    Gap(getSize(12)),
                                    _buildNumberOfVacancy(context,
                                        contractorFullPosting: data),
                                    Gap(getSize(12)),
                                    CommonButton(
                                      borderRadius: 10,
                                      onPressed: () async {
                                        final result =
                                            await AppDialog.showCommonDialog(
                                          context: context,
                                          title: StringConstant.apply,
                                          extraContent: StringConstant
                                              .areYouSureYouWantToApplyForThisPosition,
                                          content:
                                              StringConstant.fullTimeApplyDesc,
                                          successLabel: StringConstant.apply,
                                        );
                                        if (result ?? false) {
                                          context
                                              .read<
                                                  ContractorFullTimePositionBloc>()
                                              .add(
                                                  ContractorFullTimePositionEvent
                                                      .applyOpenPosition(
                                                          context: context,
                                                          id: data.id ?? -1));
                                        }
                                      },
                                      buttonText: StringConstant.apply,
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Gap(16),
                            itemCount: state.openPositionList.length,
                          ),
              ),
              if (state.postDataLoading)
                CenterLoadingIndicator(isOnlyLoader: true)
            ],
          );
        },
      ),
    );
  }

  Widget _buildNumberOfVacancy(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorFullPosting,
  }) {
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
                text: "${contractorFullPosting?.number_of_vacancie ?? ""}",
                fontSize: 14,
                textColor: AppColors.primaryColor),
          ],
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
    required ContractorLongTermDashboardDto? contractorFullPosting,
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
                contractorFullPosting: contractorFullPosting),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
            GestureDetector(
              onTap: () {
                final location = contractorFullPosting?.location;
                final latitude = location?.latitude;
                final longitude = location?.longitude;
                if (latitude != null && longitude != null) {
                  LocationHelper.openDirections(context,
                      endLat: latitude, endLng: longitude);
                }
              },
              child: _buildLocationInfo(context,
                  contractorFullPosting: contractorFullPosting),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorFullPosting,
  }) {
    final jobType = contractorFullPosting?.job_type == "1"
        ? StringConstant.fullTime
        : StringConstant.partTime;

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
                  text: jobType,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text:
                      "(${getIndustryText(contractorFullPosting?.industry_id ?? 0)} - ${contractorFullPosting?.listing_id})",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
          BaseText(
            text: contractorFullPosting?.last_ago ?? "",
            fontSize: 10,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorFullPosting,
  }) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: contractorFullPosting?.location?.location ?? "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildSalaryInformation(
    BuildContext context, {
    required ContractorLongTermDashboardDto employerFullPosting,
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
                      SvgPicture.asset(SvgImageConstant.dollorRound,
                          height: getSize(18)),
                      Gap(getSize(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                              text: employerFullPosting.compensation_type == '1'
                                  ? StringConstant.rate
                                  : StringConstant.salary,
                              fontSize: 12),
                          BaseText(
                            text: "${employerFullPosting.rate_hour ?? ""}",
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
                        color: AppColors.black.withValues(alpha: 0.8),
                      ),
                      Gap(getSize(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                              text: StringConstant.applicationDeadline,
                              fontSize: 12),
                          Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${employerFullPosting.application_deadline?.year}",
                                    style: TextStyle(
                                        color: AppColors.green
                                            .withValues(alpha: 0.5)),
                                  )
                                ],
                                text:
                                    "${DateFormat("dd MMM").format(employerFullPosting.application_deadline ?? DateTime.now())}, "),
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
    required ContractorLongTermDashboardDto? contractorFullPosting,
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
                          contractorFullPosting?.estimated_weekly_hours ??
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
    required ContractorLongTermDashboardDto? contractorFullPosting,
  }) {
    final list = getShiftScheduleFromId(
        contractorFullPosting?.shift_schedule_type ?? "");

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
}
