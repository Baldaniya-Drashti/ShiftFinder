import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class PreviousShiftFavView extends StatelessWidget {
  const PreviousShiftFavView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(getSize(20)),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: getSize(20), bottom: getSize(20)),
                child: BaseText(
                  text: StringConstant.favoriteDesc,
                  fontSize: getFontSize(12),
                ),
              ),
              Expanded(
                child: (state.postDataLoading)
                    ? CenterLoadingIndicator(isOnlyLoader: true)
                    : PaginatedListView(
                        onRefresh: () {
                          context.read<PreviousShiftBloc>().add(
                              PreviousShiftEvent.fetchFavoriteList(
                                  refresh: true));
                          context.read<PreviousShiftBloc>().add(
                                PreviousShiftEvent.fetchAllPreviousPost(
                                    refresh: true, sortBy: 1),
                              );
                        },
                        onLoading: () {
                          context.read<PreviousShiftBloc>().add(
                              PreviousShiftEvent.fetchFavoriteList(
                                  refresh: false));
                        },
                        refreshController:
                            context.read<PreviousShiftBloc>().favorite,
                        isNoDataFound: state.favoriteListNoDataFound,
                        child: state.favoriteListLoading
                            ? CenterLoadingIndicator(isOnlyLoader: true)
                            : state.favoriteListIsErrorApi
                                ? Center(
                                    child: BaseText(
                                        text:
                                            StringConstant.somethindWentWrong),
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) =>
                                        _PreviousShiftFavTile(
                                      data: state.favoritesList[index],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        Gap(getSize(16)),
                                    itemCount: state.favoritesList.length,
                                  ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PreviousShiftFavTile extends StatelessWidget {
  const _PreviousShiftFavTile({
    required this.data,
  });

  final EmployerPreviousShiftDto data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          PageRouteInfo(ViewApplicantProfile.name,
              args: ViewApplicantProfileArgs(
                  id: data.user_id ?? -1, postId: data.post_id ?? -1)),
        );
      },
      child: BaseTileDecoration(
        padding: EdgeInsets.all(getSize(12)),
        child: Material(
          borderRadius: BorderRadius.circular(getSize(16)),
          color: AppColors.scaffoldColor,
          child: UserInfoTile(
            titleIcon: SvgPicture.asset(
              SvgImageConstant.rightArrow,
              height: 13,
              width: 13,
              colorFilter: ColorFilter.mode(
                  AppColors.black.withValues(alpha: 0.5), BlendMode.srcIn),
            ),
            padding: EdgeInsets.symmetric(horizontal: getSize(16)),
            url: data.profile ?? "",
            title: "${data.first_name ?? ""} ${data.last_name ?? ""}",
            subTitle: "${data.role_lists_name}",
            trailing: CommonMaterialButton.icon(
              radius: 10.0,
              backgroundColor: AppColors.green.withValues(alpha: 0.2),
              width: 80,
              height: 33,
              onPressed: () async {
                final postId = data.post_id ?? 0;
                final userId = data.user_id ?? 0;
                final result = await AppDialog.showCommonDialog(
                  context: context,
                  title: StringConstant.unfavorite,
                  content:
                      "Removing ${data.first_name ?? ""} ${data.last_name ?? ""} from your favorites list will no longer highlight their profile. Are you sure you want to proceed?",
                  successLabel: StringConstant.unfavorite,
                );
                if (result ?? false) {
                  context.read<PreviousShiftBloc>().add(
                        PreviousShiftEvent.addUnFavorite(
                          postId: postId,
                          userId: userId,
                          context: context,
                        ),
                      );
                }
              },
              label: (data.isFavourite ?? false)
                  ? StringConstant.unfavorite
                  : StringConstant.favorite,
              textStyle: TextStyle(fontSize: 10, color: AppColors.green),
              icon: SvgPicture.asset(SvgImageConstant.heartChecked,
                  height: 11, width: 11),
            ),
          ),
        ),
      ),
    );
  }
}
