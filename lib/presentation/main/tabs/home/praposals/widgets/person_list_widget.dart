import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shift/application/employer/proposal/total_proposal_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/core/employer_proposal_dto/employer_proposal_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/logger/logger.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/avatar.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';

class PersonListWidget extends StatelessWidget {
  const PersonListWidget({
    super.key,
    required this.postId,
  });

  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TotalProposalBloc, TotalProposalState>(
      builder: (context, state) {
        final list = state.totalProposedDataList;
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.all(getSize(20)),
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: getSize(7.5)),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              padding: EdgeInsets.all(12),
              child: InkWell(
                onTap: () async {
                  ///1 rec 2 sent
                  if (list[index].revoke_status == null &&list[index].sent_received_status==null) {
                    Log.success("postId  ${postId} userId ${list[index].user_id}");
                    final result = await context.router.push(
                      PageRouteInfo(
                        ViewPersonPraposalView.name,
                        args: ViewPersonPraposalViewArgs(postId: postId, userId: list[index].user_id ?? -1),
                      ),
                    ) as bool?;

                    if (result ?? false) {
                      context.read<TotalProposalBloc>().add(
                            TotalProposalEvent.getTotalProposalList(id: postId, isRefresh: true, context: context),
                          );
                    }
                  } else {
                    context.router.push(ViewApplicantProfile(id: list[index].user_id ?? -1, postId: postId));
                  }
                },
                child: Row(
                  children: [
                    UserAvatar(url: list[index].profile ?? ""),
                    Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisSize: MainAxisSize.min,
                            children: [
                              BaseText(
                                text: '${list[index].first_name ?? ""} ${list[index].last_name ?? ""}',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              if(list[index].revoke_status!=null)...[
                                Gap(8),
                                SvgPicture.asset(SvgImageConstant.rightArrow,height: 13,width: 13,)
                              ]
                            ],
                          ),
                          list[index].revoke_status == 1
                              ? BaseText(
                                  text: "Awaiting...",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                )
                              : list[index].revoke_status == null && list[index].sent_received_status == null || list[index].revoke_status==2
                                  ? SizedBox.shrink()
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          list[index].sent_received_status == 1 ? SvgImageConstant.receivedCircle : SvgImageConstant.rightWithCircle,
                                          height: 13,
                                          width: 13,
                                        ),
                                        Gap(4),
                                        BaseText(
                                          text: list[index].sent_received_status == 1 ? "Counter Received" : "Counter Sent",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                        ],
                      ),
                    ),
                    list[index].revoke_status == 1
                        ? CommonMaterialButton(
                            backgroundColor: AppColors.redAccent.withOpacity(0.15),
                            radius: 5,
                            width: 70,
                            height: 35,
                            onPressed: () {
                              AcceptRejectDialog(
                                title: 'Revoke',
                                description:
                                    'Once you revoke, the contractor will have a 2-hour window to confirm the shift. If they do not confirm within 2 hours, the offer will be automatically revoked.',
                                onPressedAccept: () {
                                  context.router.maybePop();
                                  final userId = state.totalProposedDataList[index].user_id ?? 0;
                                  context.read<TotalProposalBloc>().add(
                                        TotalProposalEvent.onRevoke(postId: postId, userId: userId, context: context),
                                      );
                                },
                                acceptButtonText: 'Revoke',
                                onPressedReject: () {
                                  context.router.maybePop();
                                },
                              ).acceptRejectDialog(context);
                            },
                            label: "Revoke",
                            textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                          )
                        : list[index].revoke_status == 2
                            ? revokingStatus(context, state, list[index])
                            : list[index].revoke_status == 3
                                ? Padding(
                                    padding: EdgeInsets.symmetric(vertical: getSize(10)),
                                    child: BaseText(
                                      text: StringConstant.offerRevokedByTheEmployer,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Icon(
                                    Icons.arrow_forward_rounded,
                                    color: AppColors.black,
                                  )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget revokingStatus(BuildContext context, TotalProposalState state, EmployerProposalPendingUserDto shift) {
    final hours = shift.duration?.inHours.toString().padLeft(2, '0') ?? 00;
    final minutes = shift.duration?.inMinutes.remainder(60).toString().padLeft(2, '0') ?? 00;

    return Container(
      width: getSize(108),
      padding: EdgeInsets.symmetric(vertical: getSize(5)),
      decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            SvgImageConstant.clock,
            height: getSize(15),
            width: getSize(15),
          ),
          BaseText(
            text: "$hours h $minutes min",
            fontSize: 12,
            fontWeight: FontWeight.w600,
            textColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
