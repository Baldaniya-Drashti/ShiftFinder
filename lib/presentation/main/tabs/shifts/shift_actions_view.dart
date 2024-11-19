import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/shift_action/shift_action_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ShiftActionsView')
class ShiftActionsView extends StatelessWidget {
  const ShiftActionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShiftActionBloc>(),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () => Navigator.pop(context),
          title: "Shift Approved",
        ),
        body: BlocBuilder<ShiftActionBloc, ShiftActionState>(
          builder: (context, state) {
            final data = state.employerPreviousShift;
            if (state.loading) return CenterLoadingIndicator();

            if (!state.loading && state.employerPreviousShift == null) {
              return Center(
                child: SizedBox(
                  width: getSize(280),
                  child: BaseText(
                    textColor: AppColors.black.withOpacity(0.65),
                    text: 'No result found.',
                    textAlign: TextAlign.center,
                    lineHeight: 1.2,
                  ),
                ),
              );
            }

            return ListView(
              padding: EdgeInsets.all(getSize(12)),
              children: [
                BaseTileDecoration(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(getSize(10)),
                        color: AppColors.scaffoldColor,
                        child: Padding(
                          padding: EdgeInsets.all(getSize(18)).copyWith(top: getSize(8)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildUserInfo(context, data: data),
                              Divider(height: 8),
                              Gap(getSize(6.0)),
                              _buildLocationInfo(context, data: data),
                            ],
                          ),
                        ),
                      ),
                      Gap(16),
                      _ActionButton(
                        icon: SvgImageConstant.heart1,
                        label: "Add to favorite",
                        onPressed: () async {
                          final postId = data?.post_id ?? 0;
                          final userId = data?.user_id ?? 0;
                          if (data?.isFavourite ?? false) {
                            final result = await AppDialog.showCommonDialog(
                              context: context,
                              title: "Unfavorite",
                              content:
                                  "Removing ${data?.first_name ?? ""} ${data?.last_name ?? ""} from your favorites list will no longer highlight their profile. Are you sure you want to proceed?",
                              successLabel: "Unfavorite",
                            );
                            if (result ?? false) {
                              context.read<ShiftActionBloc>().add(
                                    ShiftActionEvent.addUnFavorite(
                                      postId: postId,
                                      userId: userId,
                                      context: context,
                                    ),
                                  );
                            }
                          } else {
                            context.read<ShiftActionBloc>().add(
                                  ShiftActionEvent.addFavorite(
                                    postId: postId,
                                    userId: userId,
                                    context: context,
                                  ),
                                );
                          }
                        },
                      ),
                      Gap(16),
                      _ActionButton(
                        icon: SvgImageConstant.starOutlined,
                        label: "Leave a Rating",
                        onPressed: () => _onAddRating(
                          contractorName: "${data?.first_name ?? ""} ${data?.last_name ?? ""}",
                          context,
                          defaultRating: data?.rating,
                          userId: data?.user_id ?? -1,
                          postId: data?.post_id ?? -1,
                        ),
                      ),
                      Gap(16),
                      _ActionButton(
                        label: "Remark",
                        icon: SvgImageConstant.medalStar,
                        onPressed: () => _onAddRemark(
                          context,
                          postId: data?.post_id ?? 0,
                          userId: data?.user_id ?? 0,
                        ),
                      ),
                      Gap(16),
                      _ActionButton(
                        label: "Block",
                        icon: SvgImageConstant.block,
                        onPressed: () {
                          if (data?.isBlock ?? false) {
                            _onUnblock(
                              context,
                              postId: data?.post_id ?? 0,
                              userId: data?.user_id ?? 0,
                              contractorName: "${data?.first_name ?? ""} ${data?.last_name ?? ""}",
                            );
                          } else {
                            _onBlock(
                              context,
                              postId: data?.post_id ?? 0,
                              userId: data?.user_id ?? 0,
                              contractorName: "${data?.first_name ?? ""} ${data?.last_name ?? ""}",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Gap(15),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: BaseText(
                    textAlign: TextAlign.center,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    text:
                        "Once a shift is approved, you can rate, add to favorites, remark or block the user. These actions can also be completed later in the profile section.",
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _onUnblock(
    BuildContext context, {
    required int postId,
    required int userId,
    required String contractorName,
  }) async {
    final result = await AppDialog.showCommonDialog(
      context: context,
      title: "Unblock",
      content: "Unblocking $contractorName will allow them to view and apply for your future postings. Are you sure you want to proceed?",
      successLabel: "Unblock",
    );

    if (result ?? false) {
      context.read<ShiftActionBloc>().add(
            ShiftActionEvent.blockUnblockPost(userId: userId, postId: postId, context: context),
          );
    }
  }

  void _onBlock(
    BuildContext context, {
    required int postId,
    required int userId,
    required String contractorName,
  }) {
    AppDialog.showDelete(
      deleteBtnText: "Block",
      deleteColor: AppColors.redAccent,
      title: "Block",
      context,
      otherContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(10),
          BaseText(
            text: "This will not impact any currently accepted shifts",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            textColor: AppColors.black.withOpacity(0.7),
          ),
        ],
      ),
      infoMessage: "Blocking [contractor name] will prevent them from seeing any future postings. Are you sure you want to proceed?",
      onCancelClick: () => Navigator.pop(context),
      onDeleteClick: () {},
    );
  }

  void _onAddRating(
    BuildContext context, {
    int? defaultRating,
    required int userId,
    required int postId,
    required String contractorName,
  }) {
    AppDialog.showLeaveRatingModal(
      context,
      defaultRating: defaultRating,
      onSubmit: (int value) {
        context.read<ShiftActionBloc>().add(
              ShiftActionEvent.leaveRating(
                userId: userId,
                postId: postId,
                rating: value,
                context: context,
              ),
            );
      },
      contractorName: contractorName,
    );
  }

  Widget _buildUserInfo(
    BuildContext context, {
    required EmployerPreviousShiftDto? data,
  }) {
    return UserInfoTile(
      url: data?.profile ?? "",
      title: "${data?.first_name ?? ""} ${data?.last_name ?? ""}",
      subTitle: data?.role_lists_name ?? "",
      trailing: RatingStar(rating: (data?.rating ?? 0).toDouble()),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required EmployerPreviousShiftDto? data,
  }) {
    return CommonInfoTile(
      key: ValueKey("location_info"),
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: "",
        fontWeight: FontWeight.w500,
        fontSize: 11,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: BaseText(
        text: "10.2 Km Away",
        fontWeight: FontWeight.w500,
        textColor: AppColors.green,
        fontSize: 10,
      ),
    );
  }

  Future<void> _onAddRemark(
    BuildContext context, {
    required int postId,
    required int userId,
  }) async {
    final result = await showDialog<String?>(
      context: context,
      builder: (context) => AddRemarkModal(),
    );
    if (result != null) {
      context.read<ShiftActionBloc>().add(
            ShiftActionEvent.addRemark(userId: userId, postId: postId, context: context, remark: result),
          );
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onPressed,
    required this.label,
  });

  final String icon;
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return CommonMaterialButton.icon(
      height: 42,
      backgroundColor: AppColors.scaffoldColor,
      radius: getSize(7.0),
      onPressed: onPressed,
      label: label,
      icon: SvgPicture.asset(icon, height: 14, width: 14),
      textStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
    );
  }
}
