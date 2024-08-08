import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class CommonCardDialog extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String buttonText;
  final Function() onPressed;
  const CommonCardDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.buttonText,
      required this.onPressed,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  addCardDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        insetPadding: EdgeInsets.symmetric(horizontal: getSize(30)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(15)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(15)),
                  child: Image.asset(PngImageConstants.curvedBackgroundImage),
                ),
                Positioned(
                  top: getSize(85),
                  child: SvgPicture.asset(
                    image,
                    height: getSize(107),
                    width: getSize(107),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getSize(90),
            ),
            BaseText(
              text: title,
              fontSize: 22,
              fontFamily: 'Aclonica',
            ),
            SizedBox(
              height: getSize(10),
            ),
            BaseText(
              text: description,
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black.withOpacity(0.7),
            ),
            SizedBox(
              height: getSize(30),
            ),
            CommonButton(
              height: 46,
              width: 200,
              onPressed: onPressed,
              // () {
              //   context.router.maybePop();
              //   context.router.push(PageRouteInfo(AddCardView.name));
              // },
              buttonText: buttonText,
            ),
            SizedBox(
              height: getSize(25),
            ),
          ],
        ),
      ),
    );
  }
}
