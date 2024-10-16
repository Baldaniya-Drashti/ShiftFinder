import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/auth/contractor_auth/card_bloc/card_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/proposal_detail_dto/proposal_detail_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';

class PraposalPersonView extends StatelessWidget {
  const PraposalPersonView({
    super.key,
    required this.data,
  });

  final ProposalDetailDto data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getSize(12)),
      // margin: EdgeInsets.all(getSize(10)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(getSize(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(getSize(12)),
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(getSize(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: getSize(20),
                      backgroundColor: AppColors.green,
                      child: CircleAvatar(
                        radius: getSize(19),
                        backgroundImage: NetworkImage(
                          data.profile ?? "",
                        ),
                      ),
                    ),
                    SizedBox(width: getSize(15)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            text: "${data.first_name ?? ""} ${data.last_name ?? ""}",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: getSize(3)),
                          BaseText(
                            text: 'Distance - ${data.distance ?? ""}',
                            fontSize: 8,
                            textColor: const Color.fromARGB(255, 55, 46, 46).withOpacity(0.8),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getSize(10)),
                Divider(
                  height: 0,
                  color: AppColors.black.withOpacity(0.2),
                  thickness: 0.5,
                ),
                SizedBox(height: getSize(10)),
                Row(
                  children: [
                    SvgPicture.asset(
                      SvgImageConstant.location,
                      colorFilter: ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcATop,
                      ),
                    ),
                    SizedBox(width: getSize(6)),
                    Expanded(
                      child: BaseText(
                        text: data.location ?? "",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: getSize(10)),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  height: 34,
                  onPressed: () {},
                  backgroundColor: AppColors.green.withOpacity(0.1),
                  buttonText: 'View Profile',
                  borderRadius: 7,
                  buttonFontSize: 11,
                  buttonTextColor: AppColors.black,
                ),
              ),
              if (data.shift_type == "2") ...[
                Gap(16),
                Expanded(
                  child: CommonButton(
                    height: 34,
                    onPressed: () {
                      context.router.push(
                        PageRouteInfo(
                          EmployerAvailabilityView.name,
                          args: EmployerAvailabilityViewArgs(list: data.posted_proposed_time ?? []),
                        ),
                      );
                    },
                    backgroundColor: AppColors.green.withOpacity(0.1),
                    buttonText: 'Proposed Availability',
                    borderRadius: 7,
                    buttonFontSize: 11,
                    buttonTextColor: AppColors.black,
                  ),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
}
