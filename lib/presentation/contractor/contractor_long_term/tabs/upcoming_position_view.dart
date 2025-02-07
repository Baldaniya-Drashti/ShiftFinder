import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/contractor/contractor_long_time/contractor_long_term_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_long_term_dashboard/contractor_long_term_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class ContractorUpcomingPositionView extends StatelessWidget {
  const ContractorUpcomingPositionView({super.key});

  @override
  Widget build(BuildContext context) {
    print("Sdsdsdsd");
    return BlocBuilder<ContractorLongTermBloc, ContractorLongTermState>(
      builder: (context, state) {
        print("==>${state.upComingPositionList}");
        return PaginatedListView(
          isNoDataFound: state.upcomingNoDataFound,
          onRefresh: () {
            context.read<ContractorLongTermBloc>().add(
                ContractorLongTermEvent.fetchUpcomingPositionList(
                    refresh: true));
          },
          onLoading: () {
            context.read<ContractorLongTermBloc>().add(
                ContractorLongTermEvent.fetchUpcomingPositionList(
                    refresh: false));
          },
          refreshController:
              context.read<ContractorLongTermBloc>().upcomingRefreshController,
          child: state.upcomingLoading
              ? CenterLoadingIndicator()
              : state.upcomingIsErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(getSize(12)),
                      itemBuilder: (context, index) {
                        final data = state.upComingPositionList[index];

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
                              _buildPositionTile(context,
                                  contractorLongTerm: data),
                              Gap(getSize(12)),
                              CommonMaterialButton(
                                radius: 7,
                                height: 36,
                                onPressed: () {
                                  context.router.push(
                                    PageRouteInfo(
                                        EmployerLongTermPositionDetailView.name,
                                        args:
                                            EmployerLongTermPositionDetailViewArgs(
                                                id: data.id ?? -1)),
                                  );
                                },
                                label: "View Position Details",
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(.1),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Gap(16),
                      itemCount: state.upComingPositionList.length,
                    ),
        );
      },
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
                  text: contractorLongTerm?.role_lists_name ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text:
                      "(${getIndustryText(contractorLongTerm?.industry_id ?? 0)} - ${contractorLongTerm?.listing_id})",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
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
}
