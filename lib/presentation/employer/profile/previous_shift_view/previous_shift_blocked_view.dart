import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/tile.dart';

class PreviousShiftBlockedView extends StatelessWidget {
  const PreviousShiftBlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(getSize(20)),
      child: Column(
        children: [
          SizedBox(
            height: getSize(12),
          ),
          BaseText(
            text: "You can unblock a contractor from your blocked list by clicking the blocked button again.",
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: getSize(18),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => _PreviousShiftBlockedTile(),
            separatorBuilder: (context, index) => Gap(getSize(16)),
            itemCount: 4,
          )
        ],
      ),
    );
  }
}

class _PreviousShiftBlockedTile extends StatelessWidget {
  const _PreviousShiftBlockedTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseTileDecoration(
      padding: EdgeInsets.all(getSize(12)),
      child: Material(
        borderRadius: BorderRadius.circular(getSize(16)),
        color: AppColors.scaffoldColor,
        child: UserInfoTile(
          titleIcon: SvgPicture.asset(
            SvgImageConstant.rightArrow,
            height: 13,
            width: 13,
            colorFilter: ColorFilter.mode(AppColors.black.withOpacity(0.5), BlendMode.srcIn),
          ),
          padding: EdgeInsets.symmetric(horizontal: getSize(16)),
          title: "Roboto Flex",
          subTitle: "CT Technologist",
          url: "https://w0.peakpx.com/wallpaper/751/41/HD-wallpaper-women-mood-girl-portrait-profile-sunset.jpg",
          trailing: CommonMaterialButton.icon(
            radius: 10.0,
            backgroundColor: AppColors.redAccent.withOpacity(0.2),
            width: 90,
            height: 33,
            onPressed: () => _showBlockedDialog(context),
            label: "Blocked",
            textStyle: TextStyle(fontSize: 10, color: AppColors.red),
            icon: SvgPicture.asset(SvgImageConstant.blockedFilled, height: 15, width: 15),
          ),
        ),
      ),
    );
  }

  void _showBlockedDialog(BuildContext context) {
    AppDialog.showDelete(
      title: "Unblock",
      context,
      infoMessage:
          "Unblocking [contractor name] will allow them to view and apply for your future postings. Are you sure you want to proceed?",
      onCancelClick: () {
        Navigator.pop(context);
      },
      onDeleteClick: () {},
      deleteBtnText: "Unblock",
    );
  }
}
