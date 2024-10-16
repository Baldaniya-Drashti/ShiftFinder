// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'HiredContractorList')
class HiredContractorList extends StatelessWidget {
  HiredContractorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: StringConstant.allHiredContractors,
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: getSize(10)),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  context.router.push(
                    PageRouteInfo(ViewApplicantProfile.name),
                  );
                },
                child: contractorDetail(context));
          }),
    );
  }

  Widget contractorDetail(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: getSize(8), horizontal: getSize(20)),
      padding: EdgeInsets.symmetric(
        vertical: getSize(15),
        horizontal: getSize(15),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getSize(15),
          horizontal: getSize(15),
        ),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(getSize(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: getSize(20),
              backgroundColor: AppColors.green,
              child: CircleAvatar(
                radius: getSize(19),
                backgroundImage: NetworkImage(""),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: getSize(10), right: getSize(5)),
                  child: BaseText(
                    text: "dkvnkv",
                    // text: '${userList.firstName ?? ""} ${userList.lastName ?? ""}',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: getSize(10)),
                BaseText(
                  text: StringConstant.viewAgreedProposal,
                  // text: '${userList.firstName ?? ""} ${userList.lastName ?? ""}',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.primaryColor,
                ),
              ],
            ),
            Spacer(),
            CommonButton(
              height: 35,
              width: 85,
              borderRadius: 5,
              onPressed: () {
                showUnderDevelopment(context);
              },
              backgroundColor: AppColors.primaryColor.withOpacity(0.15),
              buttonText: "",
              customWidget: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgImageConstant.chat,
                    color: AppColors.black,
                    height: getSize(15),
                    width: getSize(15),
                  ),
                  SizedBox(width: getSize(5)),
                  BaseText(
                    text: StringConstant.chat,
                    fontWeight: FontWeight.w600,
                    fontSize: getFontSize(12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
