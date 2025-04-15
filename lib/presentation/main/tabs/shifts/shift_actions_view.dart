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
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

import '../../../../domain/core/string_constant.dart';

@RoutePage(name: 'ShiftActionsView')
class ShiftActionsView extends StatelessWidget {
  const ShiftActionsView(
      {super.key, required this.postId, required this.userId});

  final int postId;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) => getIt<ShiftActionBloc>()
          ..add(ShiftActionEvent.getEmployerData(
              context: context, postId: postId, userId: userId)),
        child: Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () {
              Navigator.pop(context, true);
            },
            title: StringConstant.shiftApproved,
          ),
          body: BlocBuilder<ShiftActionBloc, ShiftActionState>(
            builder: (context, state) {
              final data = state.employerPreviousShift;
              final isBlock = (data?.isBlock ?? false);

              if (state.loading) return CenterLoadingIndicator();

              if (!state.loading && state.employerPreviousShift == null) {
                return Center(
                  child: SizedBox(
                    width: getSize(280),
                    child: BaseText(
                      textColor: AppColors.black.withValues(alpha: 0.65),
                      text: StringConstant.noResultFound,
                      textAlign: TextAlign.center,
                      lineHeight: 1.2,
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  ListView(
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
                                padding: EdgeInsets.all(getSize(18))
                                    .copyWith(top: getSize(8)),
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
                              backgroundColor: isBlock
                                  ? AppColors.white.withValues(alpha: 0.5)
                                  : AppColors.white,
                              onPressed: !isBlock
                                  ? () async {
                                      final postId = data?.post_id ?? 0;
                                      final userId = data?.user_id ?? 0;
                                      if (data?.isFavourite ?? false) {
                                        final result =
                                            await AppDialog.showCommonDialog(
                                          context: context,
                                          title: StringConstant.unfavorite,
                                          content:
                                              "Removing ${data?.first_name ?? ""} ${data?.last_name ?? ""} from your favorites list will no longer highlight their profile. Are you sure you want to proceed?",
                                          successLabel:
                                              StringConstant.unfavorite,
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
                                    }
                                  : null,
                              icon: (data?.isFavourite ?? false)
                                  ? SvgImageConstant.heartChecked
                                  : SvgImageConstant.heart1,
                              label:
                                  "${(data?.isFavourite ?? false) ? StringConstant.added : StringConstant.add} to favorite",
                              textColor: isBlock
                                  ? AppColors.black.withValues(alpha: 0.5)
                                  : null,
                            ),
                            Gap(getSize(16)),
                            _ActionButton(
                              backgroundColor: isBlock
                                  ? AppColors.white.withValues(alpha: 0.5)
                                  : AppColors.white,
                              onPressed: !isBlock
                                  ? () => _onAddRating(
                                        contractorName:
                                            "${data?.first_name ?? ""} ${data?.last_name ?? ""}",
                                        context,
                                        defaultRating: data?.rating,
                                        userId: data?.user_id ?? -1,
                                        postId: data?.post_id ?? -1,
                                      )
                                  : null,
                              icon: (data?.isRating == true &&
                                      data?.rating != null &&
                                      data?.rating != 0)
                                  ? SvgImageConstant.starFilled
                                  : SvgImageConstant.starOutlined,
                              iconColor: (data?.isRating == true &&
                                      data?.rating != null &&
                                      data?.rating != 0)
                                  ? AppColors.primaryColor
                                  : null,
                              textColor: isBlock
                                  ? AppColors.black.withValues(alpha: 0.5)
                                  : null,
                              label: (data?.isRating == true &&
                                      data?.rating != null &&
                                      data?.rating != 0)
                                  ? "${data?.rating!.toDouble()}"
                                  : StringConstant.leaveARating,
                            ),
                            Gap(getSize(16)),
                            _ActionButton(
                              backgroundColor: isBlock
                                  ? AppColors.white.withValues(alpha: 0.5)
                                  : AppColors.white,
                              onPressed: !isBlock
                                  ? () {
                                      _onAddRemark(
                                        context,
                                        postId: data?.post_id ?? 0,
                                        userId: data?.user_id ?? 0,
                                      );
                                    }
                                  : null,
                              label: data?.isRemark == true
                                  ? StringConstant.remarkAdded
                                  : StringConstant.remark,
                              icon: data?.isRemark == true
                                  ? SvgImageConstant.remarkAdded
                                  : SvgImageConstant.medalStar,
                              textColor: isBlock
                                  ? AppColors.black.withValues(alpha: 0.5)
                                  : null,
                            ),
                            Gap(16),
                            _ActionButton(
                              onPressed: () {
                                if (data?.isBlock ?? false) {
                                  _onUnblock(
                                    context,
                                    postId: data?.post_id ?? 0,
                                    userId: data?.user_id ?? 0,
                                    contractorName:
                                        "${data?.first_name ?? ""} ${data?.last_name ?? ""}",
                                  );
                                } else {
                                  _onBlock(
                                    context,
                                    postId: data?.post_id ?? 0,
                                    userId: data?.user_id ?? 0,
                                    contractorName:
                                        "${data?.first_name ?? ""} ${data?.last_name ?? ""}",
                                  );
                                }
                              },
                              label: isBlock
                                  ? StringConstant.blocked
                                  : StringConstant.block,
                              icon: isBlock
                                  ? SvgImageConstant.blockedFilled
                                  : SvgImageConstant.block,
                              backgroundColor: isBlock
                                  ? AppColors.redAccent.withValues(alpha: 0.15)
                                  : AppColors.white,
                            ),
                          ],
                        ),
                      ),
                      Gap(getSize(15)),
                      Padding(
                        padding: EdgeInsets.all(getSize(24)),
                        child: BaseText(
                          textAlign: TextAlign.center,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          text: StringConstant.shiftApprovedDesc,
                        ),
                      )
                    ],
                  ),
                  if (state.postLoading) CenterLoadingIndicator(),
                ],
              );
            },
          ),
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
      title: StringConstant.unblock,
      content:
          "Unblocking $contractorName will allow them to view and apply for your future postings. Are you sure you want to proceed?",
      successLabel: StringConstant.unblock,
    );

    if (result ?? false) {
      context.read<ShiftActionBloc>().add(
            ShiftActionEvent.blockUnblockPost(
                userId: userId, postId: postId, context: context),
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
      deleteBtnText: StringConstant.block,
      deleteColor: AppColors.redAccent,
      title: StringConstant.block,
      context,
      otherContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(getSize(10)),
          BaseText(
            text: StringConstant.thisWillNotImpactAnyCurrentlyAcceptedShifts,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            textColor: AppColors.black.withValues(alpha: 0.7),
          ),
        ],
      ),
      infoMessage:
          "Blocking $contractorName will prevent them from seeing any future postings. Are you sure you want to proceed?",
      onCancelClick: () => Navigator.pop(context),
      onDeleteClick: () {
        context.router.maybePop().then(
          (value) {
            context.read<ShiftActionBloc>().add(
                  ShiftActionEvent.blockUnblockPost(
                      userId: userId, postId: postId, context: context),
                );
          },
        );
      },
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
      trailing: RatingStar(rating: (data?.all_over_rating ?? 0).toDouble()),
    );
  }

  Widget _buildLocationInfo(
    BuildContext context, {
    required EmployerPreviousShiftDto? data,
  }) {
    return GestureDetector(
      onTap: () {
        final latitude = data?.latitude;
        final longitude = data?.longitude;
        if (latitude != null && longitude != null) {
          LocationHelper.openDirections(context,
              endLat: latitude, endLng: longitude);
        }
      },
      child: CommonInfoTile(
        key: ValueKey("location_info"),
        leading: SvgPicture.asset(
          SvgImageConstant.location,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          height: 24,
          width: 24,
        ),
        title: BaseText(
          text: data?.location ?? "",
          fontWeight: FontWeight.w500,
          fontSize: 11,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: BaseText(
          text: data?.distance ?? "",
          fontWeight: FontWeight.w500,
          textColor: AppColors.green,
          fontSize: 10,
        ),
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
            ShiftActionEvent.addRemark(
                userId: userId,
                postId: postId,
                context: context,
                remark: result),
          );
    }
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
  });

  final String icon;
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;

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
