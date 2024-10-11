// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shift/application/contractor/contractor_main_tab_bloc/contractor_shift_bloc/contractor_shift_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/png_image_constants.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/contractor_main/shift/applied_shift_dto/applied_shift_dto.dart';
import 'package:shift/infrastructure/onboarding_model/onboarding_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/common_lisitng/common_listing.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ProposalReceived')
class ProposalReceived extends StatelessWidget {
  AppliedShiftDTO post;
  ProposalReceived({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final proposal = post.proposal_received;
    print("Proposal sharee---> $proposal");
    return BlocProvider(
      create: (context) => getIt<ContractorShiftBloc>(),
      child: BlocBuilder<ContractorShiftBloc, ContractorShiftState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              onBackPressed: () {
                context.router.maybePop();
              },
              title: StringConstant.proposalReceived,
            ),
            body: Container(
              padding: EdgeInsets.all(getSize(10)),
              margin: EdgeInsets.symmetric(horizontal: getSize(20)),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  userDetail(context),
                  proposedBox(
                    title: StringConstant.hourlyRate,
                    postedValue: allowncValue(
                      "${proposal?.posted_hourly_rate ?? 00}",
                      isRate: true,
                    ),
                    proposedValue: allowncValue(
                      "${proposal?.proposed_hourly_rate ?? 00}",
                      isRate: true,
                    ),
                    counterProposalValue: allowncValue(
                      "${proposal?.counter_proposal_hourly_rate ?? ""}",
                      isRate: true,
                    ),
                  ),
                  paddingBetweenFields(),
                  proposedBox(
                    title: StringConstant.commuteAllowance,
                    postedValue: allowncValue(
                        "${proposal?.posted_commute_allowance ?? 00}",
                        isHour: proposal?.commute_allowance_type == "2"),
                    proposedValue: allowncValue(
                        "${proposal?.proposed_commute_allowance ?? 00}",
                        isHour: proposal?.commute_allowance_type == "2"),
                    counterProposalValue: allowncValue(
                        "${proposal?.counter_proposal_accommodation_allowance ?? ""}",
                        isHour: proposal?.commute_allowance_type == "2"),
                  ),
                  paddingBetweenFields(),
                  proposedBox(
                    title: StringConstant.accommodationAllowance,
                    postedValue: allowncValue(
                        "${proposal?.posted_accommodation_allowance ?? 00}",
                        isHour: proposal?.accommodation_allowance_type == "2"),
                    proposedValue: allowncValue(
                        "${proposal?.proposed_accommodation_allowance ?? 00}",
                        isHour: proposal?.accommodation_allowance_type == "2"),
                    counterProposalValue: allowncValue(
                        "${proposal?.counter_proposal_accommodation_allowance ?? ""}",
                        isHour: proposal?.accommodation_allowance_type == "2"),
                  ),
                  paddingBetweenFields(height: 20),
                  Row(
                    children: [
                      buttonUI(
                        onPressed: () {
                          AppDialog.showDelete(
                            context,
                            title: StringConstant.accept,
                            infoMessage: StringConstant.acceptProposalDesc,
                            deleteBtnText: StringConstant.accept,
                            onCancelClick: () {
                              context.router.maybePop();
                            },
                            onDeleteClick: () {
                              context.router.maybePop();
                              context.read<ContractorShiftBloc>().add(
                                    ContractorShiftEvent
                                        .proposalAcceptRejectEvent(
                                      context,
                                      postId: post.id ?? -1,
                                      urgentAction: 1,
                                    ),
                                  );
                            },
                          );
                        },
                        buttonText: StringConstant.accept,
                      ),
                      SizedBox(width: getSize(10)),
                      buttonUI(
                        onPressed: () {
                          AppDialog.showDelete(
                            context,
                            title: StringConstant.reject,
                            infoMessage: StringConstant.rejectProposalDesc,
                            deleteBtnText: StringConstant.reject,
                            onCancelClick: () {
                              context.router.maybePop();
                            },
                            onDeleteClick: () {
                              context.router.maybePop();
                              context.read<ContractorShiftBloc>().add(
                                    ContractorShiftEvent
                                        .proposalAcceptRejectEvent(
                                      context,
                                      postId: post.id ?? -1,
                                      urgentAction: 2,
                                    ),
                                  );
                            },
                          );
                        },
                        buttonText: StringConstant.reject,
                        bgColor: AppColors.transparent,
                        textColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  paddingBetweenFields(height: 15),
                  buttonUI(
                    onPressed: () {
                      context.router
                          .push(PageRouteInfo(SendProposal.name,
                              args:
                                  SendProposalArgs(postId: post.post_id ?? -1)))
                          .then((value) {
                        if (value == true) {
                          Navigator.pop(context, true);
                        }
                      });
                    },
                    buttonText: StringConstant.sendNewProposal,
                    textColor: AppColors.black,
                    bgColor: AppColors.scaffoldColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String allowncValue(String value,
      {bool isRate = false, bool isHour = false}) {
    String formatedValue = value;

    if (formatedValue.isNotEmpty) {
      if (value.length < 2) {
        formatedValue = "0$value";
      } else {
        formatedValue = value;
      }
      if (isRate) {
        return "\$ $formatedValue";
      } else {
        return (isHour)
            ? "$formatedValue ${StringConstant.hours}"
            : "\$ $formatedValue";
      }
    } else {
      return "";
    }
  }

  Widget paddingBetweenFields({double? height}) {
    return SizedBox(
      height: getSize(height ?? 10),
    );
  }

  Widget userDetail(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getSize(10)),
        color: AppColors.scaffoldColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: getSize(12)),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Image.asset(
              PngImageConstants.leafWithBG,
              height: getSize(40),
              width: getSize(40),
            ),
            isThreeLine: true,
            title: BaseText(
              text: post.role_lists_name ?? " ",
              textColor: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: post.company_name ?? " ",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
                BaseText(
                  text:
                      "(${getIndustry(post.industry_id ?? 0)}  - ${post.listing_id ?? ''})",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black.withOpacity(0.80),
                ),
              ],
            ),
            trailing: BaseText(
              text: post.last_ago ?? " ",
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
          Divider(
            color: AppColors.black.withOpacity(0.2),
            thickness: getSize(0.5),
          ),
          GestureDetector(
            onTap: () {
              /*context.router.push(
                    PageRouteInfo(
                      ShowGoogleMap.name,
                      args: ShowGoogleMapArgs(
                        latitude: 21.191535534205194,
                        longitude: 72.78582206137469,
                      ),
                    ),
                  );*/
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgImageConstant.location,
                  height: getSize(25),
                  width: getSize(25),
                  color: AppColors.black,
                ),
                SizedBox(
                  width: getSize(10),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text: post.location ?? " ",
                        fontSize: 12,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.black,
                      ),
                      BaseText(
                        text: post.distance ?? " ",
                        fontSize: 10,
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getSize(12),
          ),
        ],
      ),
    );
  }

  String getIndustry(int id) {
    OnBoardingDTO industry = CommonList.industryList.firstWhere(
      (item) => item.id == id,
      orElse: () => OnBoardingDTO(),
    );
    return industry.title ?? "";
  }

  Widget proposedBox(
      {required String title,
      required String postedValue,
      required String proposedValue,
      String? counterProposalValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(15), vertical: getSize(10)),
          child: BaseText(
            text: title,
            textColor: AppColors.black.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(10)),
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                rateBox(
                  title: StringConstant.posted,
                  value: postedValue,
                ),
                verticalDivider(),
                rateBox(
                  title: StringConstant.proposed,
                  value: proposedValue,
                ),
                if (counterProposalValue != null &&
                    counterProposalValue.isNotEmpty) ...[
                  verticalDivider(),
                  rateBox(
                    title: StringConstant.counterProposal,
                    value: counterProposalValue,
                    valueColor: AppColors.primaryColor,
                  ),
                ],
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(
      color: AppColors.black.withOpacity(0.30),
      thickness: getSize(2),
      indent: getSize(5),
      endIndent: getSize(5),
    );
  }

  Widget rateBox(
      {required String title, required String value, Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: title,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          textColor: AppColors.black.withOpacity(0.7),
        ),
        SizedBox(height: getSize(2)),
        BaseText(
          text: value,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          textColor: valueColor,
        ),
      ],
    );
  }

  Widget buttonUI({
    required void Function() onPressed,
    required String buttonText,
    Color? bgColor,
    Color? textColor,
    Color? borderColor,
  }) {
    return Flexible(
      child: CommonButton(
        onPressed: onPressed,
        height: 46,
        borderRadius: 10,
        buttonText: buttonText,
        buttonFontSize: 16,
        buttonTextColor: textColor,
        backgroundColor: bgColor,
        borderColor: borderColor,
      ),
    );
  }
}
