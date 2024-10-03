import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';

class PreviousShiftFavView extends StatelessWidget {
  const PreviousShiftFavView({super.key});

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
            text: "You can remove a contractor from your favorites list by clicking the favorite button again.",
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: getSize(18),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => PreviousShiftFavTile(
              profileImage: '',
              title: "Roboto Flex",
              subtitle: 'CT Technologist',
              traling: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.symmetric(horizontal: getSize(13), vertical: getSize(2)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  backgroundColor: AppColors.green.withOpacity(0.2),
                ),
                icon: SvgPicture.asset(
                  SvgImageConstant.heartChecked,
                  height: 11,
                  width: 11,
                ),
                onPressed: () {
                  AppDialog.showDelete(
                    title: "Unfavorite",
                    context,
                    infoMessage: "Removing [contractor name] from your favorites list will no longer highlight their profile. Are you sure you want to proceed?",
                    onCancelClick: () {
                      Navigator.pop(context);
                    },
                    onDeleteClick: () {},
                    deleteBtnText: "Unfavorite"
                  );
                },
                label: BaseText(text: "Favorite", fontSize: 10, textColor: AppColors.green),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: getSize(16),
            ),
            itemCount: 4,
          )
        ],
      ),
    );
  }
}

class PreviousShiftFavTile extends StatelessWidget {
  const PreviousShiftFavTile({
    super.key,
    required this.profileImage,
    required this.title,
    required this.subtitle,
    required this.traling,
  });

  final String profileImage;
  final String title;
  final String subtitle;
  final Widget traling;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(16))),
      child: Padding(
        padding: EdgeInsets.all(getSize(12)),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(getSize(16))),
          tileColor: AppColors.scaffoldColor,
          leading:  CircleAvatar(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: title,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      SizedBox(
                        width: getSize(10),
                      ),
                      SvgPicture.asset(
                        SvgImageConstant.rightArrow,
                        height: 8,
                        width: 8,
                        color: AppColors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                ),
              ),
              BaseText(
                text: subtitle,
                fontWeight: FontWeight.w500,
                fontSize: 9,
                textColor: AppColors.black.withOpacity(0.6),
              )
            ],
          ),
          trailing: traling,
        ),
      ),
    );
  }
}
