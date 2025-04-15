// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_previous_shift/employer_previous_shift_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/helper/location_helper.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "PreviousShiftAllView")
class PreviousShiftAllView extends StatelessWidget {
  const PreviousShiftAllView({
    super.key,
    this.completedShift = false,
  });

  final bool completedShift;

  @override
  Widget build(BuildContext context) {
    Widget widget;
    final content = BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            PaginatedListView(
              onRefresh: () {
                context.read<PreviousShiftBloc>().add(
                      PreviousShiftEvent.fetchAllPreviousPost(
                          refresh: true, sortBy: 1),
                    );
              },
              onLoading: () {
                context.read<PreviousShiftBloc>().add(
                      PreviousShiftEvent.fetchAllPreviousPost(
                          refresh: false, sortBy: 1),
                    );
              },
              refreshController: context.read<PreviousShiftBloc>().allPost,
              isNoDataFound: state.allDataListNoDataFound,
              child: state.allDataListLoading
                  ? CenterLoadingIndicator()
                  : state.allDataListIsErrorApi
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(getSize(16)),
                          child: Column(
                            children: [
                              BlocSelector<PreviousShiftBloc,
                                  PreviousShiftState, RatingDropdownModel>(
                                selector: (state) => state.selectedRating,
                                builder: (context, selectedRating) {
                                  return _RatingsDropdown(
                                    onChanged: (RatingDropdownModel value) {
                                      context.read<PreviousShiftBloc>().add(
                                          PreviousShiftEvent.ratingChangeEvent(
                                              rating: value));
                                    },
                                    value: selectedRating,
                                  );
                                },
                              ),
                              SizedBox(height: getSize(16)),
                              _PreviousShiftAllListView(
                                  allPostList: state.employerPreviousList)
                            ],
                          ),
                        ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
    );

    if (completedShift) {
      widget = BlocProvider(
        create: (context) => getIt<PreviousShiftBloc>()
          ..add(
            PreviousShiftEvent.fetchAllPreviousPost(refresh: true, sortBy: 1),
          ),
        child: Scaffold(
          appBar: CommonAppBar(
            onBackPressed: () => Navigator.pop(context),
            title: StringConstant.completedShifts,
          ),
          body: content,
        ),
      );
    } else {
      widget = content;
    }

    return widget;
  }
}

class _PreviousShiftAllListView extends StatelessWidget {
  const _PreviousShiftAllListView({
    required this.allPostList,
  });

  final List<EmployerPreviousShiftDto> allPostList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allPostList.length,
      itemBuilder: (context, index) => _PreviousShiftListTile(
        data: allPostList[index],
      ),
      separatorBuilder: (context, index) => SizedBox(height: getSize(18)),
    );
  }
}

class _RatingsDropdown extends StatelessWidget {
  const _RatingsDropdown({
    required this.onChanged,
    required this.value,
  });

  final ValueSetter<RatingDropdownModel> onChanged;
  final RatingDropdownModel value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(
            text: StringConstant.sortBy,
            fontSize: 10,
            fontWeight: FontWeight.w500),
        SizedBox(height: getSize(7)),
        CustomDropdownField<RatingDropdownModel>(
          items: [
            RatingDropdownModel(
              value: 1,
              title: "Rating (Ascending to Descending)",
              icon: SvgImageConstant.starFilled,
            ),
            RatingDropdownModel(
                value: 2,
                title: "Location (Descending to Ascending) ",
                icon: SvgImageConstant.locationIcon,
                iconColor: Colors.black),
          ]
              .map(
                (e) => DropdownMenuItem<RatingDropdownModel>(
                  value: e,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        e.icon,
                        height: 18,
                        width: 18,
                        colorFilter: e.iconColor != null
                            ? ColorFilter.mode(e.iconColor!, BlendMode.srcIn)
                            : null,
                      ),
                      SizedBox(
                        width: getSize(10),
                      ),
                      BaseText(
                        text: e.title,
                        fontWeight: FontWeight.w500,
                        fontSize: getSize(13),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: (value) => onChanged(value!),
          value: value,
        ),
      ],
    );
  }
}

class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          SvgImageConstant.starFilled,
        ),
        SizedBox(width: getSize(8)),
        BaseText(
            text: rating.toString(), fontSize: 12, fontWeight: FontWeight.w600),
      ],
    );
  }
}

class _PreviousShiftListTile extends StatelessWidget {
  const _PreviousShiftListTile({required this.data});

  final EmployerPreviousShiftDto data;

