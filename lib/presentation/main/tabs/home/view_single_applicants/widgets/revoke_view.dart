import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

class RevokeView extends StatelessWidget {
  const RevokeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CommonButton(
            onPressed: () {
              AcceptRejectDialog(
                title: 'Revoke',
                description:
                    'Once you revoke, the contractor will\nhave a 2-hour window to confirm the\nshift. If they do not confirm within 2\nhours, the offer will be automatically\nrevoked.',
                onPressedAccept: () {},
                acceptButtonText: 'Revoke',
                onPressedReject: () {
                  context.router.maybePop();
                },
              ).acceptRejectDialog(context);
            },
            backgroundColor: AppColors.redAccent.withValues(alpha: 0.1),
            buttonTextColor: AppColors.black,
            buttonFontSize: 12,
            borderRadius: 10,
            buttonText: 'Revoke',
            height: 34,
          ),
        ),
        SizedBox(width: getSize(16)),
        Expanded(
          child: CommonButton(
            onPressed: () {
              context.router.push(PageRouteInfo(ViewApplicantProfile.name));
            },
            backgroundColor: AppColors.scaffoldColor,
            buttonTextColor: AppColors.black,
            buttonFontSize: 12,
            borderRadius: 10,
            buttonText: 'View Details',
            height: 34,
          ),
        ),
      ],
    );
  }
}
