import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_full_posting/employer_full_posting_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart';
import 'package:shift/infrastructure/core/employer_long_full_term_dashboard/employer_long_full_term_dashboard_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/dialogs.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerFullPostingView")
class EmployerFullPostingView extends StatelessWidget {
  const EmployerFullPostingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerFullPostingBloc>()
        ..add(EmployerFullPostingEvent.getEmployerFullPosition(
            context: context, refresh: true)),
      child: BlocBuilder<EmployerFullPostingBloc, EmployerFullPostingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
                onBackPressed: () => context.router.maybePop(),
                title: StringConstant.fullTimePositions),
            body: _EmployerFullPostingContent(state),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.all(getSize(16)).copyWith(top: getSize(12)),
              child: CommonButton(
                onPressed: () {
                  context.router
                      .push(PageRouteInfo(EmployerFullPositionAddView.name))
                      .then((value) {
                    context.read<EmployerFullPostingBloc>().add(
                        EmployerFullPostingEvent.getEmployerFullPosition(
                            context: context, refresh: true));
                  });
                },
                buttonText: StringConstant.postAFullTimePosition,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmployerFullPostingContent extends StatelessWidget {
  final EmployerFullPostingState state;
  const _EmployerFullPostingContent(this.state);

  @override
  Widget build(BuildContext context) {
    return PaginatedListView(
      onRefresh: () {
        context.read<EmployerFullPostingBloc>().add(
              EmployerFullPostingEvent.getEmployerFullPosition(
                refresh: true,
                context: context,
              ),
            );
      },
      onLoading: () {
        context.read<EmployerFullPostingBloc>().add(
              EmployerFullPostingEvent.getEmployerFullPosition(
                refresh: false,
                context: context,
              ),
            );
      },
      refreshController:
          context.read<EmployerFullPostingBloc>().refreshController,
      isNoDataFound: state.isNoDataFound,
      child: state.isLoading
          ? CenterLoadingIndicator(isOnlyLoader: true)
          : state.isErrorInAPI
              ? Center(
                  child: BaseText(text: StringConstant.somethindWentWrong),
                )
              : ListView.separated(
                  padding: EdgeInsets.all(getSize(12)),
                  separatorBuilder: (context, index) => Gap(getSize(16)),
                  itemCount: state.employerFullPosition.length,
                  itemBuilder: (context, index) {
                    final data = state.employerFullPosition[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(getSize(20)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.lightGrey.withValues(alpha: 0.2),
                            blurRadius: getSize(20),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(getSize(12)),
                        child: Column(
                          children: [
                            _buildPositionTile(context, employer: data),
                            Gap(getSize(10)),
                            _positionDetailButton(
                              context,
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
                            ),
                            Gap(getSize(10)),
                            _buildPositionDescription(context, employer: data),
                            Gap(getSize(10)),
                            _buildTotalApplication(
                              context,
                              employer: data,
                              onPressed: () {
                                if (state.employerFullPosition[index]
                                        .total_application_counts ==
                                    0) {
                                  return;
                                }
                                context.router
                                    .push(
                                  PageRouteInfo(
                                    EmployerFullPositionApplicantsView.name,
                                    args:
                                        EmployerFullPositionApplicantsViewArgs(
                                            id: data.id ?? -1),
                                  ),
                                )
                                    .then((value) {
                                  context.read<EmployerFullPostingBloc>().add(
                                      EmployerFullPostingEvent
                                          .getEmployerFullPosition(
                                              refresh: true, context: context));
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
        padding: EdgeInsets.all(getSize(8)).copyWith(right: 12, left: 12),
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
                text: employer.job_type == 1 ? "Full Time" : "Part Time",
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final result = await AppDialog.showCommonDialog(
                        context: context,
                        title: StringConstant.deleteThePosition,
                        content: StringConstant.deleteFullTimeDesc,
                        successLabel: StringConstant.delete,
                      );
                      if (result ?? false) {
                        context.read<EmployerFullPostingBloc>().add(
                              EmployerFullPostingEvent.deletePost(
                                  context: context, id: employer.id ?? -1),
                            );
                      }
                    },
                    child: SvgPicture.asset(SvgImageConstant.delete),
                  ),
                  if (employer.isEditable == true) ...[
                    Gap(getSize(16)),
                    GestureDetector(
                      onTap: () {
                        context.router
                            .push(
                          PageRouteInfo(
                            EmployerFullPositionAddView.name,
                            args: EmployerFullPositionAddViewArgs(
                              postId: employer.id ?? -1,
                              isCreate: false,
                            ),
                          ),
                        )
                            .then((value) {
                          context.read<EmployerFullPostingBloc>().add(
                              EmployerFullPostingEvent.getEmployerFullPosition(
                                  context: context, refresh: true));
                        });
                      },
                      child: SvgPicture.asset(SvgImageConstant.edit),
                    ),
                  ],
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

  Widget _buildPositionDescription(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto employer,
  }) {
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
                text: employer.position ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalApplication(
    BuildContext context, {
    required EmployerLongFullTermDashboardDto employer,
    required VoidCallback onPressed,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(getSize(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text: "Total Applications",
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
              Gap(getSize(8)),
              Row(
                children: [
                  BaseText(
                      text: "${employer.total_application_counts ?? 0}",
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      textColor: AppColors.primaryColor),
                  Gap(getSize(12)),
                  SvgPicture.asset(SvgImageConstant.threePerson, height: 30),
                  Spacer(),
                  if ((employer.total_application_profiles ?? []).isNotEmpty)
                    _EmployerStackedImage(
                      imageList: employer.total_application_profiles ?? [],
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmployerStackedImage extends StatelessWidget {
  const _EmployerStackedImage({required this.imageList});

  final List<ApplicationProfile> imageList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployerFullPostingBloc, EmployerFullPostingState>(
      builder: (context, state) {
        List<double> imagePosition = [0, 13, 26, 39, 52, 65];
        return SizedBox(
          width: getSize(100),
          height: getSize(30),
          // color: Colors.yellow,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < imageList.length; i++)
                if (i <= 5)
                  Positioned(
                    left: imagePosition[i],
                    child: Container(
                      width: getSize(30),
                      height: getSize(30),
                      decoration: BoxDecoration(
                        color: AppColors.authBlack,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: getSize(2),
                        ),
                        image: DecorationImage(
                          opacity: (imageList.length > 6 && i == 5) ? 0.4 : 100,
                          image: NetworkImage(
                            imageList[i].profile ?? "",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              if (imageList.length > 6)
                Align(
                  alignment: Alignment.centerRight,
                  child: BaseText(
                    text: "${imageList.length - 6}+",
                    fontSize: 9,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.white,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
