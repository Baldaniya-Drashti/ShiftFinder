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
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/drop_down_field.dart';
import 'package:shift/presentation/core/widgets/tile.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: "EmployerCompletedShiftView")
class EmployerCompletedShiftView extends StatelessWidget {
  const EmployerCompletedShiftView({super.key});

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
                      : Center(
                          child: BaseText(
                            textColor: AppColors.black.withOpacity(0.65),
                            text: 'No result found.',
                            textAlign: TextAlign.center,
                            lineHeight: 1.2,
                          ),
                        ),
              /* SingleChildScrollView(
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
                              _CompletedShiftListView( allPostList: state.employerPreviousList)
                            ],
                          ),
                        ), */
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
    );

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

    return widget;
  }
}

class _CompletedShiftListView extends StatelessWidget {
  const _CompletedShiftListView({
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
        BaseText(text: "Sort by", fontSize: 10, fontWeight: FontWeight.w500),
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
            label: "View Profile",
            radius: 7.0,
            textStyle:
                TextStyle(fontSize: getSize(12.0), fontWeight: FontWeight.w600),
          ),
          Gap(getSize(10)),
          dateAndTime(context, data),
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
      trailing: RatingStar(rating: data.rating?.toDouble() ?? 0.0),
    );
  }

  /* Widget _buildAdditionalInfo(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
                  text: "Last Worked Date",
                  fontSize: getSize(10),
                  textColor: AppColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
                subtitle: Text.rich(
                  style: TextStyle(fontSize: 12),
                  TextSpan(
                    text: '',
                    // "${convertUnixTimeToLocalString(data.last_worked_date ?? 0)}, ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                          text:
                              "${DateTime.fromMillisecondsSinceEpoch((data.last_worked_date ?? 0) * 1000).year}",
                          style: TextStyle(
                              color: AppColors.black.withOpacity(0.5))),
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
                  text: "Time",
                  fontSize: getSize(10),
                  textColor: AppColors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                ),
                subtitle: BaseText(
                  text: '',
                  // '${formatUnixTimestamp(data.last_worked_start_time ?? 0)} to ${formatUnixTimestamp(data.last_worked_end_time ?? 0)}',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  } */

  Widget _buildLocationInfo(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final latitude = data.latitude;
        final longitude = data.longitude;
        if (latitude != null && longitude != null) {
          context.router.push(
            PageRouteInfo(
              ShowGoogleMap.name,
              args: ShowGoogleMapArgs(
                latitude: latitude,
                longitude: longitude,
              ),
            ),
          );
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
                        ? AppColors.white.withOpacity(0.5)
                        : AppColors.white,
                    onPressed: !isBlock
                        ? () async {
                            final postId = data.post_id ?? 0;
                            final userId = data.user_id ?? 0;
                            if (data.isFavourite ?? false) {
                              final result = await AppDialog.showCommonDialog(
                                context: context,
                                title: "Unfavorite",
                                content:
                                    "Removing ${data.first_name ?? ""} ${data.last_name ?? ""} from your favorites list will no longer highlight their profile. Are you sure you want to proceed?",
                                successLabel: "Unfavorite",
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
                        "${(data.isFavourite ?? false) ? "Added" : "Add"} to favorite",
                    textColor:
                        isBlock ? AppColors.black.withOpacity(0.5) : null,
                  ),
                ),
                Gap(getSize(8.0)),
                Expanded(
                  child: _ActionButton(
                    backgroundColor: isBlock
                        ? AppColors.white.withOpacity(0.5)
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
                        isBlock ? AppColors.black.withOpacity(0.5) : null,
                    label: (data.isRating == true &&
                            data.rating != null &&
                            data.rating != 0)
                        ? "${data.rating!.toDouble()}"
                        : "Leave a Rating",
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
                        ? AppColors.white.withOpacity(0.5)
                        : AppColors.white,
                    onPressed: !isBlock
                        ? () {
                            _onAddRemark(
                              context,
                              postId: data.post_id ?? 0,
                              userId: data.user_id ?? 0,
                            );
                          }
                        : null,
                    label: data.isRemark == true ? "Remark Added" : "Remark",
                    icon: data.isRemark == true
                        ? SvgImageConstant.remarkAdded
                        : SvgImageConstant.medalStar,
                    textColor:
                        isBlock ? AppColors.black.withOpacity(0.5) : null,
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
                        ? AppColors.redAccent.withOpacity(0.15)
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

  Widget dateAndTime(BuildContext context, EmployerPreviousShiftDto shift) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayDateBreak(
                context,
                boldValue: convertTimeStampToDate(shift.last_worked_date ?? -1),
                timidValue: convertTimeStampToDate(shift.last_worked_date ?? -1,
                    isYear: true),
                title: StringConstant.shiftDate,
                svgPrefixIcon: SvgImageConstant.calendar,
              ),
              displayDateBreak(
                context,
                boldValue: "\$${shift.total_amount ?? 0.0}",
                timidValue: "",
                title: StringConstant.totalAmount,
                svgPrefixIcon: SvgImageConstant.dollorRound,
              ),
            ],
          ),
        ),
        Flexible(
          flex: 13,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              displayTime(
                title: StringConstant.time,
                startDate: (shift.last_worked_start_time != null)
                    ? DateFormat('hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            (shift.last_worked_start_time ?? 0) * 1000))
                    : "",
                endDate: (shift.last_worked_end_time != null)
                    ? DateFormat('hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            (shift.last_worked_end_time ?? 0) * 1000))
                    : "",
                svgPrefixIcon: SvgImageConstant.clock,
              ),
              displayDateBreak(
                context,
                boldValue: "",
                timidValue: "",
                title: "",
                svgPrefixIcon: "",
                showBtn: true,
                onBtnPressed: () {
                  context.router.push(
                    PageRouteInfo(
                      ViewHomeShiftDetails.name,
                      args: ViewHomeShiftDetailsArgs(
                        postId: shift.post_id ?? -1,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget displayTime({
    required String title,
    required String startDate,
    required String endDate,
    required String svgPrefixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            svgPrefixIcon,
            color: AppColors.black.withOpacity(0.7),
            height: getSize(20),
            width: getSize(16),
          ),
          SizedBox(width: getSize(10)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: StringConstant.shiftTime,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textColor: AppColors.black.withOpacity(0.7),
              ),
              Row(
                children: [
                  BaseText(
                    text: startDate,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: ' to ',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.black,
                  ),
                  BaseText(
                    text: endDate,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget displayDateBreak(BuildContext context,
      {required String title,
      required String boldValue,
      required String timidValue,
      required String svgPrefixIcon,
      bool showBtn = false,
      void Function()? onBtnPressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(10)),
      child: (showBtn)
          ? CommonButton(
              onPressed: onBtnPressed ?? () {},
              // width: 160,
              height: 34,
              borderRadius: 5,
              buttonFontSize: 12,
              buttonFontWeight: FontWeight.w600,
              buttonText: StringConstant.viewDetails,
              buttonTextColor: AppColors.black,
              backgroundColor: AppColors.scaffoldColor,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  svgPrefixIcon,
                  color: AppColors.black.withOpacity(0.7),
                  height: getSize(20),
                  width: getSize(16),
                ),
                SizedBox(width: getSize(10)),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: title,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.black.withOpacity(0.7),
                      ),
                      highLightText(
                          boldValue: boldValue, timidValue: timidValue),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget highLightText(
      {required String boldValue,
      required String timidValue,
      String? thirdValue}) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: boldValue,
          style: TextStyle(
            fontSize: getFontSize(13),
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          children: [
            TextSpan(
              text: timidValue,
              style: TextStyle(
                fontSize: getFontSize(13),
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.5),
              ),
            ),
            TextSpan(
              text: thirdValue ?? "",
            ),
          ],
        ));
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
      deleteBtnText: "Block",
      deleteColor: AppColors.redAccent,
      title: "Block",
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
      title: "Unblock",
      content:
          "Unblocking $contractorName will allow them to view and apply for your future postings. Are you sure you want to proceed?",
      successLabel: "Unblock",
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

String convertTimeStampToDate(int timestamp,
    {bool isYear = false, bool isTime = false}) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  if (isTime) {
    return DateFormat('hh:mm a').format(dateTime);
  } else {
    if (isYear) {
      return DateFormat('yyyy').format(dateTime);
    } else {
      return DateFormat('d MMM, ').format(dateTime);
    }
  }
}

// String formatUnixTimestamp(int timestamp) {
//   DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//   String formattedTime = DateFormat('hh:mm a').format(date);

//   return formattedTime;
// }
