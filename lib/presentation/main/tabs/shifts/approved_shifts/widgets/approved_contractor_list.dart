// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/date_time_format.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/chat_button.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
import 'package:shift/presentation/core/widgets/dialogs/app_dialog.dart';
import 'package:shift/presentation/main/tabs/home/view_single_applicants/widgets/accept_reject_dialog.dart';
import 'package:shift/presentation/main/tabs/shifts/approved_shifts/widgets/edit_clock_time_dialog.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'ApprovedHiredList')
class ApprovedHiredList extends StatelessWidget {
  int postId;

  ApprovedHiredList({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HiredContractorBloc>()
        ..add(HiredContractorEvent.getHiredApproveContractorList(
            refresh: true, postId: postId)),
      child: BlocBuilder<HiredContractorBloc, HiredContractorState>(
        builder: (context, state) {
          return Scaffold(
              appBar: CommonAppBar(
                onBackPressed: () {
                  context.router.maybePop();
                },
                title: StringConstant.allHiredContractors,
              ),
              body: (state.isLoading)
                  ? CenterLoadingIndicator(isOnlyLoader: true)
                  : state.errorApi
                      ? Center(
                          child:
                              BaseText(text: StringConstant.somethindWentWrong))
                      : PaginatedListView(
                          onRefresh: () => context
                              .read<HiredContractorBloc>()
                              .add(HiredContractorEvent
                                  .getHiredApproveContractorList(
                                      refresh: true, postId: postId)),
                          onLoading: () => context
                              .read<HiredContractorBloc>()
                              .add(HiredContractorEvent
                                  .getHiredApproveContractorList(
                                refresh: false,
                                postId: postId,
                              )),
                          refreshController: context
                              .read<HiredContractorBloc>()
                              .hiredContractorListController,
                          child: ListView.builder(
                              padding:
                                  EdgeInsets.symmetric(vertical: getSize(10)),
                              itemCount:
                                  state.hiredApproveContractorList.length,
                              itemBuilder: (context, index) {
                                return contractorDetail(
                                  context,
                                  state,
                                  state.hiredApproveContractorList[index],
                                );
                              }),
                        ));
        },
      ),
    );
  }

