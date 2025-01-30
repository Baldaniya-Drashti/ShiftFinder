import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_long_term/employer_long_term_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class FilledPositionTabView extends StatelessWidget {
  const FilledPositionTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployerLongTermBloc, EmployerLongTermState>(
      builder: (context, state) {
        return PaginatedListView(
          onRefresh: () {
            context.read<EmployerLongTermBloc>().add(
                  EmployerLongTermEvent.getEmployerFilledPosition(
                    refresh: true,
                    context: context,
                  ),
                );
          },
          onLoading: () {
            context.read<EmployerLongTermBloc>().add(
                  EmployerLongTermEvent.getEmployerFilledPosition(
                    refresh: false,
                    context: context,
                  ),
                );
          },
          refreshController: context.read<EmployerLongTermBloc>().filledPositionController,
          isNoDataFound: state.fillPositionNoDataFound,
          child: state.fillPositionLoading
              ? CenterLoadingIndicator()
              : state.fillPositionErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(getSize(12)),
                      separatorBuilder: (context, index) => Gap(getSize(16)),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        final data = state.filledPositionList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.lightGrey.withOpacity(0.3),
                                  blurRadius: getSize(20),
                                  spreadRadius: 5),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(getSize(14)),
                            child: Column(
                              children: [
                                _buildPositionTile(context, employer: data),
                                Gap(getSize(12)),
                                _positionDetailButton(
                                  context,
                                  onPressed: () {
                                    context.router.push(
                                      PageRouteInfo(EmployerLongTermPositionDetailView.name,
                                          args: EmployerLongTermPositionDetailViewArgs(id: data.id ?? -1)),
                                    );
                                  },
                                ),
                                Gap(getSize(12)),
                                _buildDateInfoSection(context, employer: data),
                                Gap(getSize(12)),
                                Material(
                                  color: AppColors.scaffoldColor,
                                  borderRadius: BorderRadius.circular(7),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                    child: CommonInfoTile(
                                      leading: UserAvatar(url: ""),
                                      title: BaseText(
                                        text: "Darcel Ballentine",
                                        fontSize: 14,
                                      ),
                                      trailing: SvgPicture.asset(
                                        SvgImageConstant.rightArrow,
                                        height: 16,
                                        color: AppColors.black.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }

  Widget _buildPositionTile(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto employer,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.primaryColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context, employer: employer),
            Gap(6),
            Divider(color: AppColors.white.withOpacity(0.2)),
            Gap(6),
            _buildLocationInfo(context, employer: employer),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto employer,
  }) {
    return Material(
      color: AppColors.primaryColor,
      child: Row(
        children: [
          Image.asset(
            PngImageConstants.nurse2,
            height: getSize(50),
            color: AppColors.white,
          ),
          Gap(getSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: employer.roles_list_name ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.white,
                ),
                BaseText(
                  text: "(${getIndustryText(employer.industry ?? 0)} - ${employer.listing_id ?? ""})",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.white,
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
    required EmployerLongFullTermDashboardDto employer,
  }) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: employer.location?.location ?? "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textColor: AppColors.white,
      ),
    );
  }

  Widget _positionDetailButton(
    BuildContext context, {
    required VoidCallback onPressed,
  }) {
    return CommonButton(
      borderRadius: 7,
      height: 45,
      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
      onPressed: onPressed,
      buttonText: 'View Position Details',
      buttonFontSize: 12,
      buttonFontWeight: FontWeight.w600,
      buttonTextColor: AppColors.black,
    );
  }

  Widget _buildDateInfoSection(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto employer,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(16), vertical: getSize(8)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child:
                    _buildDateInfoTile(context, title: 'Start Date:-', dateTime: employer.start_date ?? DateTime.now()),
              ),
              VerticalDivider(),
              Gap(getSize(18)),
              Expanded(
                child: _buildDateInfoTile(
                  context,
                  title: 'End Date:-',
                  dateTime: employer.end_date ?? DateTime.now(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInfoTile(
    BuildContext context, {
    required String title,
    required DateTime dateTime,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(text: title, fontSize: 9),
        Text.rich(
          style: TextStyle(fontSize: getFontSize(10), fontWeight: FontWeight.w600),
          TextSpan(
            text: "${DateFormat("dd MMM").format(dateTime)},",
            children: [
              TextSpan(
                text: " ${dateTime.year.toString()}",
                style: TextStyle(color: AppColors.black.withOpacity(0.5)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
