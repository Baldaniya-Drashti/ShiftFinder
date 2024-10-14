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
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class PreviousShiftRemarkedView extends StatelessWidget {
  const PreviousShiftRemarkedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviousShiftBloc, PreviousShiftState>(
      builder: (context, state) {
        return Stack(
          children: [
            PaginatedListView(
              onRefresh: () => PreviousShiftEvent.fetchFavoriteList(refresh: true),
              onLoading: () => PreviousShiftEvent.fetchFavoriteList(refresh: false),
              refreshController: context.read<PreviousShiftBloc>().remarked,
              isNoDataFound: state.remarkedListNoDataFound,
              child: state.remarkedListLoading
                  ? CenterLoadingIndicator()
                  : state.remarkedListIsErrorApi
                      ? Center(
                          child: BaseText(text: StringConstant.somethindWentWrong),
                        )
                      : ListView.separated(
                          padding: EdgeInsets.all(getSize(20)),
                          itemBuilder: (context, index) => _PreviousShiftRemarkedTile(),
                          separatorBuilder: (context, index) => Gap(getSize(16)),
                          itemCount: state.favoritesList.length,
                        ),
            ),
            if (state.postDataLoading) CenterLoadingIndicator()
          ],
        );
      },
    );
  }
}

class _PreviousShiftRemarkedTile extends StatelessWidget {
  const _PreviousShiftRemarkedTile();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(16))),
      child: Padding(
        padding: EdgeInsets.all(getSize(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(16))),
              tileColor: AppColors.scaffoldColor,
              leading: CircleAvatar(
                radius: getSize(25),
                backgroundColor: AppColors.green,
                child: CircleAvatar(
                  radius: getSize(24),
                  backgroundImage: NetworkImage(
                    'https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg',
                  ),
                ),
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BaseText(
                            text: "Roboto Flex",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          SizedBox(
                            width: getSize(10),
                          ),
                          SvgPicture.asset(
                            SvgImageConstant.rightArrow,
                            height: 10,
                            width: 10,
                            color: AppColors.black.withOpacity(0.5),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        SvgImageConstant.emailFilled,
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: getSize(4),
                      ),
                      Expanded(
                        child: BaseText(
                          text: "debra.holt@example.com",
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          textColor: AppColors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              trailing: Material(
                color: AppColors.red.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(7))),
                child: GestureDetector(
                  onTap: () {
                    AppDialog.showDelete(
                        title: "Remove",
                        context,
                        infoMessage: "Are you sure you want to remove this contractor from remarked list?", onCancelClick: () {
                      Navigator.pop(context);
                    }, onDeleteClick: () {}, deleteBtnText: "Remove");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(getSize(9)),
                    child: SvgPicture.asset(
                      SvgImageConstant.delete,
                      color: AppColors.red,
                      height: 13,
                      width: 13,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getSize(12),
            ),
            BaseText(
              text: "Comment",
              fontSize: 12,
            ),
            SizedBox(
              height: getSize(12),
            ),
            Material(
              color: AppColors.scaffoldColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.all(getSize(15)),
                child: BaseText(
                  maxLines: 15,
                  fontSize: getSize(12),
                  fontWeight: FontWeight.w500,
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
