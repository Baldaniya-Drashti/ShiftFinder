import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewPersonPraposalView')
class ViewPersonPraposalView extends StatelessWidget {
  const ViewPersonPraposalView({
    super.key,
    required this.postId,
    required this.userId,
  });

  final int postId;
  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: 'View Proposal',
      ),
      body: ListView(
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
              ],
            ),
          ),
          SizedBox(
            height: getSize(50),
          ),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onPressed: () {
                    AcceptRejectDialog(
                      title: 'Accept',
                      description: 'Are you sure you want to accept this application?',
                      onPressedAccept: () {
                        context.router.maybePop().then(
                              (value) => CommonCardDialog(
                                title: 'Awaiting Confirmation',
                                description: 'Application accepted, Contractor\nnotified for Confirmation.',
                                buttonText: 'Ok',
                                onPressed: () {
                                  //context.router.maybePop();
                                  context.router.push(PageRouteInfo(AwaitingConfirmationView.name));
                                },
                                image: SvgImageConstant.awaitingConfirmation,
                              ).addCardDialog(context),
                            );
                      },
                      onPressedReject: () {
                        context.router.maybePop();
                      },
                    ).acceptRejectDialog(context);
                  },
                  buttonText: 'Accept',
                  buttonFontSize: 16,
                  borderRadius: 10,
                  height: 46,
                ),
              ),
              SizedBox(width: getSize(16)),
              Expanded(
                child: CommonButton(
                  onPressed: () {
                    AcceptRejectDialog(
                      title: 'Reject',
                      description: 'Are you sure you want to reject this application?',
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
                  buttonFontSize: 16,
                  borderRadius: 10,
                  buttonText: 'Reject',
                  height: 46,
                ),
              ),
            ],
          ),
          SizedBox(
            height: getSize(20),
          ),
          CommonButton(
            onPressed: () {
              context.router.push(PageRouteInfo(CounterPurposeView.name));
            },
            buttonText: 'Counter Propose',
            borderRadius: 7,
            buttonTextColor: AppColors.black,
            backgroundColor: AppColors.white,
          ),
          SizedBox(
            height: getSize(20),
          ),
        ],
      ),
    );
  }

  getTitleAndDescription(BuildContext context, {required String title, required String description}) {
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
          padding: EdgeInsets.symmetric(horizontal: getSize(20), vertical: getSize(15)),
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
