import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/employer_long_term/employer_long_term_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/contractor_home/contractor_dashboard_dto.dart';
import 'package:shift/infrastructure/core/employer_long_term_open_position/employer_long_term_open_position_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/helper_function.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

import '../../../../domain/core/string_constant.dart';

class OpenPositionTabView extends StatelessWidget {
  const OpenPositionTabView({super.key});

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
          refreshController: context.read<EmployerLongTermBloc>().openPositionController,
          isNoDataFound: state.isNoDataFound,
          child: state.isLoading
              ? CenterLoadingIndicator()
              : state.isErrorInAPI
                  ? Center(
                      child: BaseText(text: StringConstant.somethindWentWrong),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(getSize(12)),
                      separatorBuilder: (context, index) => Gap(getSize(16)),
                      itemCount: state.openPositionList.length,
                      itemBuilder: (context, index) {
                        final data = state.openPositionList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(getSize(20)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightGrey.withOpacity(0.1),
                                blurRadius: getSize(20),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(getSize(12)),
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
                                _buildTotalApplication(
                                  context,
                                  employer: data,
                                  onPressed: () {
                                    if (state.openPositionList[index].total_application_counts == 0) return;
                                    context.router.push(
                                      PageRouteInfo(
                                        EmployerLongTermApplicantView.name,
                                        args: EmployerLongTermApplicantViewArgs(id: data.id ?? -1),
                                      ),
                                    );
                                  },
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
    required EmployerLongTermOpenPositionDto employer,
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
    required EmployerLongTermOpenPositionDto employer,
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
          GestureDetector(
            onTap: () async {
              final result = await AppDialog.showCommonDialog(
                  context: context,
                  title: "Delete The Position",
                  content: "Are you sure you want to delete this long term position?",
                  successLabel: "Delete");
              if (result ?? false) {
                context.read<EmployerLongTermBloc>().add(
                      EmployerLongTermEvent.deletePost(context: context, id: employer.id ?? -1),
                    );
              }
            },
            child: SvgPicture.asset(SvgImageConstant.delete, height: 25),
          ),
          if(employer.isEditable??false)...[
            Gap(getSize(16)),
            GestureDetector(
              onTap: () {
                context.router.push(
                  PageRouteInfo(
                    EmployerLongTermPositionAddView.name,
                    args: EmployerLongTermPositionAddViewArgs(postId: employer.id ?? -1),
                  ),
                );
              },
              child: SvgPicture.asset(SvgImageConstant.edit, height: 25),
            ),
          ]

        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required EmployerLongTermOpenPositionDto employer,
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

  Widget _buildTotalApplication(
    BuildContext context, {
    required EmployerLongTermOpenPositionDto employer,
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
              BaseText(text: "Total Applications", fontSize: 12, fontWeight: FontWeight.w500),
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

  Widget _buildDateInfoSection(
    BuildContext context, {
    required EmployerLongTermOpenPositionDto employer,
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
                child: _buildDateInfoTile(context, title: 'Start Date:-', dateTime: employer.start_date ?? DateTime.now()),
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

class _EmployerStackedImage extends StatelessWidget {
  const _EmployerStackedImage({
    super.key,
    required this.imageList,
  });

  final List<ApplicationProfile> imageList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployerLongTermBloc, EmployerLongTermState>(
      builder: (context, state) {
        List<double> imagePosition = [0, 13, 26, 39, 52, 65];
        return Container(
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
