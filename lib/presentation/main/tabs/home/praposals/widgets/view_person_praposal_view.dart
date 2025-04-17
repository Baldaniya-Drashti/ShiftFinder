import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/employer/proposal_detail/proposal_detail_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/employer/profile/previous_shift_view/previous_shift_all_view.dart';
import 'package:shift/presentation/main/tabs/home/praposals/widgets/person_praposal_view.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/common_card_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ViewPersonPraposalView')
class ViewPersonPraposalView extends StatelessWidget {
  const ViewPersonPraposalView({
    super.key,
    required this.postId,
    required this.userId,
    required this.user,
  });

  final int postId;
  final int userId;
  final EmployerProposalPendingUserDto user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProposalDetailBloc>()
        ..add(
          ProposalDetailEvent.getProposalDetail(
              postId: postId, userId: userId, context: context),
        ),
      child: Scaffold(
        appBar: CommonAppBar(
          onBackPressed: () {
            context.router.maybePop();
          },
          title: StringConstant.viewProposal,
        ),
        body: BlocBuilder<ProposalDetailBloc, ProposalDetailState>(
          builder: (context, state) {
            if (state.isLoading) return CenterLoadingIndicator();
            final data = state.proposalDetailDto;
            return Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                  children: [
                    SizedBox(height: getSize(20)),
                    PraposalPersonView(
                      data: data,
                      confirmDialog: state.confirmDialog ?? false,
                      postId: postId,
                    ),
                    SizedBox(height: getSize(20)),
                    if (data.shift_type == 1) ...[
                      BaseText(
                        text: DateFormat("dd MMM, yyyy").format(
                            DateTime.fromMillisecondsSinceEpoch(
                                (data.start_date ?? 0) * 1000)),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.green,
                      ),
                      SizedBox(height: getSize(10)),
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
                              title: StringConstant.postedTime,
                              description:
                                  '${formatUnixTimestamp(data.posted_start_time ?? 0)} to ${formatUnixTimestamp(data.posted_end_time ?? 0)}',
                            ),
                            SizedBox(height: getSize(20)),
                            getTitleAndDescription(
                              context,
                              title: StringConstant.proposedTime,
                              description:
                                  '${formatUnixTimestamp(data.agreed_start_time ?? 0)} to ${formatUnixTimestamp(data.agreed_end_time ?? 0)}',
                            ),
                          ],
                        ),
                      ),
                    ],
                    proposedBox(
                      title: StringConstant.hourlyRate,
                      postedValue: allowncValue(
                        "${data.posted_hourly_rate ?? 00}",
                        isRate: true,
                      ),
                      proposedValue: allowncValue(
                        "${data.proposed_hourly_rate ?? 00}",
                        isRate: true,
                      ),
                      counterProposalValue: allowncValue(
                        "${data.counter_proposal_hourly_rate ?? ""}",
                        isRate: true,
                      ),
                    ),
                    if (data.commute_allowance_type != 0) ...[
                      SizedBox(height: getSize(10)),
                      Builder(builder: (context) {
                        final hourly = data.commute_allowance_type == 2;
                        String postedDescription,
                            proposedDescription,
                            counterProposedDescription;
                        if (hourly) {
                          postedDescription =
                              data.posted_commute_allowance_hour_name ?? "";
                          proposedDescription =
                              data.proposed_commute_allowance_hour_name ?? "";
                          counterProposedDescription =
                              data.counter_commute_allowance_hour_name ?? "";
                        } else {
                          postedDescription =
                              "\$${data.posted_commute_allowance_rate ?? ""}";
                          proposedDescription =
                              "\$${data.proposed_commute_allowance_rate ?? ""}";
                          counterProposedDescription = (data
                                      .counter_commute_allowance_rate !=
                                  null)
                              ? "\$${data.counter_commute_allowance_rate ?? ""}"
                              : "";
                        }
                        return proposedBox(
                          title: StringConstant.commuteAllowance,
                          postedValue: postedDescription,
                          proposedValue: proposedDescription,
                          counterProposalValue: counterProposedDescription,
                        );
                      }),
                    ],
                    if (data.accommodation_allowance_type != 0) ...[
                      SizedBox(height: getSize(10)),
                      Builder(builder: (context) {
                        final isCommuteAllowanceHourly =
                            data.accommodation_allowance_type == 2;
                        String postedDescription,
                            proposedDescription,
                            counterProposedDescription;

                        if (isCommuteAllowanceHourly) {
                          postedDescription =
                              data.posted_accommodation_allowance_hour_name ??
                                  "";
                          proposedDescription =
                              data.proposed_accommodation_allowance_hour_name ??
                                  "";
                          counterProposedDescription =
                              data.counter_accommodation_allowance_hour_name ??
                                  "";
                        } else {
                          postedDescription =
                              "\$${data.posted_accommodation_allowance_rate ?? ""}";
                          proposedDescription =
                              "\$${data.proposed_accommodation_allowance_rate ?? ""}";
                          counterProposedDescription = (data
                                      .counter_accommodation_allowance_rate !=
                                  null)
                              ? "\$${data.counter_accommodation_allowance_rate ?? ""}"
                              : "";
                        }
                        return proposedBox(
                          title: StringConstant.accommodationAllowance,
                          postedValue: postedDescription,
                          proposedValue: proposedDescription,
                          counterProposalValue: counterProposedDescription,
                        );
                      }),
                    ],
                    SizedBox(height: getSize(40)),
                    if (user.sent_received_status != 2) ...[
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              onPressed: (user.occupied == true ||
                                      user.accept_btn_toggle == false)
                                  ? () {}
                                  : () async {
                                      if ((state.confirmDialog == null ||
                                              state.confirmDialog == false) &&
                                          data.shift_type == 2) {
                                        await showDialog<bool?>(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              contentPadding:
                                                  EdgeInsets.all(30),
                                              insetPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              backgroundColor: Colors.white,
                                              content: BaseText(
                                                textAlign: TextAlign.center,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                text: StringConstant
                                                    .proposalAvailabilityConfirmationDesc,
                                              ),
                                              actions: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 30),
                                                  child: CommonButton(
                                                    onPressed: () async {
                                                      context.router.maybePop();
                                                      await context.router
                                                          .push(
                                                        PageRouteInfo(
                                                          EmployerAvailabilityView
                                                              .name,
                                                          args: EmployerAvailabilityViewArgs(
                                                              list:
                                                                  data.shift_details ??
                                                                      [],
                                                              confirmDialog:
                                                                  state.confirmDialog ??
                                                                      false),
                                                        ),
                                                      )
                                                          .then((result) {
                                                        context
                                                            .read<
                                                                ProposalDetailBloc>()
                                                            .add(ProposalDetailEvent
                                                                .addConfirmDialogFlag(
                                                                    result
                                                                        as bool));
                                                      });
                                                    },
                                                    buttonText:
                                                        StringConstant.ok,
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        if (data.isCardAdded == false) {
                                          CommonCardDialog(
                                            title: StringConstant.cardDetails,
                                            description: StringConstant
                                                .pleaseAddYourCardDetailsToProceed,
                                            buttonText: StringConstant.addCard,
                                            onPressed: () {
                                              context.router.maybePop();
                                              context.router
                                                  .push(PageRouteInfo(
                                                      AddCardDetailPage.name,
                                                      args:
                                                          AddCardDetailPageArgs(
                                                              fromRegister:
                                                                  false)))
                                                  .then((value) {
                                                if (value != null &&
                                                    value == true) {
                                                  acceptDialog(context);
                                                }
                                              });
                                            },
                                            image: SvgImageConstant.cardImage,
                                          ).addCardDialog(context);
                                        } else {
                                          acceptDialog(context);
                                        }
                                      }
                                    },
                              buttonText: StringConstant.accept,
                              buttonFontSize: 16,
                              borderRadius: 10,
                              height: 46,
                              backgroundColor: (user.occupied == true ||
                                      user.accept_btn_toggle == false)
                                  ? AppColors.green.withValues(alpha: 0.2)
                                  : null,
                            ),
                          ),
                          SizedBox(width: getSize(16)),
                          Expanded(
                            child: CommonButton(
                              onPressed: (user.accept_btn_toggle == false)
                                  ? () {}
                                  : () {
                                      AcceptRejectDialog(
                                        title: StringConstant.reject,
                                        description:
                                            StringConstant.rejectProposaDesc,
                                        onPressedAccept: () {
                                          context.router.maybePop().then(
                                            (value) {
                                              final id = context
                                                  .read<ProposalDetailBloc>()
                                                  .state
                                                  .proposalDetailDto
                                                  .id;
                                              if (id == null) return;
                                              context
                                                  .read<ProposalDetailBloc>()
                                                  .add(
                                                    ProposalDetailEvent
                                                        .proposalAcceptReject(
                                                      id: id,
                                                      request: 2,
                                                      context: context,
                                                    ),
                                                  );
                                            },
                                          );
                                        },
                                        acceptButtonText: StringConstant.reject,
                                        onPressedReject: () {
                                          context.router.maybePop();
                                        },
                                      ).acceptRejectDialog(context);
                                    },
                              backgroundColor: (user.accept_btn_toggle == false)
                                  ? AppColors.green.withValues(alpha: 0.2)
                                  : AppColors.white,
                              borderColor: (user.accept_btn_toggle == false)
                                  ? null
                                  : AppColors.green,
                              buttonTextColor: (user.accept_btn_toggle == false)
                                  ? null
                                  : AppColors.green,
                              buttonFontSize: 16,
                              borderRadius: 10,
                              buttonText: StringConstant.reject,
                              height: 46,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getSize(20)),
                      CommonButton(
                        onPressed: () async {
                          final result = await context.router.push(
                            PageRouteInfo(CounterPurposeView.name,
                                args: CounterPurposeViewArgs(data: data)),
                          ) as bool?;

                          if (result ?? false) {
                            context.router.maybePop(true);
                          }
                        },
                        buttonText: StringConstant.counterPropose,
                        borderRadius: 7,
                        buttonTextColor: AppColors.black,
                        backgroundColor: AppColors.white,
                      ),
                      SizedBox(height: getSize(20)),
                    ]
                  ],
                ),
                if (state.postDataLoading) CenterLoadingIndicator(),
              ],
            );
          },
        ),
      ),
    );
  }

  acceptDialog(BuildContext context) {
    final bloc = context.read<ProposalDetailBloc>().state;
    final firstName = bloc.proposalDetailDto.first_name;
    final lastName = bloc.proposalDetailDto.last_name;
    AcceptRejectDialog(
      title: StringConstant.confirmAccept,
      description:
          "By proceeding I confirm that I have reviewed $firstName $lastName's proposals",
      onPressedAccept: () {
        context.router.maybePop().then(
          (value) {
            final id =
                context.read<ProposalDetailBloc>().state.proposalDetailDto.id;
            if (id == null) return;
            context.read<ProposalDetailBloc>().add(
                  ProposalDetailEvent.proposalAcceptReject(
                    id: id,
                    request: 1,
                    context: context,
                  ),
                );
          },
        );
      },
      onPressedReject: () {
        context.router.maybePop();
      },
    ).acceptRejectDialog(context);
  }

  getTitleAndDescription(BuildContext context,
      {required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: title,
          fontSize: 12,
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
        return "\$$formatedValue";
      } else {
        return (isHour) ? formatedValue : "\$$formatedValue";
      }
    } else {
      return "";
    }
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
            textColor: AppColors.black.withValues(alpha: 0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getSize(20), vertical: getSize(10)),
          decoration: BoxDecoration(
            color: AppColors.grey04,
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
      color: AppColors.black.withValues(alpha: 0.30),
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
          textColor: AppColors.black.withValues(alpha: 0.7),
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

  getDetailsView({
    required String mainTitle,
    required String skills,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: mainTitle,
          textColor: AppColors.green.withValues(alpha: 0.8),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: getSize(5)),
        BaseText(
          text: skills,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

String parseUnixToFormatedString(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat("dd MMM, yyyy").format(date);
}