  Widget contractorDetail(BuildContext context, HiredContractorState state,
      HiredContractorListDTO contractor) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: getSize(8), horizontal: getSize(20)),
      padding: EdgeInsets.all(getSize(10)),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(getSize(10)),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: AppColors.grey,
            )
          ]),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              final userId = contractor.user_id;
              final postId = contractor.post_id;

              if (userId != null && postId != null) {
                context.router.push(
                  PageRouteInfo(ViewApplicantProfile.name,
                      args: ViewApplicantProfileArgs(
                        id: userId,
                        postId: postId,
                      )),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: getSize(15),
                horizontal: getSize(15),
              ).copyWith(left: getSize(5)),
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(getSize(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: getSize(22),
                    backgroundColor: AppColors.green,
                    child: CircleAvatar(
                      backgroundColor: AppColors.scaffoldColor,
                      radius: getSize(21),
                      backgroundImage: (contractor.profile != null &&
                              contractor.profile!.isNotEmpty)
                          ? NetworkImage(contractor.profile ?? "")
                          : null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(10)),
                    child: BaseText(
                      text:
                          '${contractor.first_name ?? ""} ${contractor.last_name ?? ""}',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  ChatButton(
                      badgeCount: contractor.count ?? 0,
                      onPressed: () {
                        context.router
                            .push(
                          PageRouteInfo(
                            Message.name,
                            args: MessageArgs(
                              receiverId: contractor.user_id ?? 0,
                            ),
                          ),
                        )
                            .then((value) {
                          if (contractor.count != null &&
                              (contractor.count ?? 0) > 0) {
                            context.read<HiredContractorBloc>().add(
                                HiredContractorEvent
                                    .getHiredApproveContractorList(
                                        refresh: true, postId: postId));
                          }
                        });
                      }),
                ],
              ),
            ),
          ),
          if (contractor.contractor_shift_type == 2)
            GestureDetector(
              onTap: () {
                context.router.push(PageRouteInfo(AgreedProposal.name,
                    args: AgreedProposalArgs(
                        shiftType: contractor.shift_type ?? -1,
                        postId: postId,
                        userId: contractor.user_id ?? -1)));
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(getSize(5)),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: getSize(8), horizontal: getSize(10)),
                child: BaseText(
                  text: StringConstant.viewAgreedProposal,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.primaryColor,
                ),
              ),
            ),
          SizedBox(height: getSize(10)),
          dateTime(contractor),
          SizedBox(height: getSize(10)),
          if (contractor.clock_in_out_status == 1) ...[
            clocInOut(context, contractor),
            SizedBox(height: getSize(10)),
            (contractor.shift_complete == true)
                ? BaseText(
                    text: StringConstant.shiftApproved,
                    textColor: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )
                : Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          isSubmitting: contractor.isLoading == true,
                          height: 40,
                          onPressed: (contractor.clock_in_time != null &&
                                  contractor.clock_out_time != null)
                              ? () {
                                  approveDialog(context, contractor);
                                }
                              : () {},
                          borderRadius: 7,
                          buttonFontSize: 12,
                          buttonText: StringConstant.approve,
                          backgroundColor: (contractor.clock_in_time != null &&
                                  contractor.clock_out_time != null)
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withValues(alpha: 0.3),
                        ),
                      ),
                      SizedBox(width: getSize(10)),
                      Expanded(
                        child: CommonButton(
                          height: 40,
                          backgroundColor: AppColors.scaffoldColor,
                          borderColor: AppColors.scaffoldColor,
                          buttonTextColor: (contractor.clock_in_time != null &&
                                  contractor.clock_out_time != null)
                              ? AppColors.black
                              : AppColors.black.withValues(alpha: 0.3),
                          onPressed: (contractor.clock_in_time != null &&
                                  contractor.clock_out_time != null)
                              ? () {
                                  EditClockTimeDialog().editClockTimeDialog(
                                    context,
                                    contractor,
                                    callBack: () {
                                      context.read<HiredContractorBloc>().add(
                                          HiredContractorEvent
                                              .getHiredApproveContractorList(
                                                  refresh: true,
                                                  postId: postId));
                                    },
                                  );
                                }
                              : () {},
                          buttonFontSize: 12,
                          borderRadius: 7,
                          buttonText: StringConstant.edit,
                        ),
                      ),
                    ],
                  ),
          ] else
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: getSize(8), horizontal: getSize(20)),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(getSize(5))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BaseText(
                    text: StringConstant.awaitingClockInOutDesc,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  Gap(getSize(5)),
                  GestureDetector(
                    onTap: () {
                      AppDialog.showInfo(
                        context,
                        StringConstant.awaitingContractorApprovalDesc,
                        maxLines: 10,
                      );
                    },
                    child: SvgPicture.asset(
                      SvgImageConstant.infoCircle,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget dateTime(HiredContractorListDTO contractor) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getSize(12),
        horizontal: getSize(20),
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            SvgImageConstant.clock,
            color: AppColors.black,
            height: getSize(20),
            width: getSize(16),
          ),
          SizedBox(width: getSize(10)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: StringConstant.time,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textColor: AppColors.black.withValues(alpha: 0.7),
              ),
              BaseText(
                text:
                    "${(contractor.start_time != null) ? DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.start_time ?? 0))) : ""} to ${(contractor.end_time != null) ? DateFormat('hh:mm a').format(CustomDateTimeFormat.timeStampToDateTime((contractor.end_time ?? 0))) : ""}",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textColor: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget clocInOut(BuildContext context, HiredContractorListDTO shift) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getSize(12),
        horizontal: getSize(30),
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(getSize(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          clockTime(
            context,
            value: (shift.clock_in_time != null)
                ? DateFormat('hh:mm a').format(
                    CustomDateTimeFormat.timeStampToDateTime(
                        (shift.clock_in_time!)))
                : '--',
            title: StringConstant.clockIn,
            svgPrefixIcon: SvgImageConstant.clock,
            valueColor: (shift.clock_in_time != null)
                ? AppColors.primaryColor
                : AppColors.black,
          ),
          Spacer(),
          clockTime(
            context,
            value: (shift.clock_out_time != null)
                ? DateFormat('hh:mm a').format(
                    CustomDateTimeFormat.timeStampToDateTime(
                        (shift.clock_out_time!)))
                : "--",
            title: StringConstant.clockOut,
            svgPrefixIcon: SvgImageConstant.clock,
            valueColor: (shift.clock_out_time != null)
                ? AppColors.primaryColor
                : AppColors.black,
          ),
        ],
      ),
    );
  }

  Widget clockTime(
    BuildContext context, {
    required String title,
    required String value,
    required String svgPrefixIcon,
    bool showBtn = false,
    void Function()? onBtnPressed,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SvgPicture.asset(
          svgPrefixIcon,
          color: AppColors.black,
          height: getSize(20),
          width: getSize(16),
        ),
        SizedBox(width: getSize(10)),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: title,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              textColor: AppColors.black.withValues(alpha: 0.7),
            ),
            BaseText(
              text: (value.isNotEmpty) ? value : "--",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor: valueColor,
            ),
          ],
        ),
      ],
    );
  }

  approveDialog(BuildContext context, HiredContractorListDTO contractor) {
    AcceptRejectDialog(
      title: StringConstant.approve,
      description:
          "${StringConstant.approveShiftDesc1}${contractor.first_name ?? ""} ${contractor.last_name ?? ""}${StringConstant.approveShiftDesc2}",
      onPressedAccept: () async {
        context.router.maybePop().then(
          (value) {
            context
                .read<HiredContractorBloc>()
                .add(HiredContractorEvent.submitClockInOutTime(
                  context,
                  isEdit: false,
                  postId: contractor.post_id ?? -1,
                  userId: contractor.user_id ?? -1,
                  clockIn: contractor.clock_in_time,
                  clockOut: contractor.clock_out_time,
                ));
          },
        );
      },
      acceptButtonText: StringConstant.approve,
      onPressedReject: () {
        context.router.maybePop();
      },
    ).acceptRejectDialog(context);
  }
}
