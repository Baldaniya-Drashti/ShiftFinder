import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

class AcceptRejectView extends StatelessWidget {
  const AcceptRejectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CommonButton(
            onPressed: () {
              AcceptRejectDialog(
                title: 'Accept',
                description:
                    'Are you sure you want to accept this application?',
                onPressedAccept: () {},
                onPressedReject: () {
                  context.router.maybePop();
                },
              ).acceptRejectDialog(context);
              // CommonCardDialog(
              //   title: 'Card Details',
              //   description: 'Please add your card details to proceed.',
              //   buttonText: 'Add Card',
              //   onPressed: () {
              //     context.router.maybePop();
              //     context.router.push(PageRouteInfo(AddCardView.name));
              //   },
              //   image: SvgImageConstant.cardImage,
              // ).addCardDialog(context);
            },
            buttonText: 'Accept',
            buttonFontSize: 12,
            borderRadius: 10,
            height: 34,
          ),
        ),
        SizedBox(width: getSize(16)),
        Expanded(
          child: CommonButton(
            onPressed: () {
              AcceptRejectDialog(
                title: 'Reject',
                description:
                    'Are you sure you want to reject this application?',
                onPressedAccept: () {},
                acceptButtonText: 'Reject',
                onPressedReject: () {
                  context.router.maybePop();
                },
              ).acceptRejectDialog(context);
            },
            backgroundColor: AppColors.white,
            borderColor: AppColors.green,
            buttonTextColor: AppColors.green,
            buttonFontSize: 12,
            borderRadius: 10,
            buttonText: 'Reject',
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
            buttonText: 'View Profile',
            height: 34,
          ),
        ),
      ],
    );
  }
}
