import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/profile/previous_shift/previous_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class PreviousShiftAllView extends StatelessWidget {
  const PreviousShiftAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<PreviousShiftBloc, PreviousShiftState, double>(
          selector: (state) => state.selectedRating,
          builder: (context, selectedRating) {
            return _RatingsDropdown(
              onChanged: (double value) {
                context.read<PreviousShiftBloc>().add(PreviousShiftEvent.ratingChangeEvent(rating: value));
              },
              value: selectedRating,
            );
          },
        ),
        SizedBox(height: getSize(22)),
        _PreviousShiftAllListView()
      ],
    );
  }
}

class _PreviousShiftAllListView extends StatelessWidget {
  const _PreviousShiftAllListView();

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
    //   builder: (context, state) {
    //     return Expanded(
    //       child: PaginatedListView(
    //         onRefresh: () => PreviousShiftEvent.fetchAllPreviousPost(refresh: true),
    //         onLoading: () => PreviousShiftEvent.fetchAllPreviousPost(refresh: false),
    //         refreshController: context.read<PreviousShiftBloc>().allPost,
    //         isNoDataFound: state.allListNoDataFound,
    //         child: state.allListLoading
    //             ? CenterLoadingIndicator(isOnlyLoader: true)
    //             : state.allListIsErrorApi
    //                 ? BaseText(text: StringConstant.somethindWentWrong)
    //                 : ListView.separated(
    //                     physics: NeverScrollableScrollPhysics(),
    //                     shrinkWrap: true,
    //                     itemCount: 5,
    //                     itemBuilder: (context, index) => _PreviousShiftListTile(),
    //                     separatorBuilder: (context, index) => SizedBox(height: getSize(18)),
    //                   ),
    //       ),
    //     );
    //   },
    // );

    // return ListView.separated(
    //   physics: NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   itemCount: 5,
    //   itemBuilder: (context, index) => _PreviousShiftListTile(),
    //   separatorBuilder: (context, index) => SizedBox(height: getSize(18)),
    // );

    return Expanded(
      child: PaginatedListView(
        onRefresh: () {},
        onLoading: () {},
        refreshController: context.read<PreviousShiftBloc>().allPost,
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => _PreviousShiftListTile(),
          separatorBuilder: (context, index) => SizedBox(height: getSize(18)),
        ),
      ),
    );
  }
}

class _RatingsDropdown extends StatelessWidget {
  const _RatingsDropdown({
    required this.onChanged,
    required this.value,
  });

  final ValueSetter<double> onChanged;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(text: "Sort by", fontSize: 10, fontWeight: FontWeight.w500),
        SizedBox(height: getSize(7)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getSize(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.2),
                blurRadius: 30,
              )
            ],
          ),
          child: DropdownButtonFormField(
            isDense: true,
            icon: SvgPicture.asset(
              color: AppColors.black,
              SvgImageConstant.downArrow,
              height: 8,
              width: 6,
            ),
            iconSize: 8,
            value: value,
            decoration: InputDecoration(
              isDense: true,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: getSize(12),
                horizontal: getSize(20),
              ),
            ),
            dropdownColor: AppColors.white,
            elevation: 5,
            items: [5.0, 4.0, 3.0, 2.0, 1.0]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(SvgImageConstant.star),
                        SizedBox(
                          width: getSize(8),
                        ),
                        BaseText(
                          text: e.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: getSize(15),
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              onChanged(value!);
            },
          ),
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
        SvgPicture.asset(SvgImageConstant.star),
        SizedBox(width: getSize(8)),
        BaseText(text: rating.toString(), fontSize: 12, fontWeight: FontWeight.w600),
      ],
    );
  }
}

class _PreviousShiftListTile extends StatelessWidget {
  const _PreviousShiftListTile();

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
              context.router.push(
                PageRouteInfo(ViewApplicantProfile.name),
              );
            },
            label: "View Profile",
            radius: 7.0,
            textStyle: TextStyle(fontSize: getSize(12.0), fontWeight: FontWeight.w600),
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
      url: 'https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg',
      title: "Dhaval Pithadiya",
      subTitle: "Flutter Dev",
      trailing: RatingStar(rating: 5.0),
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
              colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.6), BlendMode.srcIn),
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
                text: "12 May, ",
                style: TextStyle(fontWeight: FontWeight.w500),
                children: [
                  TextSpan(text: "2024", style: TextStyle(color: AppColors.black.withOpacity(0.5))),
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
              colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.6), BlendMode.srcIn),
            ),
            title: BaseText(
              text: "Time",
              fontSize: getSize(10),
              textColor: AppColors.black.withOpacity(0.6),
              fontWeight: FontWeight.w400,
            ),
            subtitle: BaseText(
              text: '09:15 AM to 07:30 PM',
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationInfo(BuildContext context) {
    return CommonInfoTile(
      key: ValueKey("location_info"),
      leading: SvgPicture.asset(
        SvgImageConstant.location,
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 24,
        width: 24,
      ),
      title: BaseText(
        text: "4517 Washington Manchester, Kentucky 39495",
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

  Widget _buildActionButton(BuildContext context) {
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
                    onPressed: () {},
                    icon: SvgImageConstant.heart1,
                    label: "Add to favorite",
                  ),
                ),
                Gap(getSize(8.0)),
                Expanded(
                  child: _ActionButton(
                    onPressed: () => _onAddRating(context),
                    icon: SvgImageConstant.starOutlined,
                    label: "Leave a Rating",
                  ),
                ),
              ],
            ),
            Gap(getSize(12.0)),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    onPressed: () {},
                    label: "Remark",
                    icon: SvgImageConstant.medalStar,
                  ),
                ),
                Gap(getSize(8.0)),
                Expanded(
                  child: _ActionButton(
                    onPressed: () => _onBlock(context),
                    label: "Block",
                    icon: SvgImageConstant.block,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onBlock(BuildContext context) {
    AppDialog.showDelete(
      deleteBtnText: "Block",
      deleteColor: AppColors.redAccent,
      title: "Block",
      context,
      infoMessage: "Blocking [contractor name] will prevent them from seeing any future postings. Are you sure you want to proceed?",
      onCancelClick: () => Navigator.pop(context),
      onDeleteClick: () {},
    );
  }

  void _onAddRating(BuildContext context) {
    AppDialog.showLeaveRatingModal(context);
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
      height: 28,
      backgroundColor: AppColors.white,
      radius: getSize(7.0),
      onPressed: onPressed,
      label: label,
      icon: SvgPicture.asset(icon, height: 14, width: 14),
      textStyle: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
    );
  }
}
