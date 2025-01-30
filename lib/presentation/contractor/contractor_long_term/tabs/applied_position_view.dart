import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/contractor/contractor_long_time/contractor_long_term_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_long_term_dashboard/contractor_long_term_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/common/widgets/show_picked_file.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

class ContractorLongTermAppliedPosition extends StatelessWidget {
  const ContractorLongTermAppliedPosition({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorLongTermBloc, ContractorLongTermState>(
      builder: (context, state) {
        return Stack(
          children: [
            PaginatedListView(
              isNoDataFound: state.appliedNoDataFound,
              onRefresh: () {
                context.read<ContractorLongTermBloc>().add(ContractorLongTermEvent.fetchAppliedPositionList(refresh: true));
              },
              onLoading: () {
                context.read<ContractorLongTermBloc>().add(ContractorLongTermEvent.fetchAppliedPositionList(refresh: false));
              },
              refreshController: context.read<ContractorLongTermBloc>().appliedRefreshController,
              child: state.appliedLoading
                  ? CenterLoadingIndicator()
                  : state.appliedIsErrorInAPI
                      ? Center(
                          child: BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(getSize(12)),
                          itemBuilder: (context, index) {
                            final data = state.appliedPositionList[index];
                            print("===rr${data}");
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
                                  _buildPositionTile(context, contractorLongTerm: data),
                                  Gap(getSize(10)),
                                  if(data.request != 0 && data.urgent_action != 0)...[
                                    CommonMaterialButton(
                                      radius: 7,
                                      height: 36,
                                      onPressed: () {
                                        context.router.push(
                                          PageRouteInfo(EmployerLongTermPositionDetailView.name,
                                              args: EmployerLongTermPositionDetailViewArgs(id: data.post_id ?? -1)),
                                        );
                                      },
                                      label: "View Position Details",
                                      backgroundColor: AppColors.primaryColor.withOpacity(.1),
                                    ),
                                    Gap(getSize(10)),

                                  ],

                                  _buildApplicationInformation(context, contractorLongTerm: data),
                                  Gap(getSize(12)),

                                  if (data.offer_expires_status == true) ...[
                                    // if (data.request == 1 && data.urgent_action == 0) ...[
                                    //   ///Decline prtion 1
                                    // ] else if (data.request == 2 && data.urgent_action == 0) ...[
                                    //   ///2
                                    // ] else ...[
                                    //   ///4
                                    // ]

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                SvgImageConstant.clock,
                                                color: AppColors.redAccent,
                                                height: 16,
                                              ),
                                              Gap(5),
                                              BaseText(
                                                text: "Offer Expired",
                                                fontSize: 12,
                                                textColor: AppColors.redAccent,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Gap(12),
                                        Expanded(
                                          child: CommonMaterialButton(
                                            onPressed: () {
                                              context.router.push(
                                                PageRouteInfo(EmployerLongTermPositionDetailView.name,
                                                    args: EmployerLongTermPositionDetailViewArgs(id: data.post_id ?? -1)),
                                              );
                                            },
                                            label: "View Position Details",
                                            backgroundColor: Color(0xFFF5F5F5),
                                            radius: 7,
                                          ),
                                        ),
                                      ],
                                    )
                                  ] else ...[
                                    if (data.deleteAt == true && data.request == 0) ...[
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: getSize(10)),
                                        child: BaseText(
                                          text: StringConstant.youHaveCancelledThisShiftApplication,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          textColor: AppColors.redAccent,
                                        ),
                                      )
                                    ] else if (data.deleteAt == true && data.request == 1)
                                      ...[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: getSize(10)),
                                          child: BaseText(
                                            text: StringConstant
                                                .youHaveDeclinedThisShift,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            textColor: AppColors.redAccent,
                                          ),
                                        )
                                      ]
                                    else if (data.request == 1 && data.urgent_action == 0) ...[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          BaseText(text: "Please Note", fontSize: 10),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(text: "Offer Expires on ", style: TextStyle(color: Colors.black, fontSize: 12)),
                                                TextSpan(
                                                  text: DateFormat("dd MMM yyyy").format(data.offer_expires ?? DateTime.now()),
                                                  style: TextStyle(color: AppColors.primaryColor, fontSize: 12),
                                                ),
                                                TextSpan(text: " at ", style: TextStyle(color: Colors.black, fontSize: 12)),
                                                TextSpan(
                                                  text: DateFormat("hh:mm a").format(data.offer_expires ?? DateTime.now()),
                                                  style: TextStyle(color: AppColors.primaryColor, fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Gap(8),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: CommonMaterialButton(
                                                  onPressed: () async {
                                                    final result = await AppDialog.showCommonDialog(
                                                      context: context,
                                                      content: "Are you sure you want to decline this offer?",
                                                      title: "Decline Offer",
                                                      successLabel: "Confirm",
                                                    );
                                                    if (result ?? false) {
                                                      context.read<ContractorLongTermBloc>().add(
                                                            ContractorLongTermEvent.confirmRejectOffer(
                                                              context: context,
                                                              id: data.id ?? -1,
                                                              urgent_action: 2,
                                                            ),
                                                          );
                                                    }
                                                  },
                                                  label: "Decline Offer",
                                                  backgroundColor: AppColors.red.withOpacity(0.15),
                                                  radius: 7,
                                                ),
                                              ),
                                              Gap(12),
                                              Flexible(
                                                child: CommonMaterialButton(
                                                  onPressed: () async {
                                                    final result = await AppDialog.showCommonDialog(
                                                      context: context,
                                                      content: "Are you sure you want to confirm the offer for this position?",
                                                      title: "Confirm Acceptance",
                                                      successLabel: "Confirm",
                                                    );
                                                    if (result ?? false) {
                                                      context.read<ContractorLongTermBloc>().add(
                                                            ContractorLongTermEvent.confirmRejectOffer(
                                                              context: context,
                                                              id: data.id ?? -1,
                                                              urgent_action: 1,
                                                            ),
                                                          );
                                                    }
                                                  },
                                                  label: "Confirm Acceptance",
                                                  backgroundColor: AppColors.primaryColor,
                                                  textStyle: TextStyle(color: Colors.white, fontSize: getSize(12)),
                                                  radius: 7,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ] else if (data.request == 0 && data.urgent_action == 0) ...[
                                      Row(
                                        children: [
                                          Flexible(
                                            child: CommonMaterialButton(
                                              onPressed: () {
                                                context.router.push(
                                                  PageRouteInfo(EmployerLongTermPositionDetailView.name,
                                                      args: EmployerLongTermPositionDetailViewArgs(id: data.post_id ?? -1)),
                                                );
                                              },
                                              label: "View Position Details",
                                              backgroundColor: Color(0xFFF5F5F5),
                                              radius: 7,
                                            ),
                                          ),
                                          Gap(12),
                                          Flexible(
                                            child: CommonMaterialButton(
                                              onPressed: () async {
                                                final result = await AppDialog.showCommonDialog(
                                                  context: context,
                                                  content: "Are you sure you want to decline this offer?",
                                                  title: "Decline Offer",
                                                  successLabel: "Cancel",
                                                );
                                                if (result ?? false) {
                                                  context.read<ContractorLongTermBloc>().add(
                                                        ContractorLongTermEvent.confirmRejectOffer(
                                                          context: context,
                                                          id: data.post_id ?? -1,
                                                          urgent_action: 2,
                                                        ),
                                                      );
                                                }
                                              },
                                              label: "Cancel Application",
                                              backgroundColor: AppColors.red.withOpacity(0.15),
                                              radius: 7,
                                            ),
                                          )
                                        ],
                                      )
                                    ]
                                  ],
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gap(16),
                          itemCount: state.appliedPositionList.length,
                        ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
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
    required ContractorLongTermDashboardDto? contractorLongTerm,
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
            value: "\$${contractorLongTerm?.rate_hour}",
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
                value: "${contractorLongTerm?.total_months ?? ""}",
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
    required ContractorLongTermDashboardDto? contractorLongTerm,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context, contractorLongTerm: contractorLongTerm),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
            _buildLocationInfo(context, contractorLongTerm: contractorLongTerm),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorLongTerm,
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
                  text: contractorLongTerm?.roles_lists_name ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: "(${getIndustryText(contractorLongTerm?.industry_id ?? 0)} - ${contractorLongTerm?.listing_id})",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          BaseText(
            text: contractorLongTerm?.last_ago ?? "",
            fontSize: 10,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorLongTerm,
  }) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: contractorLongTerm?.location?.location ?? "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  Widget _buildApplicationInformation(
    BuildContext context, {
    required ContractorLongTermDashboardDto? contractorLongTerm,
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
                                text: contractorLongTerm?.start_date?.year.toString(),
                                style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                              )
                            ], text: "${DateFormat("dd MMM").format(contractorLongTerm?.start_date ?? DateTime.now())}, "),
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
                                  text: contractorLongTerm?.end_date?.year.toString(),
                                  style: TextStyle(color: AppColors.green.withOpacity(0.5)),
                                )
                              ],
                              text: "${DateFormat("dd MMM").format(contractorLongTerm?.end_date ?? DateTime.now())}, ",
                            ),
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
}
