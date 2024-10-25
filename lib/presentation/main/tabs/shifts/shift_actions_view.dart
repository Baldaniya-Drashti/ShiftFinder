import 'package:auto_route/auto_route.dart';
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
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ShiftActionsView')
class ShiftActionsView extends StatelessWidget {
  const ShiftActionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () => Navigator.pop(context),
        title: "Shift Approved",
      ),
      body: ListView(
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
                        _buildUserInfo(context),
                        Divider(height: 8),
                        Gap(getSize(6.0)),
                        _buildLocationInfo(context),
                      ],
                    ),
                  ),
                ),
                Gap(16),
                _ActionButton(
                  icon: SvgImageConstant.heart1,
                  label: "Add to favorite",
                  onPressed: () {},
                ),
                Gap(16),
                _ActionButton(
                  icon: SvgImageConstant.starOutlined,
                  label: "Leave a Rating",
                  onPressed: () => _onAddRating(context),
                ),
                Gap(16),
                _ActionButton(
                  label: "Remark",
                  icon: SvgImageConstant.medalStar,
                  onPressed: () => _onAddRemark(context),
                ),
                Gap(16),
                _ActionButton(
                  label: "Block",
                  icon: SvgImageConstant.block,
                  onPressed: () => _onBlock(
                    context,
                    //contractorName: "${data.first_name ?? ""} ${data.last_name ?? ""}",
                    contractorName: ""
                  ),
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
                  "Once a shift is approved, you can rate, add to favorites, remark, or block the user. These actions can also be completed later in the profile section.",
            ),
          )
        ],
      ),
    );
  }

  void _onBlock(
    BuildContext context, {
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
      infoMessage: "Blocking $contractorName will prevent them from seeing any future postings. Are you sure you want to proceed?",
      onCancelClick: () => Navigator.pop(context),
      onDeleteClick: () {},
    );
  }

  void _onAddRating(BuildContext context) {
    AppDialog.showLeaveRatingModal(
      context,
      onSubmit: (int value) {},
      contractorName: '',
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

  Future<void> _onAddRemark(BuildContext context) async {
    final result = await showDialog<String?>(
      context: context,
      builder: (context) => AddRemarkModal(),
    );
    if (result != null) {
      //Todo: Call Api
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
