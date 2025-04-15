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
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class ContractorFullTimeAppliedPositionView extends StatelessWidget {
  const ContractorFullTimeAppliedPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContractorFullTimePositionBloc>()
        ..add(ContractorFullTimePositionEvent.fetchAppliedPositionList(
            refresh: true)),
      child: BlocBuilder<ContractorFullTimePositionBloc,
          ContractorFullTimePositionState>(
        builder: (context, state) {
          return Stack(
            children: [
              PaginatedListView(
                isNoDataFound: state.appliedNoDataFound,
                onRefresh: () {
                  context.read<ContractorFullTimePositionBloc>().add(
                      ContractorFullTimePositionEvent.fetchAppliedPositionList(
                          refresh: true));
                },
                onLoading: () {
                  context.read<ContractorFullTimePositionBloc>().add(
                      ContractorFullTimePositionEvent.fetchAppliedPositionList(
                          refresh: false));
                },
                refreshController: context
                    .read<ContractorFullTimePositionBloc>()
                    .appliedRefreshController,
                child: state.appliedLoading
                    ? CenterLoadingIndicator(isOnlyLoader: true)
                    : state.appliedIsErrorInAPI
                        ? Center(
                            child: BaseText(
                                text: StringConstant.somethindWentWrong),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.all(getSize(12)),
                            itemBuilder: (context, index) {
                              final data = state.appliedPositionList[index];
                              return BaseTileDecoration(
                                child: Column(
                                  children: [
                                    _buildPositionTile(context,
                                        contractorFullPosting: data),
                                    Gap(getSize(12)),
                                    _buildSalaryInformation(context,
                                        contractorFullPosting: data),
                                    Gap(getSize(12)),
                                    _buildPositionDescription(context,
                                        contractorFullPosting: data),
                                    Gap(getSize(12)),
                                    _buildButtons(context,
                                        contractorFullPosting: data)
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Gap(getSize(16)),
                            itemCount: state.appliedPositionList.length,
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

  Widget _buildPositionDescription(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorFullPosting,
  }) {
    return Material(
      color: AppColors.scaffoldColor,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
                text: StringConstant.position,
                fontSize: 12,
                fontWeight: FontWeight.w500),
            Divider(),
            BaseText(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                text: contractorFullPosting?.position ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryInformation(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorFullPosting,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
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
                              text: contractorFullPosting?.compensation_type ==
                                      "1"
                                  ? StringConstant.rate
                                  : StringConstant.salary,
                              fontSize: 12),
                          BaseText(
                            text: "${contractorFullPosting?.rate_hour ?? ""}",
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
                          BaseText(
                              text: StringConstant.applicationDeadline,
                              fontSize: 12),
                          Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "${contractorFullPosting?.application_deadline?.year}",
                                    style: TextStyle(
                                        color: AppColors.green
                                            .withValues(alpha: 0.5)),
                                  )
                                ],
                                text:
                                    "${DateFormat("dd MMM").format(contractorFullPosting?.application_deadline ?? DateTime.now())}, "),
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

  Widget _buildButtons(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorFullPosting,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (contractorFullPosting?.is_delete == 1)
          Padding(
            padding: EdgeInsets.symmetric(vertical: getSize(10)),
            child: BaseText(
              text: StringConstant.employerCancelledThisShift,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: AppColors.redAccent,
            ),
          )
        else if (contractorFullPosting?.deleteAt == true &&
            contractorFullPosting?.request == 0) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: getSize(10)),
            child: BaseText(
              text: StringConstant.youHaveCancelledThisShiftApplication,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: AppColors.redAccent,
            ),
          )
        ] else ...[
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(7),
              color: AppColors.scaffoldColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    context.router.push(
                      PageRouteInfo(EmployerFullPositionPositionDetailView.name,
                          args: EmployerFullPositionPositionDetailViewArgs(
                              id: contractorFullPosting?.post_id ?? -1)),
                    );
                  },
                  child: BaseText(
                    text: StringConstant.viewShiftDetails,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Gap(getSize(14)),
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(7),
              color: AppColors.redAccent.withValues(alpha: 0.15),
              child: InkWell(
                onTap: () async {
                  final result = await AppDialog.showCommonDialog(
                    context: context,
                    title: StringConstant.ok,
                    content:
                        "Are you sure you want to cancel this application?",
                    successLabel: StringConstant.ok,
                  );
                  if (result ?? false) {
                    context.read<ContractorFullTimePositionBloc>().add(
                          ContractorFullTimePositionEvent.confirmRejectOffer(
                            context: context,
                            id: contractorFullPosting?.id ?? -1,
                            urgent_action: 2,
                          ),
                        );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(getSize(8)),
                  child: BaseText(
                    text: StringConstant.cancelApplication,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}
