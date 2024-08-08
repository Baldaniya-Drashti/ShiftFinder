import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';

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
              CommonCardDialog(
                title: 'Accept',
                description: 'Are you sure you want to accept this applicant?',
                buttonText: 'Accept',
                onPressed: () {},
                image: 'assets/svg/accept.svg',
              ).addCardDialog(context);
              //   AddCardDialog().addCardDialog(context);
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
            onPressed: () {},
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
            onPressed: () {},
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
