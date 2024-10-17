import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'SingleAgreedShift')
class SingleAgreedShift extends StatelessWidget {
  const SingleAgreedShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: StringConstant.agreedProposal,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        child: SingleChildScrollView(
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
      ),
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
}
