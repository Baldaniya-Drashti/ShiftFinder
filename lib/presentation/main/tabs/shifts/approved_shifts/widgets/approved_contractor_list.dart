// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/utils/flushbar_creator.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/common_button.dart';
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
              body: state.isLoading
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
                                return GestureDetector(
                                    onTap: () {
                                      context.router.push(
                                        PageRouteInfo(
                                            ViewApplicantProfile.name),
                                      );
                                    },
                                    child: contractorDetail(
                                      context,
                                      state.hiredApproveContractorList[index],
                                    ));
                              }),
                        ));
        },
      ),
    );
  }

  Widget contractorDetail(
      BuildContext context, HiredContractorListDTO contractor) {
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
          Container(
            padding: EdgeInsets.symmetric(
              vertical: getSize(15),
              horizontal: getSize(15),
            ),
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
                CommonButton(
                  height: 35,
                  width: 85,
                  borderRadius: 5,
                  onPressed: () {
                    showUnderDevelopment(context);
                  },
                  backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                  buttonText: "",
                  customWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgImageConstant.chat,
                        color: AppColors.black,
                        height: getSize(15),
                        width: getSize(15),
                      ),
                      SizedBox(width: getSize(5)),
                      BaseText(
                        text: StringConstant.chat,
                        fontWeight: FontWeight.w600,
                        fontSize: getFontSize(12),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: getSize(10)),
          clocInOut(context, contractor),
          SizedBox(height: getSize(10)),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  height: 40,
                  onPressed: () {
                    showUnderDevelopment(context);
                    // approveDialog(context, contractor);
                  },
                  borderRadius: 7,
                  buttonFontSize: 12,
                  buttonText: StringConstant.approve,
                ),
              ),
              SizedBox(width: getSize(10)),
              Expanded(
                child: CommonButton(
                  height: 40,
                  backgroundColor: AppColors.scaffoldColor,
                  borderColor: AppColors.scaffoldColor,
                  buttonTextColor: AppColors.black,
                  onPressed: () {
                    EditClockTimeDialog()
                        .editClockTimeDialog(context, contractor);
                  },
                  buttonFontSize: 12,
                  borderRadius: 7,
                  buttonText: StringConstant.edit,
                ),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          clockTime(
            context,
            value: DateFormat('hh:mm a')
                .format(DateTime.fromMillisecondsSinceEpoch(-1 * 1000)),
            title: StringConstant.clockIn,
            svgPrefixIcon: SvgImageConstant.clock,
            valueColor: AppColors.primaryColor,
          ),
          Spacer(),
          clockTime(
            context,
            value: DateFormat('hh:mm a')
                .format(DateTime.fromMillisecondsSinceEpoch(-1 * 1000)),
            title: StringConstant.clockOut,
            svgPrefixIcon: SvgImageConstant.clock,
            valueColor: AppColors.primaryColor,
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
              textColor: AppColors.black.withOpacity(0.7),
            ),
            BaseText(
              text: (value.isNotEmpty) ? value : "--",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textColor:
                  (value.isNotEmpty) ? AppColors.primaryColor : AppColors.black,
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
          "${StringConstant.approveShiftDesc1}${contractor.first_name ?? ""}${StringConstant.approveShiftDesc2}",
      onPressedAccept: () async {
        await context.router.maybePop();
        successFullyApproved(context);
      },
      acceptButtonText: StringConstant.approve,
      onPressedReject: () {
        context.router.maybePop();
      },
    ).acceptRejectDialog(context);
  }

  successFullyApproved(BuildContext context) {
    showDialog<bool?>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(24).copyWith(top: 0),
          clipBehavior: Clip.none,
          insetPadding: EdgeInsets.symmetric(horizontal: getSize(20)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(getSize(15)),
          ),
          titlePadding: EdgeInsets.zero,
          title: Column(
            children: [
              SvgPicture.asset(
                SvgImageConstant.approvedWithCurved,
                fit: BoxFit.fill,
              ),
              SizedBox(height: getSize(20)),
              BaseText(
                text: "${StringConstant.approved}!",
                fontSize: 22,
                fontFamily: 'Aclonica',
              ),
            ],
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: getSize(20))
                .copyWith(top: getSize(10)),
            child: BaseText(
              text: StringConstant.approvedDesc,
              fontSize: 14,
              textAlign: TextAlign.center,
              textColor: AppColors.black.withOpacity(0.7),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            CommonButton(
              height: 46,
              width: 200,
              onPressed: () {
                context.router.maybePop(true);
              },
              buttonText: StringConstant.ok,
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        context.router.push(PageRouteInfo(ShiftActionsView.name));
      }
    });
  }
}
