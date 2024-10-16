// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/healthcare_post/healthcare_post_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'AgreedProposal')
class AgreedProposal extends StatelessWidget {
  HealthcarePostDTO post;
  AgreedProposal({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: StringConstant.agreedProposal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          child: (post.shift_detail?.shift_type == 2)
              ? singleShiftView()
              : multiShiftView(context),
        ),
      ),
    );
  }

  Widget singleShiftView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: getSize(50),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(getSize(7)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgImageConstant.calendar,
                height: getSize(15),
                width: getSize(15),
                color: AppColors.black.withOpacity(0.7),
              ),
              SizedBox(width: getSize(5)),
              RichText(
                text: TextSpan(
                  text: "${StringConstant.shiftDate} - ",
                  style: TextStyle(
                    fontSize: getFontSize(12),
                    fontWeight: FontWeight.w600,
                    color: AppColors.black.withOpacity(0.6),
                  ),
                  children: [
                    TextSpan(
                      text: "12 May 2024",
                      style: TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        postedValue(
          postedLabel: StringConstant.postedTime,
          proposedLabel: StringConstant.proposedTime,
          postedValue: "9:30 AM to 7:15 PM",
          proposedValue: "9:30 AM to 7:15 PM",
        ),
        postedValue(
          label: StringConstant.hourlyRate,
          postedValue: "9:30 AM to 7:15 PM",
          proposedValue: "9:30 AM to 7:15 PM",
        ),
        postedValue(
          label: StringConstant.commuteAllowance,
          postedValue: "\$20",
          proposedValue: "\$25",
        ),
        postedValue(
          label: StringConstant.accommodationAllowance,
          postedValue: "2 Hours",
          proposedValue: "5 Hours",
        ),
      ],
    );
  }

  Widget postedValue({
    String? label,
    String? postedLabel,
    required String postedValue,
    String? proposedLabel,
    required String proposedValue,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(10)),
            child: BaseText(
              text: label,
              fontSize: 14,
            ),
          ),
        Container(
          margin: EdgeInsets.only(top: getSize(10), bottom: getSize(20)),
          padding: EdgeInsets.symmetric(
              vertical: getSize(20), horizontal: getSize(20)),
          decoration: BoxDecoration(
            color: AppColors.grey04,
            borderRadius: BorderRadius.circular(getSize(20)),
          ),
          child: Column(
            children: [
              commonField(
                label: postedLabel ?? StringConstant.posted,
                value: postedValue,
              ),
              paddingBetweenFields(),
              commonField(
                label: proposedLabel ?? StringConstant.proposed,
                value: proposedValue,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 15),
    );
  }

  Widget totalNoOfShift({
    required String svgPrefixIcon,
    required String title,
    String unavailableShift = "",
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(15),
      ),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: getSize(43),
            width: getSize(35),
            child: SvgPicture.asset(
              svgPrefixIcon,
              color: AppColors.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20)),
            child: SvgPicture.asset(
              SvgImageConstant.verticalLine,
              height: getSize(50),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              paddingBetweenFields(height: 5),
              if (unavailableShift.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      color: AppColors.redAccent,
                      size: getSize(10),
                    ),
                    SizedBox(width: getSize(5)),
                    BaseText(
                      text:
                          "${StringConstant.unavailableShifts} - $unavailableShift",
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.black.withOpacity(0.5),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget commonField({
    required String label,
    required String value,
  }) {
    return CustomTextField(
      labelText: label,
      isLabelPadding: false,
      hintAsValue: true,
      hintText: value,
      readOnly: true,
    );
  }

  Widget multiShiftView(
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        totalNoOfShift(
          svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
          unavailableShift: "2",
          title:
              "${StringConstant.totalNumberOfShifts} - ${(post.shift_detail?.detail != null && post.shift_detail!.detail!.isNotEmpty) ? "${(post.shift_detail?.detail?.length.toString().length == 2) ? post.shift_detail?.detail?.length : "0${post.shift_detail?.detail?.length}"}" : "00"}",
        ),
        paddingBetweenFields(),
        BaseText(
          text: StringConstant.agreedProposalDesc,
          fontSize: 12,
        ),
        paddingBetweenFields(),
        ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: getSize(10)),
              child: CustomTextField(
                readOnly: true,
                onTap: () {
                  print("shiftDetail calledd--");
                  showShiftDetail(context);
                },
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(14),
                    vertical: getSize(14),
                  ),
                  child: SvgPicture.asset(
                    SvgImageConstant.calendar,
                    height: getSize(20),
                    width: getSize(20),
                    color: AppColors.black,
                  ),
                ),
                hintAsValue: true,
                hintText: "8 June, 2024",
              ),
            );
          },
        )
      ],
    );
  }

  showShiftDetail(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            clipBehavior: Clip.none,
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: getSize(50),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(getSize(7)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          SvgImageConstant.calendar,
                          height: getSize(15),
                          width: getSize(15),
                          color: AppColors.black.withOpacity(0.7),
                        ),
                        SizedBox(width: getSize(5)),
                        RichText(
                          text: TextSpan(
                            text: "${StringConstant.shiftDate} - ",
                            style: TextStyle(
                              fontSize: getFontSize(12),
                              fontWeight: FontWeight.w600,
                              color: AppColors.black.withOpacity(0.6),
                            ),
                            children: [
                              TextSpan(
                                text: "12 May 2024",
                                style: TextStyle(
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  postedValue(
                    postedLabel: StringConstant.postedTime,
                    proposedLabel: StringConstant.proposedTime,
                    postedValue: "9:30 AM to 7:15 PM",
                    proposedValue: "9:30 AM to 7:15 PM",
                  ),
                  postedValue(
                    label: StringConstant.hourlyRate,
                    postedValue: "9:30 AM to 7:15 PM",
                    proposedValue: "9:30 AM to 7:15 PM",
                  ),
                  postedValue(
                    label: StringConstant.commuteAllowance,
                    postedValue: "\$20",
                    proposedValue: "\$25",
                  ),
                  postedValue(
                    label: StringConstant.accommodationAllowance,
                    postedValue: "2 Hours",
                    proposedValue: "5 Hours",
                  ),
                ],
              ),
            ),
          );
        });
  }
}
