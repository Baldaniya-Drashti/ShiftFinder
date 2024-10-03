import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';

class PreviousShiftRemarkedView extends StatelessWidget {
  const PreviousShiftRemarkedView({super.key});

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
            text: "You can remove a contractor from your remarked list by clicking the delete button again.",
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: getSize(18),
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => _PreviousShiftRemarkedTile(),
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

class _PreviousShiftRemarkedTile extends StatelessWidget {
  const _PreviousShiftRemarkedTile({super.key});

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
                backgroundColor: AppColors.green,
                radius: 24,
              ),
              title: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: "Roboto Flex",
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      SizedBox(
                        width: getSize(10),
                      ),
                      SvgPicture.asset(
                        SvgImageConstant.rightArrow,
                        height: 13,
                        width: 13,
                        color: AppColors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                ),
              ),
              subtitle: Row(
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
                      fontSize: 11,
                      textColor: AppColors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              trailing: Material(
                color: AppColors.red.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.all(getSize(9)),
                  child: SvgPicture.asset(
                    SvgImageConstant.delete,
                    color: AppColors.red,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getSize(12),
            ),
            BaseText(
              text: "Comment",
              fontSize: getSize(16),
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
                  fontSize: getSize(14),
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
