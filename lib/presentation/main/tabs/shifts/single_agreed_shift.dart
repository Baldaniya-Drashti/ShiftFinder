// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
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
        title: (contractor.first_name != null && contractor.last_name != null)
            ? "${contractor.first_name ?? ""} ${contractor.last_name ?? ""}"
            : StringConstant.agreedProposal,
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
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(getSize(7)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SvgImageConstant.calendar,
                      height: getSize(15),
                      width: getSize(15),
                      color: AppColors.black.withValues(alpha: 0.7),
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
                                CustomDateTimeFormat.timeStampToDateTime(
                                    ((contractor.shift_type == 1)
                                        ? contractor.start_date ?? -1
                                        : contractor.shift_details?[index ?? 0]
                                                .start_date ??
                                            -1))),
                            style: TextStyle(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              (contractor.shift_type == 1)
                  ? shiftTimeBox(
                      postedLabel: StringConstant.postedTime,
                      proposedLabel: StringConstant.agreedTime,
                      postedValue:
                          "${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.posted_start_time ?? -1)))} to ${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.posted_end_time ?? -1)))}",
                      proposedValue:
                          "${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.agreed_start_time ?? -1)))} to ${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.agreed_end_time ?? -1)))}",
                    )
                  : shiftTimeBox(
                      postedLabel: StringConstant.postedTime,
                      proposedLabel: StringConstant.agreedTime,
                      postedValue:
                          "${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.shift_details?[index ?? 0].posted_start_time ?? -1)))} to ${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.shift_details?[index ?? 0].posted_end_time ?? -1)))}",
                      proposedValue: (contractor.shift_details?[index ?? 0]
                                      .proposed_start_time !=
                                  null &&
                              contractor.shift_details?[index ?? 0]
                                      .proposed_end_time !=
                                  null)
                          ? "${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.shift_details?[index ?? 0].proposed_start_time)!))} to ${DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.shift_details?[index ?? 0].proposed_end_time)!))}"
                          : StringConstant.notAvailable,
                      isUnAvailable: (contractor.shift_details?[index ?? 0]
                                  .proposed_start_time ==
                              null &&
                          contractor.shift_details?[index ?? 0]
                                  .proposed_end_time ==
                              null),
                    ),
              proposedBox(
                label: StringConstant.hourlyRate,
                postedValue: "\$${contractor.posted_hourly_rate ?? 00}",
                proposedValue:
                    "\$${contractor.agreed?.agreed_hourly_rate ?? 00}",
              ),
              proposedBox(
                label: StringConstant.commuteAllowance,
                postedValue: (contractor.commute_allowance_type == 1)
                    ? "\$${contractor.posted_commute_allowance_rate ?? 00}"
                    : "${contractor.posted_commute_allowance_hour_name ?? 00}",
                proposedValue: (contractor.commute_allowance_type == 1)
                    ? "\$${contractor.agreed?.agreed_commute_allowance_rate ?? 00}"
                    : "${contractor.agreed?.agreed_commute_allowance_hour_name ?? 00}",
              ),
              proposedBox(
                label: StringConstant.accommodationAllowance,
                postedValue: (contractor.accommodation_allowance_type == 1)
                    ? "\$${contractor.posted_accommodation_allowance_rate ?? 00}"
                    : "${contractor.posted_accommodation_allowance_hour_name ?? 00}",
                proposedValue: (contractor.accommodation_allowance_type == 1)
                    ? "\$${contractor.agreed?.agreed_accommodation_allowance_rate ?? 00}"
                    : "${contractor.agreed?.agreed_accommodation_allowance_hour_name ?? 00}",
              ),
              payableBox(contractor),
            ],
          ),
        ),
      ),
    );
  }

  Widget shiftTimeBox({
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
                label: proposedLabel ?? StringConstant.agreed,
                value: proposedValue,
                textColor: isUnAvailable
                    ? AppColors.redAccent
                    : AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(height: getSize(height ?? 15));
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

  Widget proposedBox({
    String? label,
    String? postedLabel,
    String? proposedLabel,
    required String postedValue,
    required String proposedValue,
    bool isUnAvailable = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getSize(15), vertical: getSize(10)),
            child: BaseText(
              text: label,
              textColor: AppColors.black.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        Container(
          padding: EdgeInsets.all(getSize(10)),
          decoration: BoxDecoration(
            color: AppColors.grey04,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                rateBox(
                  title: postedLabel ?? StringConstant.posted,
                  value: postedValue,
                ),
                verticalDivider(),
                rateBox(
                  title: proposedLabel ?? StringConstant.agreed,
                  value: proposedValue,
                  valueColor: isUnAvailable
                      ? AppColors.redAccent
                      : AppColors.primaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      color: AppColors.black.withValues(alpha: 0.30),
      thickness: getSize(2),
      indent: getSize(5),
      endIndent: getSize(5),
    );
  }

  Widget rateBox(
      {required String title, required String value, Color? valueColor}) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: getSize(5)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            Gap(getSize(5)),
            BaseText(
              text: value,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: valueColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget payableBox(
    EmployerProposalDto shift,
  ) {
    EmployerAgreedProposalEmployerAgreedShiftDetail payable =
        shift.shift_detail?.payables ??
            EmployerAgreedProposalEmployerAgreedShiftDetail();
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getSize(12), vertical: getSize(10)),
      margin: EdgeInsets.symmetric(vertical: getSize(5)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.grey04, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          paybaleTitleRate(
            title: StringConstant.numberOfShifts,
            value:
                "${(shift.total_shift != null && shift.total_shift! > 9) ? shift.total_shift : "0${shift.total_shift ?? 0}"}",
          ),
          SizedBox(height: getSize(10)),
          paybaleTitleRate(
            title: StringConstant.payableHours,
            value: payable.total_payable_hour ?? "",
          ),
          paybaleTitleRate(
            title: StringConstant.hourlyRate,
            value: "\$${payable.rate_hour ?? ""}",
          ),
          paybaleTitleRate(
            title: StringConstant.totalWage,
            value: "\$${payable.total_wage ?? 00}",
            isBold: true,
          ),
          SizedBox(height: getSize(10)),
          paybaleTitleRate(
            title: StringConstant.commuteAllowance,
            value: "\$${payable.commute_allowance ?? 00}",
          ),
          paybaleTitleRate(
            title: StringConstant.accommodationAllowance,
            value: "\$${payable.accommodation_allowance ?? 00}",
          ),
          paybaleTitleRate(
            title: StringConstant.totalAllowances,
            value: "\$${payable.total_allowance ?? 00}",
            isBold: true,
          ),
          SizedBox(height: getSize(10)),
          paybaleTitleRate(
            title: (shift.shift_type == 2 && shift.same_or_different_time == 1)
                ? StringConstant.shiftFinderServiceFee
                : StringConstant.totalShiftFinderServiceFee,
            value: "\$${double.parse(payable.service_fee ?? "00.00")}",
          ),
          paybaleTitleRate(
            title: StringConstant.thirdPartyProcessingFee,
            value: "\$${payable.third_party_fee ?? 00}",
          ),
          paybaleTitleRate(
            title: StringConstant.tax,
            value: "\$${payable.third_party_tax_fee ?? 00}",
          ),
          SizedBox(height: getSize(10)),
          if (shift.shift_type == 2 && shift.same_or_different_time == 1) ...[
            paybaleTitleRate(
              title: StringConstant.totalPayableForOneShift,
              value: "\$${payable.total_one_shift ?? 00}",
              // isFirst: true,
            ),
          ],
          paybaleTitleRate(
            title: StringConstant.numberOfVacancies,
            value:
                "${(payable.number_of_vacancie.toString().length == 2) ? payable.number_of_vacancie : "0${payable.number_of_vacancie}"}",
            // isFirst: true,
          ),
          commonDivider(),
          paybaleTitleRate(
            title: StringConstant.estimatedTotalPayable,
            value: "\$${payable.total_amount_payable ?? 00}",
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget commonDivider() {
    return Divider(
      color: AppColors.black.withValues(alpha: 0.2),
      thickness: getSize(0.5),
    );
  }

  Widget paybaleTitleRate({
    required String title,
    required String value,
    bool isFirst = false,
    bool isLast = false,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BaseText(
          text: title,
          fontSize: 12,
          fontWeight: (isLast || isBold) ? FontWeight.w600 : FontWeight.w400,
          textColor: AppColors.black.withValues(alpha: 0.7),
        ),
        BaseText(
          text: value,
          fontSize: (isLast) ? 18 : 14,
          fontWeight: (isLast || isBold) ? FontWeight.w600 : FontWeight.w400,
          textColor: (isFirst) ? AppColors.primaryColor : AppColors.black,
        ),
      ],
    );
  }
}