  @override
  Widget build(BuildContext context) {
    return BaseTileDecoration(
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
                  _buildUserInfo(context),
                  Divider(height: 8),
                  Gap(getSize(6.0)),
                  _buildLocationInfo(context),
                ],
              ),
            ),
          ),
          Gap(getSize(10)),
          CommonMaterialButton(
            backgroundColor: AppColors.scaffoldColor,
            onPressed: () {
              final postId = data.post_id;
              final userId = data.user_id;
              if (postId == null && userId == null) return;
              context.router.push(
                PageRouteInfo(ViewApplicantProfile.name,
                    args: ViewApplicantProfileArgs(
                        id: userId ?? -1, postId: postId ?? -1)),
              );
            },
            label: StringConstant.viewProfile,
            radius: 7.0,
            textStyle:
                TextStyle(fontSize: getSize(12.0), fontWeight: FontWeight.w600),
          ),
          Gap(getSize(10)),
          _buildAdditionalInfo(context),
          Gap(getSize(10)),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return UserInfoTile(
      url: data.profile ?? "",
      title: "${data.first_name ?? ""} ${data.last_name ?? ""}",
      subTitle: "${data.role_lists_name}",
      trailing: RatingStar(
          rating:
              double.parse(data.all_over_rating?.toStringAsFixed(1) ?? "0.0")),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonInfoTile(
            key: ValueKey("last_worked_date"),
            leading: SvgPicture.asset(
              SvgImageConstant.calendar,
              height: 15,
              width: 15,
              colorFilter: ColorFilter.mode(
                  AppColors.black.withOpacity(0.6), BlendMode.srcIn),
            ),
            title: BaseText(
              text: StringConstant.lastWorkedDate,
              fontSize: getSize(10),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w400,
            ),
            subtitle: Text.rich(
              style: TextStyle(fontSize: getFontSize(12)),
              TextSpan(
                text:
                    "${convertUnixTimeToLocalString(data.last_worked_end_time ?? 0)}, ",
                style: TextStyle(fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text:
                          "${DateTime.fromMillisecondsSinceEpoch((data.last_worked_end_time ?? 0) * 1000).year}",
                      style: TextStyle(
                          color: AppColors.black.withValues(alpha: 0.5))),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: CommonInfoTile(
            key: ValueKey("time"),
            leading: SvgPicture.asset(
              SvgImageConstant.clock,
              height: 15,
              width: 15,
              colorFilter: ColorFilter.mode(
                  AppColors.black.withOpacity(0.6), BlendMode.srcIn),
            ),
            title: BaseText(
              text: StringConstant.time,
              fontSize: getSize(10),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w400,
            ),
            subtitle: BaseText(
              text:
                  '${formatUnixTimestamp(data.last_worked_start_time ?? 0)} to ${formatUnixTimestamp(data.last_worked_end_time ?? 0)}',
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final latitude = data.latitude;
        final longitude = data.longitude;
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
          text: data.location ?? "",
          fontWeight: FontWeight.w500,
          fontSize: 11,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: BaseText(
          text: data.distance ?? "",
          fontWeight: FontWeight.w500,
          textColor: AppColors.green,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final isBlock = (data.isBlock ?? false);

    return Material(
      borderRadius: BorderRadius.circular(getSize(10)),
      color: AppColors.scaffoldColor,
      child: Padding(
        padding: EdgeInsets.all(getSize(16.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    backgroundColor: isBlock
                        ? AppColors.white.withValues(alpha: 0.5)
                        : AppColors.white,
                    onPressed: !isBlock
                        ? () async {
                            final postId = data.post_id ?? 0;
                            final userId = data.user_id ?? 0;
                            if (data.isFavourite ?? false) {
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
                            } else {
                              context.read<PreviousShiftBloc>().add(
                                    PreviousShiftEvent.addFavorite(
                                      postId: postId,
                                      userId: userId,
                                      context: context,
                                    ),
                                  );
                            }
                          }
                        : null,
                    icon: (data.isFavourite ?? false)
                        ? SvgImageConstant.heartChecked
                        : SvgImageConstant.heart1,
                    label:
                        "${(data.isFavourite ?? false) ? StringConstant.added : StringConstant.add} to favorite",
                    textColor:
                        isBlock ? AppColors.black.withValues(alpha: 0.5) : null,
                  ),
                ),
                Gap(getSize(8.0)),
                Expanded(
                  child: _ActionButton(
                    backgroundColor: isBlock
                        ? AppColors.white.withValues(alpha: 0.5)
                        : AppColors.white,
                    onPressed: !isBlock
                        ? () => _onAddRating(
                              contractorName:
                                  "${data.first_name ?? ""} ${data.last_name ?? ""}",
                              context,
                              defaultRating: data.rating,
                              userId: data.user_id ?? -1,
                              postId: data.post_id ?? -1,
                            )
                        : null,
                    icon: (data.isRating == true &&
                            data.rating != null &&
                            data.rating != 0)
                        ? SvgImageConstant.starFilled
                        : SvgImageConstant.starOutlined,
                    iconColor: (data.isRating == true &&
                            data.rating != null &&
                            data.rating != 0)
                        ? AppColors.primaryColor
                        : null,
                    textColor:
                        isBlock ? AppColors.black.withValues(alpha: 0.5) : null,
                    label: (data.isRating == true &&
                            data.rating != null &&
                            data.rating != 0)
                        ? "${data.rating!.toDouble()}"
                        : StringConstant.leaveARating,
                  ),
                ),
              ],
            ),
            Gap(getSize(12.0)),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    backgroundColor: isBlock
                        ? AppColors.white.withValues(alpha: 0.5)
                        : AppColors.white,
                    onPressed: !isBlock
                        ? () {
                            _onAddRemark(
                              context,
                              postId: data.post_id ?? 0,
                              userId: data.user_id ?? 0,
                              existingRemark:
                                  (data.isRemark == true) ? data.remarks : null,
                            );
                          }
                        : null,
                    label: data.isRemark == true
                        ? StringConstant.remarkAdded
                        : StringConstant.remark,
                    icon: data.isRemark == true
                        ? SvgImageConstant.remarkAdded
                        : SvgImageConstant.medalStar,
                    textColor:
                        isBlock ? AppColors.black.withValues(alpha: 0.5) : null,
                  ),
                ),
                Gap(getSize(8.0)),
                Expanded(
                  child: _ActionButton(
                    onPressed: () {
                      if (data.isBlock ?? false) {
                        _onUnblock(
                          context,
                          postId: data.post_id ?? 0,
                          userId: data.user_id ?? 0,
                          contractorName:
                              "${data.first_name ?? ""} ${data.last_name ?? ""}",
                        );
                      } else {
                        _onBlock(
                          context,
                          postId: data.post_id ?? 0,
                          userId: data.user_id ?? 0,
                          contractorName:
                              "${data.first_name ?? ""} ${data.last_name ?? ""}",
                        );
                      }
                    },
                    label:
                        isBlock ? StringConstant.blocked : StringConstant.block,
                    icon: isBlock
                        ? SvgImageConstant.blockedFilled
                        : SvgImageConstant.block,
                    backgroundColor: isBlock
                        ? AppColors.redAccent.withValues(alpha: 0.15)
                        : AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAddRemark(
    BuildContext context, {
    required int postId,
    required int userId,
    String? existingRemark,
  }) async {
    final result = await showDialog<String?>(
      context: context,
      builder: (context) => AddRemarkModal(
        initialValue: existingRemark,
      ),
    );
    if (result != null) {
      context.read<PreviousShiftBloc>().add(
            PreviousShiftEvent.addRemark(
                userId: userId,
                postId: postId,
                context: context,
                remark: result),
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
      infoMessage:
          "Blocking $contractorName will prevent them from seeing any future postings. Are you sure you want to proceed?",
      onCancelClick: () => context.router.maybePop(),
      onDeleteClick: () {
        context.router.maybePop();
        context.read<PreviousShiftBloc>().add(
              PreviousShiftEvent.blockUnblockPost(
                  userId: userId, postId: postId, context: context),
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
        context.read<PreviousShiftBloc>().add(
              PreviousShiftEvent.leaveRating(
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
      context.read<PreviousShiftBloc>().add(
            PreviousShiftEvent.blockUnblockPost(
                userId: userId, postId: postId, context: context),
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
      height: getSize(31),
      backgroundColor: backgroundColor ?? AppColors.white,
      radius: getSize(7.0),
      onPressed: onPressed,
      label: label,
      icon: SvgPicture.asset(
        icon,
        height: getSize(14),
        width: getSize(14),
        color: iconColor,
      ),
      textStyle: TextStyle(
          fontSize: getFontSize(10),
          fontWeight: FontWeight.w500,
          color: textColor),
    );
  }
}

String convertUnixTimeToLocalString(int timeStamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  String formattedDate = DateFormat('d MMM').format(date);
  return formattedDate;
}

String formatUnixTimestamp(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String formattedTime = DateFormat('hh:mm a').format(date);

  return formattedTime;
}

class RatingDropdownModel {
  final int value;
  final String title;
  final String icon;
  final Color? iconColor;

  const RatingDropdownModel({
    required this.value,
    required this.title,
    required this.icon,
    this.iconColor,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingDropdownModel &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          title == other.title &&
          icon == other.icon &&
          iconColor == other.iconColor;

  @override
  int get hashCode =>
      value.hashCode ^ title.hashCode ^ icon.hashCode ^ iconColor.hashCode;
}
