// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shift/application/main_tab/shifts/hired_contractor_bloc/hired_contractor_bloc.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/infrastructure/main/hired_contractor_list_dto/hired_contractor_list_dto.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/common/widgets/center_loading_indicator.dart';
import 'package:shift/presentation/common/widgets/paginated_list_view.dart';
import 'package:shift/presentation/core/app_router.gr.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/buttons/chat_button.dart';
import 'package:shift/presentation/main/widgets/home_app_bar.dart';

@RoutePage(name: 'FilledHiredContractorList')
class FilledHiredContractorList extends StatelessWidget {
  int postId;

  FilledHiredContractorList({required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HiredContractorBloc>()
        ..add(HiredContractorEvent.getHiredFilledContractorList(
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
                                  .getHiredFilledContractorList(
                                      refresh: true, postId: postId)),
                          onLoading: () => context
                              .read<HiredContractorBloc>()
                              .add(HiredContractorEvent
                                  .getHiredFilledContractorList(
                                refresh: false,
                                postId: postId,
                              )),
                          refreshController: context
                              .read<HiredContractorBloc>()
                              .hiredContractorListController,
                          child: ListView.builder(
                              padding:
                                  EdgeInsets.symmetric(vertical: getSize(10)),
                              itemCount: state.hiredFilledContractorList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      context.router.push(
                                        PageRouteInfo(ViewApplicantProfile.name,
                                            args: ViewApplicantProfileArgs(
                                              id: state
                                                      .hiredFilledContractorList[
                                                          index]
                                                      .user_id ??
                                                  -1,
                                              postId: postId,
                                            )),
                                      );
                                    },
                                    child: contractorDetail(
                                        context,
                                        state
                                            .hiredFilledContractorList[index]));
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BaseText(
                        text:
                            '${contractor.first_name ?? ""} ${contractor.last_name ?? ""}',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(width: getSize(5)),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: getSize(14),
                      ),
                    ],
                  ),
                  SizedBox(height: getSize(5)),
                  (contractor.contractor_shift_type == 2)
                      ? GestureDetector(
                          onTap: () {
                            context.router
                                .push(PageRouteInfo(AgreedProposal.name,
                                    args: AgreedProposalArgs(
                                        // post: contractor,
                                        shiftType: contractor.shift_type ?? -1,
                                        postId: postId,
                                        userId: contractor.user_id ?? -1)));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(getSize(5)),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: getSize(5), horizontal: getSize(10)),
                            child: BaseText(
                              text: StringConstant.viewAgreedProposal,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.primaryColor,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            SvgPicture.asset(
                              SvgImageConstant.clock,
                              color: AppColors.black.withValues(alpha: 0.7),
                              height: getSize(15),
                              width: getSize(15),
                            ),
                            SizedBox(width: getSize(5)),
                            BaseText(
                              text: (contractor.start_time != null)
                                  ? DateFormat('hh:mm a').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          (contractor.start_time ?? 0) * 1000))
                                  : "",
                              fontSize: 12,
                              textColor: AppColors.black,
                            ),
                            BaseText(
                              text: ' to ',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.black,
                            ),
                            BaseText(
                              text: (contractor.end_time != null)
                                  ? DateFormat('hh:mm a').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          (contractor.end_time ?? 0) * 1000))
                                  : "",
                              fontSize: 12,
                              textColor: AppColors.black,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            Spacer(),
            ChatButton(
              badgeCount: contractor.count ?? 0,
              onPressed: () {
                // showUnderDevelopment(context);
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
                  if (contractor.count != null && (contractor.count ?? 0) > 0) {
                    context.read<HiredContractorBloc>().add(
                        HiredContractorEvent.getHiredFilledContractorList(
                            refresh: true, postId: postId));
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
