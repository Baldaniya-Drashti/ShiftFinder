import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewAgreedPraposal')
class ViewAgreedPraposal extends StatelessWidget {
  const ViewAgreedPraposal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: CommonAppBar(
        onBackPressed: () {
          Navigator.pop(context);
        },
        title: 'Agreed Proposal',
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: getSize(20),
            vertical: getSize(20),
          ),
          children: [
            SizedBox(height: getSize(10)),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getSize(12),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(getSize(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgImageConstant.calendar,
                    height: getSize(15),
                    width: getSize(15),
                    colorFilter: ColorFilter.mode(
                      AppColors.black.withOpacity(0.7),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: getSize(5)),
                  BaseText(
                    text: 'Shift Date - 12 May 2024',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            // CustomMultiDatePicker(
            //   value: [DateTime.now()],
            //   selectedDateBGColor: AppColors.primaryColor,
            //   // selectableDayPredicate: (date) {
            //   //   //  return isDateExist(selectedDates, date);
            //   // },
            //   onValueChanged: (value) {
            //     print("Value is changed---> $value");
            //     // context
            //     //     .read<SendProposalBloc>()
            //     //     .add(SendProposalEvent.setDateUnavailableEvent(value));
            //   },
            // ),
            SizedBox(height: getSize(30)),
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
                ],
              ),
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
}
