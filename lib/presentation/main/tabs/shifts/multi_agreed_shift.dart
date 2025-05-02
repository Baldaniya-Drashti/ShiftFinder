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
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'MultiAgreedShift')
class MultiAgreedShift extends StatelessWidget {
  EmployerProposalDto contractor;
  MultiAgreedShift({required this.contractor});

  @override
  Widget build(BuildContext context) {
    int? unavailableShiftCount = (contractor.shift_details != null)
        ? contractor.shift_details!
            .where((shift) => shift.proposed_start_time == null)
            .length
        : null;
    return Scaffold(
      appBar: CommonAppBar(
        onBackPressed: () {
          context.router.maybePop();
        },
        title: (contractor.first_name != null && contractor.last_name != null)
            ? "${contractor.first_name ?? ""} ${contractor.last_name ?? ""}"
            : StringConstant.agreedProposal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              totalNoOfShift(
                svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
                unavailableShift: unavailableShiftCount,
                title:
                    "${StringConstant.totalNumberOfShifts} - ${(contractor.shift_details != null && contractor.shift_details!.isNotEmpty) ? "${(contractor.shift_details!.length > 9) ? contractor.shift_details?.length : "0${contractor.shift_details?.length}"}" : "00"}",
              ),
              paddingBetweenFields(),
              BaseText(
                text: StringConstant.agreedProposalDesc,
                fontSize: 12,
              ),
              paddingBetweenFields(),
              if (contractor.shift_details != null &&
                  contractor.shift_details!.isNotEmpty)
                ListView.builder(
                  itemCount: contractor.shift_details?.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        context.router
                            .push(PageRouteInfo(SingleAgreedShift.name,
                                args: SingleAgreedShiftArgs(
                                  contractor: contractor,
                                  index: index,
                                )));
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: getSize(8)),
                        padding: EdgeInsets.all(getSize(5)),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(getSize(10)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: AppColors.grey,
                              )
                            ]),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getSize(14), horizontal: getSize(15)),
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldColor,
                            borderRadius: BorderRadius.circular(getSize(10)),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgImageConstant.calendar,
                                height: getSize(20),
                                width: getSize(20),
                                color: AppColors.black,
                              ),
                              Gap(getSize(10)),
                              BaseText(
                                text: DateFormat("dd MMM, yyyy").format(
                                    CustomDateTimeFormat.timeStampToDateTime(
                                        (contractor.shift_details?[index]
                                                .start_date ??
                                            -1))),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: getSize(16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(height: getSize(height ?? 15));
  }

  Widget totalNoOfShift({
    required String svgPrefixIcon,
    required String title,
    int? unavailableShift,
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
              if (unavailableShift != null)
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
                      textColor: AppColors.black.withValues(alpha: 0.5),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
