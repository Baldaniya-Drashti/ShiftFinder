import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'MultiAgreedShift')
class MultiAgreedShift extends StatelessWidget {
  const MultiAgreedShift({super.key});

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              totalNoOfShift(
                  svgPrefixIcon: SvgImageConstant.clockWithOuterLine,
                  unavailableShift: "2",
                  title: "kdnv"
                  // "${StringConstant.totalNumberOfShifts} - ${(post.shift_detail?.detail != null && post.shift_detail!.detail!.isNotEmpty) ? "${(post.shift_detail?.detail?.length.toString().length == 2) ? post.shift_detail?.detail?.length : "0${post.shift_detail?.detail?.length}"}" : "00"}",
                  ),
              paddingBetweenFields(),
              BaseText(
                text: StringConstant.agreedProposalDesc,
                fontSize: 12,
              ),
              paddingBetweenFields(),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      context.router
                          .push(PageRouteInfo(SingleAgreedShift.name));
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
                                    DateTime.now().add(Duration(days: index))),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: getSize(16),
                              ),
                            ],
                          )),
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
}
