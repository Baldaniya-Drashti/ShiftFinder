import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'CounterPurposeView')
class CounterPurposeView extends StatelessWidget {
  const CounterPurposeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: 'Counter Propose',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          children: [
            SizedBox(height: getSize(20)),
            PraposalPersonView(),
            SizedBox(height: getSize(20)),
            BaseText(
              text: '12 May, 2024',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: AppColors.green,
            ),
            SizedBox(height: getSize(10)),
            Container(
              padding: EdgeInsets.all(getSize(20)),
              decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(getSize(20)),
              ),
              child: Column(
                children: [
                  getTitleAndDescription(
                    context,
                    title: 'Posted Time',
                    description: '9:30 AM to 7:15 PM',
                  ),
                  SizedBox(height: getSize(20)),
                  getTitleAndDescription(
                    context,
                    title: 'Agreed Time',
                    description: '9:30 AM to 7:15 PM',
                  ),
                ],
              ),
            ),
            SizedBox(height: getSize(20)),
            BaseText(
              text: 'Hourly Rate',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: getSize(10)),
            Container(
              padding: EdgeInsets.all(getSize(20)),
              decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(getSize(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitleAndDescription(
                    context,
                    title: 'Posted',
                    description: '\$25',
                  ),
                  SizedBox(height: getSize(20)),
                  getTitleAndDescription(
                    context,
                    title: 'Agreed Time',
                    description: '9:30 AM to 7:15 PM',
                  ),
                  SizedBox(height: getSize(20)),
                  BaseText(
                    text: 'Counter Proposal',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: getSize(8)),
                  CustomTextField(
                    hintText: '\$ Counter Proposal',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            SizedBox(height: getSize(20)),
            BaseText(
              text: 'Commute Allowance',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: getSize(10)),
            Container(
              padding: EdgeInsets.all(getSize(20)),
              decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(getSize(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitleAndDescription(
                    context,
                    title: 'Posted',
                    description: '\$20',
                  ),
                  SizedBox(height: getSize(20)),
                  getTitleAndDescription(
                    context,
                    title: 'Proposed',
                    description: '\$25',
                  ),
                  SizedBox(height: getSize(20)),
                  BaseText(
                    text: 'Counter Proposal',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: getSize(8)),
                  CustomTextField(
                    hintText: '\$ Counter Proposal',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            SizedBox(height: getSize(20)),
            BaseText(
              text: 'Accommodation Allowance',
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: getSize(10)),
            Container(
              padding: EdgeInsets.all(getSize(20)),
              decoration: BoxDecoration(
                color: Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(getSize(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getTitleAndDescription(
                    context,
                    title: 'Posted',
                    description: '\$20',
                  ),
                  SizedBox(height: getSize(20)),
                  getTitleAndDescription(
                    context,
                    title: 'Proposed',
                    description: '\$25',
                  ),
                  SizedBox(height: getSize(20)),
                  BaseText(
                    text: 'Counter Proposal',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: getSize(8)),
                  CustomTextField(
                    hintText: '\$ Counter Proposal',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getSize(50),
            ),
            CommonButton(
              onPressed: () {
                AcceptRejectDialog(
                  title: 'Counter Propose',
                  description:
                      'Are you sure you want to send a counter proposal?',
                  onPressedAccept: () {},
                  onPressedReject: () {
                    context.router.maybePop();
                  },
                  acceptButtonText: 'Send',
                ).acceptRejectDialog(context);
              },
              buttonText: 'Send Counter Proposal',
            ),
            SizedBox(
              height: getSize(20),
            ),
          ],
        ),
      ),
    );
  }

  getTitleAndDescription(BuildContext context,
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: getSize(8)),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(15)),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(getSize(10)),
          ),
          child: BaseText(
            text: description,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  getDetailsView({
    required String mainTitle,
    required String skills,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: mainTitle,
          textColor: AppColors.green.withOpacity(0.8),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: getSize(5)),
        BaseText(
          text: skills,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
