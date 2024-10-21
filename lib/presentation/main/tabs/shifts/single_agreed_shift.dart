// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'SingleAgreedShift')
class SingleAgreedShift extends StatelessWidget {
  EmployerProposalDto contractor;
  int? index;
  SingleAgreedShift({required this.contractor, this.index});

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
                            text: DateFormat('d MMM, yyyy').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    ((contractor.shift_type == 1)
                                            ? contractor.start_date ?? -1
                                            : contractor
                                                    .shift_details?[index ?? 0]
                                                    .start_date ??
                                                -1) *
                                        1000)),
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
              (contractor.shift_type == 1)
                  ? postedValue(
                      postedLabel: StringConstant.postedTime,
                      proposedLabel: StringConstant.proposedTime,
                      postedValue:
                          "${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.posted_start_time ?? -1) * 1000))} to ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.posted_end_time ?? -1) * 1000))}",
                      proposedValue:
                          "${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.agreed_start_time ?? -1) * 1000))} to ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.agreed_end_time ?? -1) * 1000))}",
                    )
                  : postedValue(
                      postedLabel: StringConstant.postedTime,
                      proposedLabel: StringConstant.proposedTime,
                      postedValue:
                          "${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.shift_details?[index ?? 0].posted_start_time ?? -1) * 1000))} to ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.shift_details?[index ?? 0].posted_end_time ?? -1) * 1000))}",
                      proposedValue: (contractor.shift_details?[index ?? 0]
                                      .proposed_start_time !=
                                  null &&
                              contractor.shift_details?[index ?? 0]
                                      .proposed_end_time !=
                                  null)
                          ? "${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.shift_details?[index ?? 0].proposed_start_time)! * 1000))} to ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch((contractor.shift_details?[index ?? 0].proposed_end_time)! * 1000))}"
                          : StringConstant.notAvailable,
                      isUnAvailable: (contractor.shift_details?[index ?? 0]
                                  .proposed_start_time ==
                              null &&
                          contractor.shift_details?[index ?? 0]
                                  .proposed_end_time ==
                              null),
                    ),
              postedValue(
                label: StringConstant.hourlyRate,
                postedValue: "\$${contractor.posted_hourly_rate ?? 00}",
                proposedValue: "\$${contractor.proposed_hourly_rate ?? 00}",
              ),
              postedValue(
                label: StringConstant.commuteAllowance,
                postedValue: (contractor.commute_allowance_type == 1)
                    ? "\$${contractor.posted_commute_allowance_rate ?? 00}"
                    : "${contractor.posted_commute_allowance_hour_name ?? 00}",
                proposedValue: (contractor.commute_allowance_type == 1)
                    ? "\$${contractor.proposed_commute_allowance_rate ?? 00}"
                    : "${contractor.proposed_commute_allowance_hour_name ?? 00}",
              ),
              postedValue(
                label: StringConstant.accommodationAllowance,
                postedValue: (contractor.accommodation_allowance_type == 1)
                    ? "\$${contractor.posted_accommodation_allowance_rate ?? 00}"
                    : "${contractor.posted_accommodation_allowance_hour_name ?? 00}",
                proposedValue: (contractor.accommodation_allowance_type == 1)
                    ? "\$${contractor.proposed_accommodation_allowance_rate ?? 00}"
                    : "${contractor.proposed_accommodation_allowance_hour_name ?? 00}",
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
    bool isUnAvailable = false,
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
                textColor: isUnAvailable ? AppColors.redAccent : null,
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
    Color? textColor,
  }) {
    return CustomTextField(
      labelText: label,
      isLabelPadding: false,
      hintAsValue: true,
      hintText: value,
      hintTextColor: textColor,
      readOnly: true,
    );
  }
}
