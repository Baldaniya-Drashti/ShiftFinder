import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  infoDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(getSize(15)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(
              text: StringConstant
                  .ifYouHaveMultipleLocationsYouCanAddThemThroughYourProfile,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            SizedBox(height: getSize(30)),
            CommonButton(
              onPressed: () => context.router.maybePop(),
              buttonText: StringConstant.ok,
              height: 46,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
