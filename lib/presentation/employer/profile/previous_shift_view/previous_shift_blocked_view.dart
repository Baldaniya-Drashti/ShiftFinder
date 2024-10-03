import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_fav_view.dart';

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
            itemBuilder: (context, index) => PreviousShiftFavTile(
              profileImage: '',
              title: "Barbara ",
              subtitle: 'CT Technologist',
              traling: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.symmetric(horizontal: getSize(13), vertical: getSize(2)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                  backgroundColor: AppColors.red.withOpacity(0.2),
                ),
                icon: SvgPicture.asset(SvgImageConstant.blockedFilled, height: 15, width: 15),
                onPressed: () {
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
                },
                label: BaseText(text: "Blocked", fontSize: 10, textColor: AppColors.red),
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
