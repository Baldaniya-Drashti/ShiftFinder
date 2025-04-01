// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_long_term/employer_long_term_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
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
          refreshController:
              context.read<EmployerLongTermBloc>().filledPositionController,
          isNoDataFound: state.fillPositionNoDataFound,
          child: state.fillPositionLoading
              ? CenterLoadingIndicator(isOnlyLoader: true)
              : state.fillPositionErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong))
                  : ListView.separated(
                      padding: EdgeInsets.all(getSize(12)),
                      separatorBuilder: (context, index) => Gap(getSize(16)),
                      itemCount: state.filledPositionList.length,
                      itemBuilder: (context, index) {
                        final data = state.filledPositionList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.lightGrey
                                      .withValues(alpha: 0.3),
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
                                      PageRouteInfo(
                                          EmployerLongTermPositionDetailView
                                              .name,
                                          args:
                                              EmployerLongTermPositionDetailViewArgs(
                                                  id: data.id ?? -1)),
                                    );
                                  },
                                ),
                                Gap(getSize(12)),
                                _buildDateInfoSection(context, employer: data),
                                Gap(getSize(12)),
                                (data.total_user == 1)
                                    ? GestureDetector(
                                        onTap: () {
                                          context.router.push(
                                            PageRouteInfo(
                                              ViewApplicantProfile.name,
                                              args: ViewApplicantProfileArgs(
                                                  id: data.user?[0].user_id ??
                                                      -1,
                                                  postId: data.id ?? -1,
                                                  isLongOrFull: 1),
                                            ),
                                          );
                                        },
                                        child: Material(
                                          color: AppColors.scaffoldColor,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: getSize(8),
                                                horizontal: getSize(12)),
                                            child: CommonInfoTile(
                                              leading: UserAvatar(
                                                  url: data.user?[0].profile ??
                                                      ""),
                                              title: BaseText(
                                                text:
                                                    "${data.user?[0].first_name ?? ""} ${data.user?[0].last_name ?? ""}",
                                                fontSize: 14,
                                              ),
                                              trailing: SvgPicture.asset(
                                                SvgImageConstant.rightArrow,
                                                height: 16,
                                                color: AppColors.black
                                                    .withValues(alpha: 0.5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: getSize(10),
                                          horizontal: getSize(15),
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.scaffoldColor,
                                          borderRadius: BorderRadius.circular(
                                              getSize(10)),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            context.router.push(PageRouteInfo(
                                                LongTermHiredContractorList
                                                    .name,
                                                args:
                                                    LongTermHiredContractorListArgs(
                                                  userList: data.user ?? [],
                                                  postId: data.id ?? -1,
                                                )));
                                          },
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColors.transparent,
                                                radius: getSize(20),
                                                child: SvgPicture.asset(
                                                  SvgImageConstant
                                                      .threePersonCircle,
                                                ),
                                              ),
                                              SizedBox(width: getSize(10)),
                                              BaseText(
                                                text:
                                                    "${StringConstant.allHiredContractors} (${data.hired_user}/${data.total_user})",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: getSize(16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
        padding: EdgeInsets.all(getSize(8))
            .copyWith(right: getSize(12), left: getSize(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              dense: true,
              leading: SvgPicture.asset(
                SvgImageConstant.female,
                width: getSize(36.28),
                height: getSize(43.41),
              ),
              title: BaseText(
                text: employer.roles_list_name ?? "",
                textColor: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                maxLines: 1,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseText(
                    text:
                        "(${getIndustryText(employer.industry ?? 0)} - ${employer.listing_id ?? ""})",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.white.withValues(alpha: 0.80),
                  ),
                  BaseText(
                    text: employer.location?.facility_type?.name ?? "",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.white.withValues(alpha: 0.80),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              minTileHeight: getSize(43.41),
            ),
            Divider(color: AppColors.white.withValues(alpha: 0.2)),
            Gap(getSize(4)),
            GestureDetector(
                onTap: () {
                  final location = employer.location;
                  final latitude = location?.latitude;
                  final longitude = location?.longitude;
                  if (latitude != null && longitude != null) {
                    LocationHelper.openDirections(context,
                        endLat: latitude, endLng: longitude);
                  }
                },
                child: _buildLocationInfo(context, employer: employer)),
            Gap(getSize(4)),
          ],
        ),
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
      backgroundColor: AppColors.primaryColor.withValues(alpha: 0.2),
      onPressed: onPressed,
      buttonText: StringConstant.viewPositionDetails,
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
          padding: EdgeInsets.symmetric(
              horizontal: getSize(16), vertical: getSize(8)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: _buildDateInfoTile(context,
                    title: 'Start Date:-',
                    dateTime: employer.start_date ?? DateTime.now()),
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
          style:
              TextStyle(fontSize: getFontSize(10), fontWeight: FontWeight.w600),
          TextSpan(
            text: "${DateFormat("dd MMM").format(dateTime)},",
            children: [
              TextSpan(
                text: " ${dateTime.year.toString()}",
                style: TextStyle(color: AppColors.black.withValues(alpha: 0.5)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
