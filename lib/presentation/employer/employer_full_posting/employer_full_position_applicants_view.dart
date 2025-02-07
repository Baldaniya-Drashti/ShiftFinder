import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/employer_full_posting_applicant/employer_full_posting_applicant_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_long_term_applicant/employer_long_term_applicant_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerFullPositionApplicantsView")
class EmployerFullPositionApplicantsView extends StatelessWidget {
  const EmployerFullPositionApplicantsView({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EmployerFullPostingApplicantBloc>()
        ..add(
          EmployerFullPostingApplicantEvent.getApplicants(
              context: context, id: id, refresh: true),
        ),
      child: Scaffold(
        appBar: CommonAppBar(
            onBackPressed: () => context.router.maybePop(),
            title: "View Applicants"),
        body: BlocBuilder<EmployerFullPostingApplicantBloc,
            EmployerFullPostingApplicantState>(
          builder: (context, state) {
            return PaginatedListView(
              onRefresh: () {
                context.read<EmployerFullPostingApplicantBloc>().add(
                      EmployerFullPostingApplicantEvent.getApplicants(
                          context: context, id: id, refresh: true),
                    );
              },
              onLoading: () {
                context.read<EmployerFullPostingApplicantBloc>().add(
                      EmployerFullPostingApplicantEvent.getApplicants(
                          context: context, id: id, refresh: false),
                    );
              },
              refreshController: context
                  .read<EmployerFullPostingApplicantBloc>()
                  .refreshController,
              isNoDataFound: state.isNoDataFound,
              child: state.isLoading
                  ? CenterLoadingIndicator()
                  : state.isErrorInAPI
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(getSize(16)).copyWith(top: 0),
                          separatorBuilder: (context, index) => Gap(16),
                          itemCount: state.applicantsList.length,
                          itemBuilder: (context, index) {
                            final data = state.applicantsList[index];
                            return Material(
                              color: AppColors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(getSize(20))),
                              child: Padding(
                                padding: EdgeInsets.all(getSize(12)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildPositionTile(context, data: data),
                                    Gap(getSize(12)),
                                    CommonMaterialButton(
                                      radius: 7,
                                      height: 36,
                                      onPressed: () {
                                        context.router.push(
                                          PageRouteInfo(
                                            ViewApplicantProfile.name,
                                            args: ViewApplicantProfileArgs(
                                                id: data.user_id ?? -1,
                                                postId: data.post_id ?? -1,
                                                isLongOrFull: 1),
                                          ),
                                        );
                                      },
                                      label: "View Profile",
                                      backgroundColor: AppColors.primaryColor
                                          .withOpacity(.1),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPositionTile(
    BuildContext context, {
    required EmployerLongTermApplicantDto data,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPositionInfo(context, data: data),
            Gap(getSize(6)),
            Divider(),
            Gap(getSize(6)),
            _buildLocationInfo(context, data: data),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionInfo(
    BuildContext context, {
    required EmployerLongTermApplicantDto data,
  }) {
    return Material(
      color: AppColors.scaffoldColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(url: data.profile ?? "", size: 45),
          Gap(getSize(16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: "${data.first_name ?? ""} ${data.last_name ?? ""}",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                BaseText(
                  text: data.distance ?? "",
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
          BaseText(
            text: data.last_ago ?? "",
            fontSize: 10,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required EmployerLongTermApplicantDto data,
  }) {
    return CommonInfoTile(
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: data.location ?? "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
