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
import 'package:shift/infrastructure/core/employer_home/employer_dashboard_dto.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class ContractorFullTimeOpenPositionView extends StatelessWidget {
  const ContractorFullTimeOpenPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorFullTimePositionBloc, ContractorFullTimePositionState>(
      builder: (context, state) {
        return Stack(
          children: [
            PaginatedListView(
              isNoDataFound: state.isNoDataFound,
              onRefresh: () {
                context
                    .read<ContractorFullTimePositionBloc>()
                    .add(ContractorFullTimePositionEvent.fetchOpenPositionList(refresh: true));
              },
              onLoading: () {
                context
                    .read<ContractorFullTimePositionBloc>()
                    .add(ContractorFullTimePositionEvent.fetchOpenPositionList(refresh: false));
              },
              refreshController: context.read<ContractorFullTimePositionBloc>().openRefreshController,
              child: state.isLoading
                  ? CenterLoadingIndicator()
                  : state.isErrorInAPI
                      ? Center(
                          child: BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(getSize(12)),
                          itemBuilder: (context, index) {
                            final data = state.openPositionList[index];
                            return Container(
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
                              child: Column(
                                children: [
                                  _buildPositionTile(context, employerFullPosting: data),
                                  Gap(getSize(12)),
                                  CommonMaterialButton(
                                    radius: 7,
                                    height: 36,
                                    onPressed: () {
                                      context.router.push(
                                        PageRouteInfo(EmployerLongTermPositionDetailView.name,
                                            args: EmployerLongTermPositionDetailViewArgs(id: data.id ?? -1)),
                                      );
                                    },
                                    label: "View Position Details",
                                    backgroundColor: AppColors.primaryColor.withOpacity(.1),
                                  ),
                                  Gap(getSize(12)),
                                  _buildApplicationInformation(context, contractorLongTerm: data),
                                  Gap(getSize(10)),
                                  _buildEstimatedHours(context, contractorLongTerm: data),
                                  Gap(getSize(12)),
                                  _buildShiftSchedule(context, contractorLongTerm: data),
                                  Gap(getSize(12)),
                                  _buildNumberOfVacancy(context, employerFullPosting: data),
                                  Gap(getSize(12)),
                                  CommonButton(
                                    borderRadius: 10,
                                    onPressed: () async {
                                      final result = await AppDialog.showCommonDialog(
                                        context: context,
                                        title: "Apply",
                                        extraContent: "Are you sure you want to apply for this position?",
                                        content:
                                            "If hired for this long term position, the employer will be responsible for making payments directly to you. ShiftFinder is not liable for any disputes, including those related to non-payment or contract violations.",
                                        successLabel: "Apply",
                                      );
                                      if (result ?? false) {
                                        /*    context.read<ContractorFullTimePositionBloc>().add(
                              ContractorFullTimePositionEvent.applyOpenPosition(context: context, id: data.id ?? -1),
                            );*/
                                      }
                                    },
                                    buttonText: "Apply",
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gap(16),
                          itemCount: state.openPositionList.length,
                        ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
    );
  }

  Widget _buildNumberOfVacancy(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto? employerFullPosting,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(22), vertical: getSize(14)),
        child: Row(
          children: [
            Expanded(
              child: BaseText(text: "Number of Vacancies", fontSize: 12, fontWeight: FontWeight.w500),
            ),
            BaseText(
                text: "${employerFullPosting?.number_of_vacancie ?? ""}",
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
      decoration: BoxDecoration(color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
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
    required EmployerLongFullTermDashboardDto? employerFullPosting,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context, employerFullPosting: employerFullPosting),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
            _buildLocationInfo(context, employerFullPosting: employerFullPosting),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto? employerFullPosting,
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
                  text: employerFullPosting?.roles_list_name ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: "(${getIndustryText(employerFullPosting?.industry ?? 0)} - ${employerFullPosting?.listing_id})",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          BaseText(
            text: employerFullPosting?.last_ago ?? "",
            fontSize: 10,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto? employerFullPosting,
  }) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: employerFullPosting?.location?.location ?? "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildApplicationInformation(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto? contractorLongTerm,
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
                            TextSpan(
                                children: [
                                  TextSpan(
                                    text: contractorLongTerm?.start_date?.year.toString(),
                                    style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                                  )
                                ],
                                text:
                                    "${DateFormat("dd MMM").format(contractorLongTerm?.start_date ?? DateTime.now())}, "),
                            style:
                                TextStyle(fontSize: getSize(14), fontWeight: FontWeight.w600, color: AppColors.green),
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
                                  text: contractorLongTerm?.end_date?.year.toString(),
                                  style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                                )
                              ],
                              text: "${DateFormat("dd MMM").format(contractorLongTerm?.end_date ?? DateTime.now())}, ",
                            ),
                            style:
                                TextStyle(fontSize: getSize(14), fontWeight: FontWeight.w600, color: AppColors.green),
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
                                    text: contractorLongTerm?.application_deadline?.year.toString(),
                                    style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                                  )
                                ],
                                text:
                                    "${DateFormat("dd MMM").format(contractorLongTerm?.application_deadline ?? DateTime.now())}, "),
                            style:
                                TextStyle(fontSize: getSize(14), fontWeight: FontWeight.w600, color: AppColors.green),
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
    required EmployerLongFullTermDashboardDto? contractorLongTerm,
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
                      text: formatTimeOfDay(contractorLongTerm?.estimated_weekly_hours ?? TimeOfDay.now()),
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
    required EmployerLongFullTermDashboardDto? contractorLongTerm,
  }) {
    final list = getShiftScheduleFromId(contractorLongTerm?.shift_schedule_type ?? "");

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
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey), borderRadius: BorderRadius.circular(10)),
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
